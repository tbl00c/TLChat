/*
** 2000-05-29
**
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
**
*************************************************************************
** Driver template for the LEMON parser generator.
**
** The "lemon" program processes an LALR(1) input grammar file, then uses
** this template to construct a parser.  The "lemon" program inserts text
** at each "%%" line.  Also, any "P-a-r-s-e" identifer prefix (without the
** interstitial "-" characters) contained in this template is changed into
** the value of the %name directive from the grammar.  Otherwise, the content
** of this template is copied straight through into the generate parser
** source file.
**
** The following is the concatenation of all %include directives from the
** input grammar file:
*/
#include <stdio.h>
/************ Begin %include sections from the grammar ************************/
#line 48 "parse.y"

#include "sqliteInt.h"

/*
** Disable all error recovery processing in the parser push-down
** automaton.
*/
#define YYNOERRORRECOVERY 1

/*
** Make yytestcase() the same as testcase()
*/
#define yytestcase(X) testcase(X)

/*
** Indicate that sqlite3ParserFree() will never be called with a null
** pointer.
*/
#define YYPARSEFREENEVERNULL 1

/*
** Alternative datatype for the argument to the malloc() routine passed
** into sqlite3ParserAlloc().  The default is size_t.
*/
#define YYMALLOCARGTYPE  u64

/*
** An instance of this structure holds information about the
** LIMIT clause of a SELECT statement.
*/
struct LimitVal {
  Expr *pLimit;    /* The LIMIT expression.  NULL if there is no limit */
  Expr *pOffset;   /* The OFFSET expression.  NULL if there is none */
};

/*
** An instance of the following structure describes the event of a
** TRIGGER.  "a" is the event type, one of TK_UPDATE, TK_INSERT,
** TK_DELETE, or TK_INSTEAD.  If the event is of the form
**
**      UPDATE ON (a,b,c)
**
** Then the "b" IdList records the list "a,b,c".
*/
struct TrigEvent { int a; IdList * b; };

/*
** Disable lookaside memory allocation for objects that might be
** shared across database connections.
*/
static void disableLookaside(Parse *pParse){
  pParse->disableLookaside++;
  pParse->db->lookaside.bDisable++;
}

#line 402 "parse.y"

  /*
  ** For a compound SELECT statement, make sure p->pPrior->pNext==p for
  ** all elements in the list.  And make sure list length does not exceed
  ** SQLITE_LIMIT_COMPOUND_SELECT.
  */
  static void parserDoubleLinkSelect(Parse *pParse, Select *p){
    if( p->pPrior ){
      Select *pNext = 0, *pLoop;
      int mxSelect, cnt = 0;
      for(pLoop=p; pLoop; pNext=pLoop, pLoop=pLoop->pPrior, cnt++){
        pLoop->pNext = pNext;
        pLoop->selFlags |= SF_Compound;
      }
      if( (p->selFlags & SF_MultiValue)==0 && 
        (mxSelect = pParse->db->aLimit[SQLITE_LIMIT_COMPOUND_SELECT])>0 &&
        cnt>mxSelect
      ){
        sqlite3ErrorMsg(pParse, "too many terms in compound SELECT");
      }
    }
  }
#line 825 "parse.y"

  /* This is a utility routine used to set the ExprSpan.zStart and
  ** ExprSpan.zEnd values of pOut so that the span covers the complete
  ** range of text beginning with pStart and going to the end of pEnd.
  */
  static void spanSet(ExprSpan *pOut, Token *pStart, Token *pEnd){
    pOut->zStart = pStart->z;
    pOut->zEnd = &pEnd->z[pEnd->n];
  }

  /* Construct a new Expr object from a single identifier.  Use the
  ** new Expr to populate pOut.  Set the span of pOut to be the identifier
  ** that created the expression.
  */
  static void spanExpr(ExprSpan *pOut, Parse *pParse, int op, Token t){
    Expr *p = sqlite3DbMallocRawNN(pParse->db, sizeof(Expr)+t.n+1);
    if( p ){
      memset(p, 0, sizeof(Expr));
      p->op = (u8)op;
      p->flags = EP_Leaf;
      p->iAgg = -1;
      p->u.zToken = (char*)&p[1];
      memcpy(p->u.zToken, t.z, t.n);
      p->u.zToken[t.n] = 0;
      if( sqlite3Isquote(p->u.zToken[0]) ){
        if( p->u.zToken[0]=='"' ) p->flags |= EP_DblQuoted;
        sqlite3Dequote(p->u.zToken);
      }
#if SQLITE_MAX_EXPR_DEPTH>0
      p->nHeight = 1;
#endif  
    }
    pOut->pExpr = p;
    pOut->zStart = t.z;
    pOut->zEnd = &t.z[t.n];
  }
#line 941 "parse.y"

  /* This routine constructs a binary expression node out of two ExprSpan
  ** objects and uses the result to populate a new ExprSpan object.
  */
  static void spanBinaryExpr(
    Parse *pParse,      /* The parsing context.  Errors accumulate here */
    int op,             /* The binary operation */
    ExprSpan *pLeft,    /* The left operand, and output */
    ExprSpan *pRight    /* The right operand */
  ){
    pLeft->pExpr = sqlite3PExpr(pParse, op, pLeft->pExpr, pRight->pExpr, 0);
    pLeft->zEnd = pRight->zEnd;
  }

  /* If doNot is true, then add a TK_NOT Expr-node wrapper around the
  ** outside of *ppExpr.
  */
  static void exprNot(Parse *pParse, int doNot, ExprSpan *pSpan){
    if( doNot ){
      pSpan->pExpr = sqlite3PExpr(pParse, TK_NOT, pSpan->pExpr, 0, 0);
    }
  }
#line 1015 "parse.y"

  /* Construct an expression node for a unary postfix operator
  */
  static void spanUnaryPostfix(
    Parse *pParse,         /* Parsing context to record errors */
    int op,                /* The operator */
    ExprSpan *pOperand,    /* The operand, and output */
    Token *pPostOp         /* The operand token for setting the span */
  ){
    pOperand->pExpr = sqlite3PExpr(pParse, op, pOperand->pExpr, 0, 0);
    pOperand->zEnd = &pPostOp->z[pPostOp->n];
  }                           
#line 1032 "parse.y"

  /* A routine to convert a binary TK_IS or TK_ISNOT expression into a
  ** unary TK_ISNULL or TK_NOTNULL expression. */
  static void binaryToUnaryIfNull(Parse *pParse, Expr *pY, Expr *pA, int op){
    sqlite3 *db = pParse->db;
    if( pA && pY && pY->op==TK_NULL ){
      pA->op = (u8)op;
      sqlite3ExprDelete(db, pA->pRight);
      pA->pRight = 0;
    }
  }
#line 1060 "parse.y"

  /* Construct an expression node for a unary prefix operator
  */
  static void spanUnaryPrefix(
    ExprSpan *pOut,        /* Write the new expression node here */
    Parse *pParse,         /* Parsing context to record errors */
    int op,                /* The operator */
    ExprSpan *pOperand,    /* The operand */
    Token *pPreOp         /* The operand token for setting the span */
  ){
    pOut->zStart = pPreOp->z;
    pOut->pExpr = sqlite3PExpr(pParse, op, pOperand->pExpr, 0, 0);
    pOut->zEnd = pOperand->zEnd;
  }
#line 1272 "parse.y"

  /* Add a single new term to an ExprList that is used to store a
  ** list of identifiers.  Report an error if the ID list contains
  ** a COLLATE clause or an ASC or DESC keyword, except ignore the
  ** error while parsing a legacy schema.
  */
  static ExprList *parserAddExprIdListTerm(
    Parse *pParse,
    ExprList *pPrior,
    Token *pIdToken,
    int hasCollate,
    int sortOrder
  ){
    ExprList *p = sqlite3ExprListAppend(pParse, pPrior, 0);
    if( (hasCollate || sortOrder!=SQLITE_SO_UNDEFINED)
        && pParse->db->init.busy==0
    ){
      sqlite3ErrorMsg(pParse, "syntax error after column name \"%.*s\"",
                         pIdToken->n, pIdToken->z);
    }
    sqlite3ExprListSetName(pParse, p, pIdToken, 1);
    return p;
  }
#line 231 "parse.c"
/**************** End of %include directives **********************************/
/* These constants specify the various numeric values for terminal symbols
** in a format understandable to "makeheaders".  This section is blank unless
** "lemon" is run with the "-m" command-line option.
***************** Begin makeheaders token definitions *************************/
/**************** End makeheaders token definitions ***************************/

/* The next sections is a series of control #defines.
** various aspects of the generated parser.
**    YYCODETYPE         is the data type used to store the integer codes
**                       that represent terminal and non-terminal symbols.
**                       "unsigned char" is used if there are fewer than
**                       256 symbols.  Larger types otherwise.
**    YYNOCODE           is a number of type YYCODETYPE that is not used for
**                       any terminal or nonterminal symbol.
**    YYFALLBACK         If defined, this indicates that one or more tokens
**                       (also known as: "terminal symbols") have fall-back
**                       values which should be used if the original symbol
**                       would not parse.  This permits keywords to sometimes
**                       be used as identifiers, for example.
**    YYACTIONTYPE       is the data type used for "action codes" - numbers
**                       that indicate what to do in response to the next
**                       token.
**    sqlite3ParserTOKENTYPE     is the data type used for minor type for terminal
**                       symbols.  Background: A "minor type" is a semantic
**                       value associated with a terminal or non-terminal
**                       symbols.  For example, for an "ID" terminal symbol,
**                       the minor type might be the name of the identifier.
**                       Each non-terminal can have a different minor type.
**                       Terminal symbols all have the same minor type, though.
**                       This macros defines the minor type for terminal 
**                       symbols.
**    YYMINORTYPE        is the data type used for all minor types.
**                       This is typically a union of many types, one of
**                       which is sqlite3ParserTOKENTYPE.  The entry in the union
**                       for terminal symbols is called "yy0".
**    YYSTACKDEPTH       is the maximum depth of the parser's stack.  If
**                       zero the stack is dynamically sized using realloc()
**    sqlite3ParserARG_SDECL     A static variable declaration for the %extra_argument
**    sqlite3ParserARG_PDECL     A parameter declaration for the %extra_argument
**    sqlite3ParserARG_STORE     Code to store %extra_argument into yypParser
**    sqlite3ParserARG_FETCH     Code to extract %extra_argument from yypParser
**    YYERRORSYMBOL      is the code number of the error symbol.  If not
**                       defined, then do no error processing.
**    YYNSTATE           the combined number of states.
**    YYNRULE            the number of rules in the grammar
**    YY_MAX_SHIFT       Maximum value for shift actions
**    YY_MIN_SHIFTREDUCE Minimum value for shift-reduce actions
**    YY_MAX_SHIFTREDUCE Maximum value for shift-reduce actions
**    YY_MIN_REDUCE      Maximum value for reduce actions
**    YY_ERROR_ACTION    The yy_action[] code for syntax error
**    YY_ACCEPT_ACTION   The yy_action[] code for accept
**    YY_NO_ACTION       The yy_action[] code for no-op
*/
#ifndef INTERFACE
# define INTERFACE 1
#endif
/************* Begin control #defines *****************************************/
#define YYCODETYPE unsigned char
#define YYNOCODE 252
#define YYACTIONTYPE unsigned short int
#define YYWILDCARD 96
#define sqlite3ParserTOKENTYPE Token
typedef union {
  int yyinit;
  sqlite3ParserTOKENTYPE yy0;
  Expr* yy72;
  TriggerStep* yy145;
  ExprList* yy148;
  SrcList* yy185;
  ExprSpan yy190;
  int yy194;
  Select* yy243;
  IdList* yy254;
  With* yy285;
  struct TrigEvent yy332;
  struct LimitVal yy354;
  struct {int value; int mask;} yy497;
} YYMINORTYPE;
#ifndef YYSTACKDEPTH
#define YYSTACKDEPTH 100
#endif
#define sqlite3ParserARG_SDECL Parse *pParse;
#define sqlite3ParserARG_PDECL ,Parse *pParse
#define sqlite3ParserARG_FETCH Parse *pParse = yypParser->pParse
#define sqlite3ParserARG_STORE yypParser->pParse = pParse
#define YYFALLBACK 1
#define YYNSTATE             460
#define YYNRULE              332
#define YY_MAX_SHIFT         459
#define YY_MIN_SHIFTREDUCE   672
#define YY_MAX_SHIFTREDUCE   1003
#define YY_MIN_REDUCE        1004
#define YY_MAX_REDUCE        1335
#define YY_ERROR_ACTION      1336
#define YY_ACCEPT_ACTION     1337
#define YY_NO_ACTION         1338
/************* End control #defines *******************************************/

/* Define the yytestcase() macro to be a no-op if is not already defined
** otherwise.
**
** Applications can choose to define yytestcase() in the %include section
** to a macro that can assist in verifying code coverage.  For production
** code the yytestcase() macro should be turned off.  But it is useful
** for testing.
*/
#ifndef yytestcase
# define yytestcase(X)
#endif


/* Next are the tables used to determine what action to take based on the
** current state and lookahead token.  These tables are used to implement
** functions that take a state number and lookahead value and return an
** action integer.  
**
** Suppose the action integer is N.  Then the action is determined as
** follows
**
**   0 <= N <= YY_MAX_SHIFT             Shift N.  That is, push the lookahead
**                                      token onto the stack and goto state N.
**
**   N between YY_MIN_SHIFTREDUCE       Shift to an arbitrary state then
**     and YY_MAX_SHIFTREDUCE           reduce by rule N-YY_MIN_SHIFTREDUCE.
**
**   N between YY_MIN_REDUCE            Reduce by rule N-YY_MIN_REDUCE
**     and YY_MAX_REDUCE
**
**   N == YY_ERROR_ACTION               A syntax error has occurred.
**
**   N == YY_ACCEPT_ACTION              The parser accepts its input.
**
**   N == YY_NO_ACTION                  No such action.  Denotes unused
**                                      slots in the yy_action[] table.
**
** The action table is constructed as a single large table named yy_action[].
** Given state S and lookahead X, the action is computed as either:
**
**    (A)   N = yy_action[ yy_shift_ofst[S] + X ]
**    (B)   N = yy_default[S]
**
** The (A) formula is preferred.  The B formula is used instead if:
**    (1)  The yy_shift_ofst[S]+X value is out of range, or
**    (2)  yy_lookahead[yy_shift_ofst[S]+X] is not equal to X, or
**    (3)  yy_shift_ofst[S] equal YY_SHIFT_USE_DFLT.
** (Implementation note: YY_SHIFT_USE_DFLT is chosen so that
** YY_SHIFT_USE_DFLT+X will be out of range for all possible lookaheads X.
** Hence only tests (1) and (2) need to be evaluated.)
**
** The formulas above are for computing the action when the lookahead is
** a terminal symbol.  If the lookahead is a non-terminal (as occurs after
** a reduce action) then the yy_reduce_ofst[] array is used in place of
** the yy_shift_ofst[] array and YY_REDUCE_USE_DFLT is used in place of
** YY_SHIFT_USE_DFLT.
**
** The following are the tables generated in this section:
**
**  yy_action[]        A single table containing all actions.
**  yy_lookahead[]     A table containing the lookahead for each entry in
**                     yy_action.  Used to detect hash collisions.
**  yy_shift_ofst[]    For each state, the offset into yy_action for
**                     shifting terminals.
**  yy_reduce_ofst[]   For each state, the offset into yy_action for
**                     shifting non-terminals after a reduce.
**  yy_default[]       Default action for each state.
**
*********** Begin parsing tables **********************************************/
#define YY_ACTTAB_COUNT (1570)
static const YYACTIONTYPE yy_action[] = {
 /*     0 */   329,  836,  355,  829,    5,  203,  203,  823,   99,  100,
 /*    10 */    90,  846,  846,  858,  861,  850,  850,   97,   97,   98,
 /*    20 */    98,   98,   98,  305,   96,   96,   96,   96,   95,   95,
 /*    30 */    94,   94,   94,   93,  355,  329,  981,  981,  828,  828,
 /*    40 */   830,  951,  358,   99,  100,   90,  846,  846,  858,  861,
 /*    50 */   850,  850,   97,   97,   98,   98,   98,   98,  342,   96,
 /*    60 */    96,   96,   96,   95,   95,   94,   94,   94,   93,  355,
 /*    70 */    95,   95,   94,   94,   94,   93,  355,  795,  981,  981,
 /*    80 */   329,   94,   94,   94,   93,  355,  796,   75,   99,  100,
 /*    90 */    90,  846,  846,  858,  861,  850,  850,   97,   97,   98,
 /*   100 */    98,   98,   98,  454,   96,   96,   96,   96,   95,   95,
 /*   110 */    94,   94,   94,   93,  355, 1337,  155,  155,    2,  329,
 /*   120 */   279,  146,  132,   52,   52,   93,  355,   99,  100,   90,
 /*   130 */   846,  846,  858,  861,  850,  850,   97,   97,   98,   98,
 /*   140 */    98,   98,  101,   96,   96,   96,   96,   95,   95,   94,
 /*   150 */    94,   94,   93,  355,  962,  962,  329,  272,  432,  417,
 /*   160 */   415,   61,  756,  756,   99,  100,   90,  846,  846,  858,
 /*   170 */   861,  850,  850,   97,   97,   98,   98,   98,   98,   60,
 /*   180 */    96,   96,   96,   96,   95,   95,   94,   94,   94,   93,
 /*   190 */   355,  329,  274,  333,  277,  281,  963,  964,  250,   99,
 /*   200 */   100,   90,  846,  846,  858,  861,  850,  850,   97,   97,
 /*   210 */    98,   98,   98,   98,  305,   96,   96,   96,   96,   95,
 /*   220 */    95,   94,   94,   94,   93,  355,  329,  942, 1330,  702,
 /*   230 */   710, 1330,  242,  416,   99,  100,   90,  846,  846,  858,
 /*   240 */   861,  850,  850,   97,   97,   98,   98,   98,   98,  351,
 /*   250 */    96,   96,   96,   96,   95,   95,   94,   94,   94,   93,
 /*   260 */   355,  329,  942, 1331,  388,  703, 1331,  385,  383,   99,
 /*   270 */   100,   90,  846,  846,  858,  861,  850,  850,   97,   97,
 /*   280 */    98,   98,   98,   98,  705,   96,   96,   96,   96,   95,
 /*   290 */    95,   94,   94,   94,   93,  355,  329,   92,   89,  178,
 /*   300 */   837,  940,  377,  704,   99,  100,   90,  846,  846,  858,
 /*   310 */   861,  850,  850,   97,   97,   98,   98,   98,   98,  379,
 /*   320 */    96,   96,   96,   96,   95,   95,   94,   94,   94,   93,
 /*   330 */   355,  329, 1280,  951,  358,  822,  940,  743,  743,   99,
 /*   340 */   100,   90,  846,  846,  858,  861,  850,  850,   97,   97,
 /*   350 */    98,   98,   98,   98,  230,   96,   96,   96,   96,   95,
 /*   360 */    95,   94,   94,   94,   93,  355,  329,  973,  227,   92,
 /*   370 */    89,  178,  377,  304,   99,  100,   90,  846,  846,  858,
 /*   380 */   861,  850,  850,   97,   97,   98,   98,   98,   98,  925,
 /*   390 */    96,   96,   96,   96,   95,   95,   94,   94,   94,   93,
 /*   400 */   355,  329,  453,  451,  451,  451,  147,  741,  741,   99,
 /*   410 */   100,   90,  846,  846,  858,  861,  850,  850,   97,   97,
 /*   420 */    98,   98,   98,   98,  300,   96,   96,   96,   96,   95,
 /*   430 */    95,   94,   94,   94,   93,  355,  329,  423,  231,  962,
 /*   440 */   962,  158,   25,  426,   99,  100,   90,  846,  846,  858,
 /*   450 */   861,  850,  850,   97,   97,   98,   98,   98,   98,  454,
 /*   460 */    96,   96,   96,   96,   95,   95,   94,   94,   94,   93,
 /*   470 */   355,  447,  224,  224,  424,  962,  962,  966,  329,   52,
 /*   480 */    52,  963,  964,  176,  419,   78,   99,  100,   90,  846,
 /*   490 */   846,  858,  861,  850,  850,   97,   97,   98,   98,   98,
 /*   500 */    98,  383,   96,   96,   96,   96,   95,   95,   94,   94,
 /*   510 */    94,   93,  355,  329,  432,  422,  302,  963,  964,  966,
 /*   520 */    81,   99,   88,   90,  846,  846,  858,  861,  850,  850,
 /*   530 */    97,   97,   98,   98,   98,   98,  721,   96,   96,   96,
 /*   540 */    96,   95,   95,   94,   94,   94,   93,  355,  329,  847,
 /*   550 */   847,  859,  862, 1000,  322,  347,  383,  100,   90,  846,
 /*   560 */   846,  858,  861,  850,  850,   97,   97,   98,   98,   98,
 /*   570 */    98,  454,   96,   96,   96,   96,   95,   95,   94,   94,
 /*   580 */    94,   93,  355,  329,  354,  354,  354,  264,  381,  344,
 /*   590 */   933,   52,   52,   90,  846,  846,  858,  861,  850,  850,
 /*   600 */    97,   97,   98,   98,   98,   98,  365,   96,   96,   96,
 /*   610 */    96,   95,   95,   94,   94,   94,   93,  355,   86,  449,
 /*   620 */   851,    3, 1207,  365,  364,  382,  348,  817,  962,  962,
 /*   630 */  1304,   86,  449,  733,    3,  212,  169,  291,  409,  286,
 /*   640 */   408,  199,  232,  454,  304,  764,   83,   84,  284,  245,
 /*   650 */   266,  369,  253,   85,  356,  356,   92,   89,  178,   83,
 /*   660 */    84,  242,  416,   52,   52,  452,   85,  356,  356,  246,
 /*   670 */   963,  964,  194,  459,  674,  406,  403,  402,  452,  243,
 /*   680 */   221,  114,  438,  780,  365,  454,  401,  272,  751,  224,
 /*   690 */   224,  132,  132,  198,  836,  438,  456,  455,  432,  431,
 /*   700 */   823,  419,  738,  717,  132,   52,   52,  836,  272,  456,
 /*   710 */   455,  738,  194,  823,  367,  406,  403,  402,  454, 1275,
 /*   720 */  1275,   23,  962,  962,   86,  449,  401,    3,  228,  433,
 /*   730 */   899,  828,  828,  830,  831,   19,  203,  724,   52,   52,
 /*   740 */   432,  412,  443,  249,  828,  828,  830,  831,   19,  229,
 /*   750 */   407,  153,   83,   84,  765,  177,  241,  454,  725,   85,
 /*   760 */   356,  356,  120,  157,  963,  964,   58,  981,  413,  359,
 /*   770 */   334,  452,  272,  432,  434,  324,  794,   32,   32,   86,
 /*   780 */   449,  780,    3,  345,   98,   98,   98,   98,  438,   96,
 /*   790 */    96,   96,   96,   95,   95,   94,   94,   94,   93,  355,
 /*   800 */   836,  120,  456,  455,  817,  891,  823,   83,   84,  981,
 /*   810 */   817,  132,  414,  924,   85,  356,  356,  132,  411,  793,
 /*   820 */   962,  962,   92,   89,  178,  921,  452,  266,  374,  265,
 /*   830 */    82,  918,   80,  266,  374,  265,  780,  828,  828,  830,
 /*   840 */   831,   19,  938,  438,   96,   96,   96,   96,   95,   95,
 /*   850 */    94,   94,   94,   93,  355,  836,   74,  456,  455,  962,
 /*   860 */   962,  823,  963,  964,  120,   92,   89,  178,  949,    2,
 /*   870 */   922,  969,  272,    1,  980,   76,  449,  766,    3,  712,
 /*   880 */   905,  905,  391,  962,  962,  761,  923,  375,  744,  782,
 /*   890 */   760,  261,  828,  828,  830,  831,   19,  421,  745,  454,
 /*   900 */    24,  963,  964,   83,   84,  373,  962,  962,  177,  226,
 /*   910 */    85,  356,  356,  889,  319,  318,  317,  215,  315,   10,
 /*   920 */    10,  687,  452,  353,  352,  963,  964,  913,  781,  157,
 /*   930 */   120,  962,  962,  341,  780,  420,  715,  314,  454,  438,
 /*   940 */   454,  325,  454,  795,  103,  200,  175,  454,  963,  964,
 /*   950 */   912,  836,  796,  456,  455,    9,    9,  823,   10,   10,
 /*   960 */    52,   52,   51,   51,  180,  720,  248,   10,   10,  171,
 /*   970 */   170,  167,  343,  963,  964,  247,  988,  706,  706,  454,
 /*   980 */   719,  233,  690,  986,  893,  987,  182,  918,  828,  828,
 /*   990 */   830,  831,   19,  183,  260,  427,  132,  181,  398,   10,
 /*  1000 */    10,  893,  895,  753,  962,  962,  921,  272,  989,  198,
 /*  1010 */   989,  353,  352,  429,  419,  303,  821,  836,  330,  829,
 /*  1020 */   120,  336,  133,  823,  272,   98,   98,   98,   98,   91,
 /*  1030 */    96,   96,   96,   96,   95,   95,   94,   94,   94,   93,
 /*  1040 */   355,  157,  814,  375,  386,  363,  963,  964,  362,  272,
 /*  1050 */   454,  922,  372,  328,  828,  828,  830,  454,  713,  454,
 /*  1060 */   268,  384,  893,  454,  881,  750,  257,  923,  259,  437,
 /*  1070 */    36,   36,  234,  454,  234,  120,  273,   37,   37,   12,
 /*  1080 */    12,  338,  276,   27,   27,  454,  334,  118,  454,  162,
 /*  1090 */   746,  284,  454,   38,   38,  454,  989,  360,  989,  454,
 /*  1100 */   713, 1214,  454,  132,  454,   39,   39,  454,   40,   40,
 /*  1110 */   454,  366,   41,   41,  454,   42,   42,  454,  258,   28,
 /*  1120 */    28,  454,   29,   29,   31,   31,  454,   43,   43,  454,
 /*  1130 */    44,   44,  454,  718,   45,   45,  454,   11,   11,  771,
 /*  1140 */   454,   46,   46,  454,  272,  454,  105,  105,  454,   47,
 /*  1150 */    47,  454,   48,   48,  454,  237,   33,   33,  454,  172,
 /*  1160 */    49,   49,  454,   50,   50,   34,   34,  278,  122,  122,
 /*  1170 */   454,  123,  123,  454,  124,  124,  454,  902,   56,   56,
 /*  1180 */   454,  901,   35,   35,  454,  271,  454,  821,  454,  821,
 /*  1190 */   106,  106,  454,   53,   53,  389,  107,  107,  454,  821,
 /*  1200 */   108,  108,  821,  454,  104,  104,  121,  121,  119,  119,
 /*  1210 */   454,  117,  112,  112,  454,  280,  454,  225,  111,  111,
 /*  1220 */   454,  734,  454,  109,  109,  454,  677,  678,  679,  916,
 /*  1230 */   110,  110,  321, 1002,   55,   55,   57,   57,  696,  335,
 /*  1240 */    54,   54,   26,   26,  700,   30,   30,  321,  941,  197,
 /*  1250 */   196,  195,  339,  285,  340,  450,  335,  749,  693,  440,
 /*  1260 */   444,  448,  120,   72,  390,  223,  175,  349,  761,  937,
 /*  1270 */    20,  290,  323,  760,  819,  376,  378,  202,  202,  202,
 /*  1280 */   267,  399,  289,   74,  208,   21,  700,  723,  722,  888,
 /*  1290 */   120,  120,  120,  120,  120,  758,  282,  832,   77,   74,
 /*  1300 */   730,  731,  789,  787,  884,  202, 1003,  208,  898,  897,
 /*  1310 */   898,  897,  698,  820,  767,  116,  778, 1294,  435,  436,
 /*  1320 */   306, 1003,  394,  307,  827,  701,  695,  684,  159,  293,
 /*  1330 */   683,  888,  685,  956,  295,  218,  297,    7,  320,  832,
 /*  1340 */   173,  252,  263,  368,  256,  915,  380,  717,  299,  439,
 /*  1350 */   312,  168,  959,  997,  135,  404,  994,  288,  886,  885,
 /*  1360 */   205,  932,  930,   59,  337,   62,  144,  156,  102,  430,
 /*  1370 */   809,   72,  130,  251,  137,  370,  371,  397,  185,  160,
 /*  1380 */   387,  189,   67,  393,  139,  140,  141,  779,  142,  148,
 /*  1390 */   816,  806,  255,  900,  254,  270,  219,  154,  190,  917,
 /*  1400 */   880,  395,  410,  275,  326,  191,  737,  736,  686,  735,
 /*  1410 */   346,  728,  192,  327,  715,  425,    6,   71,  350,   79,
 /*  1420 */   775,  292,  204,  776,  709,  774,  294,  296,  301,  773,
 /*  1430 */   287,  708,  866,  298,  707,  971,  757,  213,  428,  442,
 /*  1440 */   238,  727,  446,   73,  239,  240,  692,   22,  957,  457,
 /*  1450 */   214,  216,  217,  458,  681,  680,  675,  125,  115,  126,
 /*  1460 */   673,  235,  357,  166,  127,  244,  179,  361,  308,  309,
 /*  1470 */   310,  311,  896,  113,  815,  331,  894,  136,  128,  332,
 /*  1480 */   747,  138,  262,  911,  143,  184,  145,   63,  129,   64,
 /*  1490 */   914,   65,   66,  186,  187,  910,    8,   13,  188,  903,
 /*  1500 */   202,  991,  269,  149,  392,  150,  689,  161,  396,  289,
 /*  1510 */   193,  283,  151,  134,   68,  400,  405,   14,   15,  726,
 /*  1520 */    69,  236,  835,  834,  864,  755,  131,   16,   70,  759,
 /*  1530 */     4,  201,  174,  418,  220,  222,  788,  152,  868,  783,
 /*  1540 */    77,   17,   74,   18,  879,  865,  863,  920,  210,  919,
 /*  1550 */   207,  206,  946,  163,  441,  211,  947,  164,  209,  165,
 /*  1560 */   445,  867,  833,  699,   87, 1296, 1295,  313,  316,  952,
};
static const YYCODETYPE yy_lookahead[] = {
 /*     0 */    19,   95,   53,   97,   22,   24,   24,  101,   27,   28,
 /*    10 */    29,   30,   31,   32,   33,   34,   35,   36,   37,   38,
 /*    20 */    39,   40,   41,  152,   43,   44,   45,   46,   47,   48,
 /*    30 */    49,   50,   51,   52,   53,   19,   55,   55,  132,  133,
 /*    40 */   134,    1,    2,   27,   28,   29,   30,   31,   32,   33,
 /*    50 */    34,   35,   36,   37,   38,   39,   40,   41,  187,   43,
 /*    60 */    44,   45,   46,   47,   48,   49,   50,   51,   52,   53,
 /*    70 */    47,   48,   49,   50,   51,   52,   53,   61,   97,   97,
 /*    80 */    19,   49,   50,   51,   52,   53,   70,   26,   27,   28,
 /*    90 */    29,   30,   31,   32,   33,   34,   35,   36,   37,   38,
 /*   100 */    39,   40,   41,  152,   43,   44,   45,   46,   47,   48,
 /*   110 */    49,   50,   51,   52,   53,  144,  145,  146,  147,   19,
 /*   120 */    16,   22,   92,  172,  173,   52,   53,   27,   28,   29,
 /*   130 */    30,   31,   32,   33,   34,   35,   36,   37,   38,   39,
 /*   140 */    40,   41,   81,   43,   44,   45,   46,   47,   48,   49,
 /*   150 */    50,   51,   52,   53,   55,   56,   19,  152,  207,  208,
 /*   160 */   115,   24,  117,  118,   27,   28,   29,   30,   31,   32,
 /*   170 */    33,   34,   35,   36,   37,   38,   39,   40,   41,   79,
 /*   180 */    43,   44,   45,   46,   47,   48,   49,   50,   51,   52,
 /*   190 */    53,   19,   88,  157,   90,   23,   97,   98,  193,   27,
 /*   200 */    28,   29,   30,   31,   32,   33,   34,   35,   36,   37,
 /*   210 */    38,   39,   40,   41,  152,   43,   44,   45,   46,   47,
 /*   220 */    48,   49,   50,   51,   52,   53,   19,   22,   23,  172,
 /*   230 */    23,   26,  119,  120,   27,   28,   29,   30,   31,   32,
 /*   240 */    33,   34,   35,   36,   37,   38,   39,   40,   41,  187,
 /*   250 */    43,   44,   45,   46,   47,   48,   49,   50,   51,   52,
 /*   260 */    53,   19,   22,   23,  228,   23,   26,  231,  152,   27,
 /*   270 */    28,   29,   30,   31,   32,   33,   34,   35,   36,   37,
 /*   280 */    38,   39,   40,   41,  172,   43,   44,   45,   46,   47,
 /*   290 */    48,   49,   50,   51,   52,   53,   19,  221,  222,  223,
 /*   300 */    23,   96,  152,  172,   27,   28,   29,   30,   31,   32,
 /*   310 */    33,   34,   35,   36,   37,   38,   39,   40,   41,  152,
 /*   320 */    43,   44,   45,   46,   47,   48,   49,   50,   51,   52,
 /*   330 */    53,   19,    0,    1,    2,   23,   96,  190,  191,   27,
 /*   340 */    28,   29,   30,   31,   32,   33,   34,   35,   36,   37,
 /*   350 */    38,   39,   40,   41,  238,   43,   44,   45,   46,   47,
 /*   360 */    48,   49,   50,   51,   52,   53,   19,  185,  218,  221,
 /*   370 */   222,  223,  152,  152,   27,   28,   29,   30,   31,   32,
 /*   380 */    33,   34,   35,   36,   37,   38,   39,   40,   41,  241,
 /*   390 */    43,   44,   45,   46,   47,   48,   49,   50,   51,   52,
 /*   400 */    53,   19,  152,  168,  169,  170,   22,  190,  191,   27,
 /*   410 */    28,   29,   30,   31,   32,   33,   34,   35,   36,   37,
 /*   420 */    38,   39,   40,   41,  152,   43,   44,   45,   46,   47,
 /*   430 */    48,   49,   50,   51,   52,   53,   19,   19,  218,   55,
 /*   440 */    56,   24,   22,  152,   27,   28,   29,   30,   31,   32,
 /*   450 */    33,   34,   35,   36,   37,   38,   39,   40,   41,  152,
 /*   460 */    43,   44,   45,   46,   47,   48,   49,   50,   51,   52,
 /*   470 */    53,  250,  194,  195,   56,   55,   56,   55,   19,  172,
 /*   480 */   173,   97,   98,  152,  206,  138,   27,   28,   29,   30,
 /*   490 */    31,   32,   33,   34,   35,   36,   37,   38,   39,   40,
 /*   500 */    41,  152,   43,   44,   45,   46,   47,   48,   49,   50,
 /*   510 */    51,   52,   53,   19,  207,  208,  152,   97,   98,   97,
 /*   520 */   138,   27,   28,   29,   30,   31,   32,   33,   34,   35,
 /*   530 */    36,   37,   38,   39,   40,   41,  181,   43,   44,   45,
 /*   540 */    46,   47,   48,   49,   50,   51,   52,   53,   19,   30,
 /*   550 */    31,   32,   33,  247,  248,   19,  152,   28,   29,   30,
 /*   560 */    31,   32,   33,   34,   35,   36,   37,   38,   39,   40,
 /*   570 */    41,  152,   43,   44,   45,   46,   47,   48,   49,   50,
 /*   580 */    51,   52,   53,   19,  168,  169,  170,  238,   19,   53,
 /*   590 */   152,  172,  173,   29,   30,   31,   32,   33,   34,   35,
 /*   600 */    36,   37,   38,   39,   40,   41,  152,   43,   44,   45,
 /*   610 */    46,   47,   48,   49,   50,   51,   52,   53,   19,   20,
 /*   620 */   101,   22,   23,  169,  170,   56,  207,   85,   55,   56,
 /*   630 */    23,   19,   20,   26,   22,   99,  100,  101,  102,  103,
 /*   640 */   104,  105,  238,  152,  152,  210,   47,   48,  112,  152,
 /*   650 */   108,  109,  110,   54,   55,   56,  221,  222,  223,   47,
 /*   660 */    48,  119,  120,  172,  173,   66,   54,   55,   56,  152,
 /*   670 */    97,   98,   99,  148,  149,  102,  103,  104,   66,  154,
 /*   680 */    23,  156,   83,   26,  230,  152,  113,  152,  163,  194,
 /*   690 */   195,   92,   92,   30,   95,   83,   97,   98,  207,  208,
 /*   700 */   101,  206,  179,  180,   92,  172,  173,   95,  152,   97,
 /*   710 */    98,  188,   99,  101,  219,  102,  103,  104,  152,  119,
 /*   720 */   120,  196,   55,   56,   19,   20,  113,   22,  193,  163,
 /*   730 */    11,  132,  133,  134,  135,  136,   24,   65,  172,  173,
 /*   740 */   207,  208,  250,  152,  132,  133,  134,  135,  136,  193,
 /*   750 */    78,   84,   47,   48,   49,   98,  199,  152,   86,   54,
 /*   760 */    55,   56,  196,  152,   97,   98,  209,   55,  163,  244,
 /*   770 */   107,   66,  152,  207,  208,  164,  175,  172,  173,   19,
 /*   780 */    20,  124,   22,  111,   38,   39,   40,   41,   83,   43,
 /*   790 */    44,   45,   46,   47,   48,   49,   50,   51,   52,   53,
 /*   800 */    95,  196,   97,   98,   85,  152,  101,   47,   48,   97,
 /*   810 */    85,   92,  207,  193,   54,   55,   56,   92,   49,  175,
 /*   820 */    55,   56,  221,  222,  223,   12,   66,  108,  109,  110,
 /*   830 */   137,  163,  139,  108,  109,  110,   26,  132,  133,  134,
 /*   840 */   135,  136,  152,   83,   43,   44,   45,   46,   47,   48,
 /*   850 */    49,   50,   51,   52,   53,   95,   26,   97,   98,   55,
 /*   860 */    56,  101,   97,   98,  196,  221,  222,  223,  146,  147,
 /*   870 */    57,  171,  152,   22,   26,   19,   20,   49,   22,  179,
 /*   880 */   108,  109,  110,   55,   56,  116,   73,  219,   75,  124,
 /*   890 */   121,  152,  132,  133,  134,  135,  136,  163,   85,  152,
 /*   900 */   232,   97,   98,   47,   48,  237,   55,   56,   98,    5,
 /*   910 */    54,   55,   56,  193,   10,   11,   12,   13,   14,  172,
 /*   920 */   173,   17,   66,   47,   48,   97,   98,  152,  124,  152,
 /*   930 */   196,   55,   56,  186,  124,  152,  106,  160,  152,   83,
 /*   940 */   152,  164,  152,   61,   22,  211,  212,  152,   97,   98,
 /*   950 */   152,   95,   70,   97,   98,  172,  173,  101,  172,  173,
 /*   960 */   172,  173,  172,  173,   60,  181,   62,  172,  173,   47,
 /*   970 */    48,  123,  186,   97,   98,   71,  100,   55,   56,  152,
 /*   980 */   181,  186,   21,  107,  152,  109,   82,  163,  132,  133,
 /*   990 */   134,  135,  136,   89,   16,  207,   92,   93,   19,  172,
 /*  1000 */   173,  169,  170,  195,   55,   56,   12,  152,  132,   30,
 /*  1010 */   134,   47,   48,  186,  206,  225,  152,   95,  114,   97,
 /*  1020 */   196,  245,  246,  101,  152,   38,   39,   40,   41,   42,
 /*  1030 */    43,   44,   45,   46,   47,   48,   49,   50,   51,   52,
 /*  1040 */    53,  152,  163,  219,  152,  141,   97,   98,  193,  152,
 /*  1050 */   152,   57,   91,  164,  132,  133,  134,  152,   55,  152,
 /*  1060 */   152,  237,  230,  152,  103,  193,   88,   73,   90,   75,
 /*  1070 */   172,  173,  183,  152,  185,  196,  152,  172,  173,  172,
 /*  1080 */   173,  217,  152,  172,  173,  152,  107,   22,  152,   24,
 /*  1090 */   193,  112,  152,  172,  173,  152,  132,  242,  134,  152,
 /*  1100 */    97,  140,  152,   92,  152,  172,  173,  152,  172,  173,
 /*  1110 */   152,  100,  172,  173,  152,  172,  173,  152,  140,  172,
 /*  1120 */   173,  152,  172,  173,  172,  173,  152,  172,  173,  152,
 /*  1130 */   172,  173,  152,  152,  172,  173,  152,  172,  173,  213,
 /*  1140 */   152,  172,  173,  152,  152,  152,  172,  173,  152,  172,
 /*  1150 */   173,  152,  172,  173,  152,  210,  172,  173,  152,   26,
 /*  1160 */   172,  173,  152,  172,  173,  172,  173,  152,  172,  173,
 /*  1170 */   152,  172,  173,  152,  172,  173,  152,   59,  172,  173,
 /*  1180 */   152,   63,  172,  173,  152,  193,  152,  152,  152,  152,
 /*  1190 */   172,  173,  152,  172,  173,   77,  172,  173,  152,  152,
 /*  1200 */   172,  173,  152,  152,  172,  173,  172,  173,  172,  173,
 /*  1210 */   152,   22,  172,  173,  152,  152,  152,   22,  172,  173,
 /*  1220 */   152,  152,  152,  172,  173,  152,    7,    8,    9,  163,
 /*  1230 */   172,  173,   22,   23,  172,  173,  172,  173,  166,  167,
 /*  1240 */   172,  173,  172,  173,   55,  172,  173,   22,   23,  108,
 /*  1250 */   109,  110,  217,  152,  217,  166,  167,  163,  163,  163,
 /*  1260 */   163,  163,  196,  130,  217,  211,  212,  217,  116,   23,
 /*  1270 */    22,  101,   26,  121,   23,   23,   23,   26,   26,   26,
 /*  1280 */    23,   23,  112,   26,   26,   37,   97,  100,  101,   55,
 /*  1290 */   196,  196,  196,  196,  196,   23,   23,   55,   26,   26,
 /*  1300 */     7,    8,   23,  152,   23,   26,   96,   26,  132,  132,
 /*  1310 */   134,  134,   23,  152,  152,   26,  152,  122,  152,  191,
 /*  1320 */   152,   96,  234,  152,  152,  152,  152,  152,  197,  210,
 /*  1330 */   152,   97,  152,  152,  210,  233,  210,  198,  150,   97,
 /*  1340 */   184,  201,  239,  214,  214,  201,  239,  180,  214,  227,
 /*  1350 */   200,  198,  155,   67,  243,  176,   69,  175,  175,  175,
 /*  1360 */   122,  159,  159,  240,  159,  240,   22,  220,  129,  126,
 /*  1370 */   205,  130,   27,  204,  189,   18,  159,   18,  158,  220,
 /*  1380 */   159,  158,  137,   74,  192,  192,  192,  159,  192,  189,
 /*  1390 */   189,  205,  201,  236,  204,  235,  159,   22,  158,  201,
 /*  1400 */   201,  177,  107,  159,  177,  158,  174,  174,  159,  174,
 /*  1410 */    76,  182,  158,  177,  106,  125,   22,  107,   53,  137,
 /*  1420 */   216,  215,  159,  216,  174,  216,  215,  215,  159,  216,
 /*  1430 */   174,  176,  224,  215,  174,  174,  205,   25,  127,  177,
 /*  1440 */   226,  182,  177,  128,  229,  229,  162,   26,   13,  161,
 /*  1450 */   153,  153,    6,  151,  151,  151,  151,  165,  178,  165,
 /*  1460 */     4,  178,    3,   22,  165,  142,   15,   94,  204,  203,
 /*  1470 */   202,  201,   23,   16,  120,  249,   23,  131,  111,  249,
 /*  1480 */    20,  123,   16,    1,  123,  125,  131,   37,  111,   37,
 /*  1490 */    56,   37,   37,   64,  122,    1,    5,   22,  107,   80,
 /*  1500 */    26,   87,  140,   80,   72,  107,   20,   24,   19,  112,
 /*  1510 */   105,   23,   22,  246,   22,   79,   79,   22,   22,   58,
 /*  1520 */    22,   79,   23,   23,   23,  116,   68,   22,   26,   23,
 /*  1530 */    22,   64,  122,   26,   23,   23,   56,   22,   11,  124,
 /*  1540 */    26,   64,   26,   64,   23,   23,   23,   23,  122,   23,
 /*  1550 */    22,   26,   23,   22,   24,  122,   23,   22,   26,   22,
 /*  1560 */    24,   23,   23,   23,   22,  122,  122,   23,   15,    1,
};
#define YY_SHIFT_USE_DFLT (1570)
#define YY_SHIFT_COUNT    (459)
#define YY_SHIFT_MIN      (-94)
#define YY_SHIFT_MAX      (1568)
static const short yy_shift_ofst[] = {
 /*     0 */    40,  599,  904,  612,  760,  760,  760,  760,  725,  -19,
 /*    10 */    16,   16,  100,  760,  760,  760,  760,  760,  760,  760,
 /*    20 */   876,  876,  573,  542,  719,  600,   61,  137,  172,  207,
 /*    30 */   242,  277,  312,  347,  382,  417,  459,  459,  459,  459,
 /*    40 */   459,  459,  459,  459,  459,  459,  459,  459,  459,  459,
 /*    50 */   459,  459,  459,  494,  459,  529,  564,  564,  705,  760,
 /*    60 */   760,  760,  760,  760,  760,  760,  760,  760,  760,  760,
 /*    70 */   760,  760,  760,  760,  760,  760,  760,  760,  760,  760,
 /*    80 */   760,  760,  760,  760,  760,  760,  760,  760,  760,  760,
 /*    90 */   856,  760,  760,  760,  760,  760,  760,  760,  760,  760,
 /*   100 */   760,  760,  760,  760,  987,  746,  746,  746,  746,  746,
 /*   110 */   801,   23,   32,  949,  961,  979,  964,  964,  949,   73,
 /*   120 */   113,  -51, 1570, 1570, 1570,  536,  536,  536,   99,   99,
 /*   130 */   813,  813,  667,  205,  240,  949,  949,  949,  949,  949,
 /*   140 */   949,  949,  949,  949,  949,  949,  949,  949,  949,  949,
 /*   150 */   949,  949,  949,  949,  949,  332, 1011,  422,  422,  113,
 /*   160 */    30,   30,   30,   30,   30,   30, 1570, 1570, 1570,  922,
 /*   170 */   -94,  -94,  384,  613,  828,  420,  765,  804,  851,  949,
 /*   180 */   949,  949,  949,  949,  949,  949,  949,  949,  949,  949,
 /*   190 */   949,  949,  949,  949,  949,  672,  672,  672,  949,  949,
 /*   200 */   657,  949,  949,  949,  -18,  949,  949,  994,  949,  949,
 /*   210 */   949,  949,  949,  949,  949,  949,  949,  949,  772, 1118,
 /*   220 */   712,  712,  712,  810,   45,  769, 1219, 1133,  418,  418,
 /*   230 */   569, 1133,  569,  830,  607,  663,  882,  418,  693,  882,
 /*   240 */   882,  848, 1152, 1065, 1286, 1238, 1238, 1287, 1287, 1238,
 /*   250 */  1344, 1239, 1243, 1345, 1239, 1243, 1241, 1357, 1357, 1357,
 /*   260 */  1357, 1238, 1359, 1241, 1344, 1345, 1345, 1241, 1238, 1359,
 /*   270 */  1245, 1309, 1238, 1238, 1359, 1375, 1238, 1359, 1238, 1359,
 /*   280 */  1375, 1295, 1295, 1295, 1334, 1375, 1295, 1308, 1295, 1334,
 /*   290 */  1295, 1295, 1290, 1310, 1290, 1310, 1290, 1310, 1290, 1310,
 /*   300 */  1238, 1394, 1238, 1282, 1375, 1365, 1365, 1375, 1239, 1243,
 /*   310 */  1315, 1311, 1241, 1412, 1421, 1435, 1435, 1446, 1446, 1446,
 /*   320 */  1446, 1570, 1570, 1570, 1570, 1570, 1570, 1570, 1570,  519,
 /*   330 */   978, 1210, 1225,  104, 1141, 1189, 1246, 1248, 1251, 1252,
 /*   340 */  1253, 1257, 1258, 1273, 1003, 1187, 1293, 1170, 1272, 1279,
 /*   350 */  1234, 1281, 1176, 1177, 1289, 1242, 1195, 1456, 1459, 1441,
 /*   360 */  1323, 1451, 1373, 1457, 1449, 1453, 1354, 1346, 1367, 1358,
 /*   370 */  1460, 1360, 1466, 1482, 1361, 1355, 1450, 1452, 1454, 1455,
 /*   380 */  1377, 1434, 1429, 1372, 1494, 1491, 1475, 1391, 1362, 1419,
 /*   390 */  1474, 1423, 1414, 1432, 1398, 1483, 1486, 1489, 1397, 1405,
 /*   400 */  1490, 1436, 1492, 1495, 1488, 1496, 1437, 1461, 1498, 1442,
 /*   410 */  1458, 1499, 1500, 1501, 1502, 1409, 1505, 1506, 1508, 1507,
 /*   420 */  1410, 1511, 1512, 1480, 1467, 1515, 1415, 1514, 1477, 1516,
 /*   430 */  1479, 1521, 1514, 1522, 1523, 1524, 1525, 1526, 1528, 1527,
 /*   440 */  1529, 1531, 1530, 1532, 1533, 1535, 1536, 1532, 1538, 1537,
 /*   450 */  1539, 1540, 1542, 1426, 1433, 1443, 1444, 1544, 1553, 1568,
};
#define YY_REDUCE_USE_DFLT (-130)
#define YY_REDUCE_COUNT (328)
#define YY_REDUCE_MIN   (-129)
#define YY_REDUCE_MAX   (1305)
static const short yy_reduce_ofst[] = {
 /*     0 */   -29,  566,  525,  605,  -49,  307,  491,  533,  668,  435,
 /*    10 */   601,  644,  148,  747,  786,  795,  419,  788,  827,  790,
 /*    20 */   454,  832,  889,  495,  824,  734,   76,   76,   76,   76,
 /*    30 */    76,   76,   76,   76,   76,   76,   76,   76,   76,   76,
 /*    40 */    76,   76,   76,   76,   76,   76,   76,   76,   76,   76,
 /*    50 */    76,   76,   76,   76,   76,   76,   76,   76,  783,  898,
 /*    60 */   905,  907,  911,  921,  933,  936,  940,  943,  947,  950,
 /*    70 */   952,  955,  958,  962,  965,  969,  974,  977,  980,  984,
 /*    80 */   988,  991,  993,  996,  999, 1002, 1006, 1010, 1018, 1021,
 /*    90 */  1024, 1028, 1032, 1034, 1036, 1040, 1046, 1051, 1058, 1062,
 /*   100 */  1064, 1068, 1070, 1073,   76,   76,   76,   76,   76,   76,
 /*   110 */    76,   76,   76,  855,   36,  523,  235,  416,  777,   76,
 /*   120 */   278,   76,   76,   76,   76,  700,  700,  700,  150,  220,
 /*   130 */   147,  217,  221,  306,  306,  611,    5,  535,  556,  620,
 /*   140 */   720,  872,  897,  116,  864,  349, 1035, 1037,  404, 1047,
 /*   150 */   992, -129, 1050,  492,   62,  722,  879, 1072, 1089,  808,
 /*   160 */  1066, 1094, 1095, 1096, 1097, 1098,  776, 1054,  557,   57,
 /*   170 */   112,  131,  167,  182,  250,  272,  291,  331,  364,  438,
 /*   180 */   497,  517,  591,  653,  690,  739,  775,  798,  892,  908,
 /*   190 */   924,  930, 1015, 1063, 1069,  355,  784,  799,  981, 1101,
 /*   200 */   926, 1151, 1161, 1162,  945, 1164, 1166, 1128, 1168, 1171,
 /*   210 */  1172,  250, 1173, 1174, 1175, 1178, 1180, 1181, 1088, 1102,
 /*   220 */  1119, 1124, 1126,  926, 1131, 1139, 1188, 1140, 1129, 1130,
 /*   230 */  1103, 1144, 1107, 1179, 1156, 1167, 1182, 1134, 1122, 1183,
 /*   240 */  1184, 1150, 1153, 1197, 1111, 1202, 1203, 1123, 1125, 1205,
 /*   250 */  1147, 1165, 1169, 1185, 1186, 1190, 1191, 1192, 1193, 1194,
 /*   260 */  1196, 1217, 1220, 1198, 1159, 1200, 1201, 1199, 1221, 1223,
 /*   270 */  1157, 1160, 1228, 1237, 1240, 1224, 1244, 1247, 1249, 1254,
 /*   280 */  1227, 1232, 1233, 1235, 1229, 1236, 1250, 1255, 1256, 1259,
 /*   290 */  1260, 1261, 1204, 1206, 1207, 1211, 1209, 1212, 1213, 1218,
 /*   300 */  1263, 1208, 1269, 1214, 1262, 1215, 1216, 1265, 1231, 1264,
 /*   310 */  1266, 1268, 1270, 1284, 1288, 1297, 1298, 1302, 1303, 1304,
 /*   320 */  1305, 1226, 1230, 1267, 1292, 1294, 1280, 1283, 1299,
};
static const YYACTIONTYPE yy_default[] = {
 /*     0 */  1285, 1275, 1275, 1275, 1207, 1207, 1207, 1207, 1275, 1100,
 /*    10 */  1129, 1129, 1259, 1336, 1336, 1336, 1336, 1336, 1336, 1206,
 /*    20 */  1336, 1336, 1336, 1336, 1275, 1104, 1135, 1336, 1336, 1336,
 /*    30 */  1336, 1208, 1209, 1336, 1336, 1336, 1258, 1260, 1145, 1144,
 /*    40 */  1143, 1142, 1241, 1116, 1140, 1133, 1137, 1208, 1202, 1203,
 /*    50 */  1201, 1205, 1209, 1336, 1136, 1171, 1186, 1170, 1336, 1336,
 /*    60 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*    70 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*    80 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*    90 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   100 */  1336, 1336, 1336, 1336, 1180, 1185, 1192, 1184, 1181, 1173,
 /*   110 */  1172, 1174, 1175, 1336, 1023, 1071, 1336, 1336, 1336, 1176,
 /*   120 */  1336, 1177, 1189, 1188, 1187, 1266, 1293, 1292, 1336, 1336,
 /*   130 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   140 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   150 */  1336, 1336, 1336, 1336, 1336, 1285, 1275, 1029, 1029, 1336,
 /*   160 */  1275, 1275, 1275, 1275, 1275, 1275, 1271, 1104, 1095, 1336,
 /*   170 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   180 */  1263, 1261, 1336, 1222, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   190 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   200 */  1336, 1336, 1336, 1336, 1100, 1336, 1336, 1336, 1336, 1336,
 /*   210 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1287, 1336, 1236,
 /*   220 */  1100, 1100, 1100, 1102, 1084, 1094, 1008, 1139, 1118, 1118,
 /*   230 */  1325, 1139, 1325, 1046, 1307, 1043, 1129, 1118, 1204, 1129,
 /*   240 */  1129, 1101, 1094, 1336, 1328, 1109, 1109, 1327, 1327, 1109,
 /*   250 */  1150, 1134, 1123, 1074, 1134, 1123, 1139, 1080, 1080, 1080,
 /*   260 */  1080, 1109, 1020, 1139, 1150, 1074, 1074, 1139, 1109, 1020,
 /*   270 */  1240, 1322, 1109, 1109, 1020, 1215, 1109, 1020, 1109, 1020,
 /*   280 */  1215, 1072, 1072, 1072, 1061, 1215, 1072, 1046, 1072, 1061,
 /*   290 */  1072, 1072, 1122, 1117, 1122, 1117, 1122, 1117, 1122, 1117,
 /*   300 */  1109, 1210, 1109, 1336, 1215, 1219, 1219, 1215, 1134, 1123,
 /*   310 */  1132, 1130, 1139, 1026, 1064, 1290, 1290, 1286, 1286, 1286,
 /*   320 */  1286, 1333, 1333, 1271, 1302, 1302, 1048, 1048, 1302, 1336,
 /*   330 */  1336, 1336, 1336, 1336, 1336, 1297, 1336, 1224, 1336, 1336,
 /*   340 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   350 */  1336, 1336, 1336, 1336, 1336, 1336, 1156, 1336, 1004, 1268,
 /*   360 */  1336, 1336, 1267, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   370 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   380 */  1336, 1336, 1336, 1324, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   390 */  1239, 1238, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   400 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   410 */  1336, 1336, 1336, 1336, 1336, 1086, 1336, 1336, 1336, 1311,
 /*   420 */  1336, 1336, 1336, 1336, 1336, 1336, 1336, 1131, 1336, 1124,
 /*   430 */  1336, 1336, 1315, 1336, 1336, 1336, 1336, 1336, 1336, 1336,
 /*   440 */  1336, 1336, 1336, 1277, 1336, 1336, 1336, 1276, 1336, 1336,
 /*   450 */  1336, 1336, 1336, 1158, 1336, 1157, 1161, 1336, 1014, 1336,
};
/********** End of lemon-generated parsing tables *****************************/

/* The next table maps tokens (terminal symbols) into fallback tokens.  
** If a construct like the following:
** 
**      %fallback ID X Y Z.
**
** appears in the grammar, then ID becomes a fallback token for X, Y,
** and Z.  Whenever one of the tokens X, Y, or Z is input to the parser
** but it does not parse, the type of the token is changed to ID and
** the parse is retried before an error is thrown.
**
** This feature can be used, for example, to cause some keywords in a language
** to revert to identifiers if they keyword does not apply in the context where
** it appears.
*/
#ifdef YYFALLBACK
static const YYCODETYPE yyFallback[] = {
    0,  /*          $ => nothing */
    0,  /*       SEMI => nothing */
   55,  /*    EXPLAIN => ID */
   55,  /*      QUERY => ID */
   55,  /*       PLAN => ID */
   55,  /*      BEGIN => ID */
    0,  /* TRANSACTION => nothing */
   55,  /*   DEFERRED => ID */
   55,  /*  IMMEDIATE => ID */
   55,  /*  EXCLUSIVE => ID */
    0,  /*     COMMIT => nothing */
   55,  /*        END => ID */
   55,  /*   ROLLBACK => ID */
   55,  /*  SAVEPOINT => ID */
   55,  /*    RELEASE => ID */
    0,  /*         TO => nothing */
    0,  /*      TABLE => nothing */
    0,  /*     CREATE => nothing */
   55,  /*         IF => ID */
    0,  /*        NOT => nothing */
    0,  /*     EXISTS => nothing */
   55,  /*       TEMP => ID */
    0,  /*         LP => nothing */
    0,  /*         RP => nothing */
    0,  /*         AS => nothing */
   55,  /*    WITHOUT => ID */
    0,  /*      COMMA => nothing */
    0,  /*         OR => nothing */
    0,  /*        AND => nothing */
    0,  /*         IS => nothing */
   55,  /*      MATCH => ID */
   55,  /*    LIKE_KW => ID */
    0,  /*    BETWEEN => nothing */
    0,  /*         IN => nothing */
    0,  /*     ISNULL => nothing */
    0,  /*    NOTNULL => nothing */
    0,  /*         NE => nothing */
    0,  /*         EQ => nothing */
    0,  /*         GT => nothing */
    0,  /*         LE => nothing */
    0,  /*         LT => nothing */
    0,  /*         GE => nothing */
    0,  /*     ESCAPE => nothing */
    0,  /*     BITAND => nothing */
    0,  /*      BITOR => nothing */
    0,  /*     LSHIFT => nothing */
    0,  /*     RSHIFT => nothing */
    0,  /*       PLUS => nothing */
    0,  /*      MINUS => nothing */
    0,  /*       STAR => nothing */
    0,  /*      SLASH => nothing */
    0,  /*        REM => nothing */
    0,  /*     CONCAT => nothing */
    0,  /*    COLLATE => nothing */
    0,  /*     BITNOT => nothing */
    0,  /*         ID => nothing */
    0,  /*    INDEXED => nothing */
   55,  /*      ABORT => ID */
   55,  /*     ACTION => ID */
   55,  /*      AFTER => ID */
   55,  /*    ANALYZE => ID */
   55,  /*        ASC => ID */
   55,  /*     ATTACH => ID */
   55,  /*     BEFORE => ID */
   55,  /*         BY => ID */
   55,  /*    CASCADE => ID */
   55,  /*       CAST => ID */
   55,  /*   COLUMNKW => ID */
   55,  /*   CONFLICT => ID */
   55,  /*   DATABASE => ID */
   55,  /*       DESC => ID */
   55,  /*     DETACH => ID */
   55,  /*       EACH => ID */
   55,  /*       FAIL => ID */
   55,  /*        FOR => ID */
   55,  /*     IGNORE => ID */
   55,  /*  INITIALLY => ID */
   55,  /*    INSTEAD => ID */
   55,  /*         NO => ID */
   55,  /*        KEY => ID */
   55,  /*         OF => ID */
   55,  /*     OFFSET => ID */
   55,  /*     PRAGMA => ID */
   55,  /*      RAISE => ID */
   55,  /*  RECURSIVE => ID */
   55,  /*    REPLACE => ID */
   55,  /*   RESTRICT => ID */
   55,  /*        ROW => ID */
   55,  /*    TRIGGER => ID */
   55,  /*     VACUUM => ID */
   55,  /*       VIEW => ID */
   55,  /*    VIRTUAL => ID */
   55,  /*       WITH => ID */
   55,  /*    REINDEX => ID */
   55,  /*     RENAME => ID */
   55,  /*   CTIME_KW => ID */
};
#endif /* YYFALLBACK */

/* The following structure represents a single element of the
** parser's stack.  Information stored includes:
**
**   +  The state number for the parser at this level of the stack.
**
**   +  The value of the token stored at this level of the stack.
**      (In other words, the "major" token.)
**
**   +  The semantic value stored at this level of the stack.  This is
**      the information used by the action routines in the grammar.
**      It is sometimes called the "minor" token.
**
** After the "shift" half of a SHIFTREDUCE action, the stateno field
** actually contains the reduce action for the second half of the
** SHIFTREDUCE.
*/
struct yyStackEntry {
  YYACTIONTYPE stateno;  /* The state-number, or reduce action in SHIFTREDUCE */
  YYCODETYPE major;      /* The major token value.  This is the code
                         ** number for the token at this stack level */
  YYMINORTYPE minor;     /* The user-supplied minor token value.  This
                         ** is the value of the token  */
};
typedef struct yyStackEntry yyStackEntry;

/* The state of the parser is completely contained in an instance of
** the following structure */
struct yyParser {
  yyStackEntry *yytos;          /* Pointer to top element of the stack */
#ifdef YYTRACKMAXSTACKDEPTH
  int yyhwm;                    /* High-water mark of the stack */
#endif
#ifndef YYNOERRORRECOVERY
  int yyerrcnt;                 /* Shifts left before out of the error */
#endif
  sqlite3ParserARG_SDECL                /* A place to hold %extra_argument */
#if YYSTACKDEPTH<=0
  int yystksz;                  /* Current side of the stack */
  yyStackEntry *yystack;        /* The parser's stack */
  yyStackEntry yystk0;          /* First stack entry */
#else
  yyStackEntry yystack[YYSTACKDEPTH];  /* The parser's stack */
#endif
};
typedef struct yyParser yyParser;

#ifndef NDEBUG
#include <stdio.h>
static FILE *yyTraceFILE = 0;
static char *yyTracePrompt = 0;
#endif /* NDEBUG */

#ifndef NDEBUG
/* 
** Turn parser tracing on by giving a stream to which to write the trace
** and a prompt to preface each trace message.  Tracing is turned off
** by making either argument NULL 
**
** Inputs:
** <ul>
** <li> A FILE* to which trace output should be written.
**      If NULL, then tracing is turned off.
** <li> A prefix string written at the beginning of every
**      line of trace output.  If NULL, then tracing is
**      turned off.
** </ul>
**
** Outputs:
** None.
*/
void sqlite3ParserTrace(FILE *TraceFILE, char *zTracePrompt){
  yyTraceFILE = TraceFILE;
  yyTracePrompt = zTracePrompt;
  if( yyTraceFILE==0 ) yyTracePrompt = 0;
  else if( yyTracePrompt==0 ) yyTraceFILE = 0;
}
#endif /* NDEBUG */

#ifndef NDEBUG
/* For tracing shifts, the names of all terminals and nonterminals
** are required.  The following table supplies these names */
static const char *const yyTokenName[] = { 
  "$",             "SEMI",          "EXPLAIN",       "QUERY",       
  "PLAN",          "BEGIN",         "TRANSACTION",   "DEFERRED",    
  "IMMEDIATE",     "EXCLUSIVE",     "COMMIT",        "END",         
  "ROLLBACK",      "SAVEPOINT",     "RELEASE",       "TO",          
  "TABLE",         "CREATE",        "IF",            "NOT",         
  "EXISTS",        "TEMP",          "LP",            "RP",          
  "AS",            "WITHOUT",       "COMMA",         "OR",          
  "AND",           "IS",            "MATCH",         "LIKE_KW",     
  "BETWEEN",       "IN",            "ISNULL",        "NOTNULL",     
  "NE",            "EQ",            "GT",            "LE",          
  "LT",            "GE",            "ESCAPE",        "BITAND",      
  "BITOR",         "LSHIFT",        "RSHIFT",        "PLUS",        
  "MINUS",         "STAR",          "SLASH",         "REM",         
  "CONCAT",        "COLLATE",       "BITNOT",        "ID",          
  "INDEXED",       "ABORT",         "ACTION",        "AFTER",       
  "ANALYZE",       "ASC",           "ATTACH",        "BEFORE",      
  "BY",            "CASCADE",       "CAST",          "COLUMNKW",    
  "CONFLICT",      "DATABASE",      "DESC",          "DETACH",      
  "EACH",          "FAIL",          "FOR",           "IGNORE",      
  "INITIALLY",     "INSTEAD",       "NO",            "KEY",         
  "OF",            "OFFSET",        "PRAGMA",        "RAISE",       
  "RECURSIVE",     "REPLACE",       "RESTRICT",      "ROW",         
  "TRIGGER",       "VACUUM",        "VIEW",          "VIRTUAL",     
  "WITH",          "REINDEX",       "RENAME",        "CTIME_KW",    
  "ANY",           "STRING",        "JOIN_KW",       "CONSTRAINT",  
  "DEFAULT",       "NULL",          "PRIMARY",       "UNIQUE",      
  "CHECK",         "REFERENCES",    "AUTOINCR",      "ON",          
  "INSERT",        "DELETE",        "UPDATE",        "SET",         
  "DEFERRABLE",    "FOREIGN",       "DROP",          "UNION",       
  "ALL",           "EXCEPT",        "INTERSECT",     "SELECT",      
  "VALUES",        "DISTINCT",      "DOT",           "FROM",        
  "JOIN",          "USING",         "ORDER",         "GROUP",       
  "HAVING",        "LIMIT",         "WHERE",         "INTO",        
  "FLOAT",         "BLOB",          "INTEGER",       "VARIABLE",    
  "CASE",          "WHEN",          "THEN",          "ELSE",        
  "INDEX",         "ALTER",         "ADD",           "error",       
  "input",         "cmdlist",       "ecmd",          "explain",     
  "cmdx",          "cmd",           "transtype",     "trans_opt",   
  "nm",            "savepoint_opt",  "create_table",  "create_table_args",
  "createkw",      "temp",          "ifnotexists",   "dbnm",        
  "columnlist",    "conslist_opt",  "table_options",  "select",      
  "columnname",    "carglist",      "typetoken",     "typename",    
  "signed",        "plus_num",      "minus_num",     "ccons",       
  "term",          "expr",          "onconf",        "sortorder",   
  "autoinc",       "eidlist_opt",   "refargs",       "defer_subclause",
  "refarg",        "refact",        "init_deferred_pred_opt",  "conslist",    
  "tconscomma",    "tcons",         "sortlist",      "eidlist",     
  "defer_subclause_opt",  "orconf",        "resolvetype",   "raisetype",   
  "ifexists",      "fullname",      "selectnowith",  "oneselect",   
  "with",          "multiselect_op",  "distinct",      "selcollist",  
  "from",          "where_opt",     "groupby_opt",   "having_opt",  
  "orderby_opt",   "limit_opt",     "values",        "nexprlist",   
  "exprlist",      "sclp",          "as",            "seltablist",  
  "stl_prefix",    "joinop",        "indexed_opt",   "on_opt",      
  "using_opt",     "idlist",        "setlist",       "insert_cmd",  
  "idlist_opt",    "likeop",        "between_op",    "in_op",       
  "paren_exprlist",  "case_operand",  "case_exprlist",  "case_else",   
  "uniqueflag",    "collate",       "nmnum",         "trigger_decl",
  "trigger_cmd_list",  "trigger_time",  "trigger_event",  "foreach_clause",
  "when_clause",   "trigger_cmd",   "trnm",          "tridxby",     
  "database_kw_opt",  "key_opt",       "add_column_fullname",  "kwcolumn_opt",
  "create_vtab",   "vtabarglist",   "vtabarg",       "vtabargtoken",
  "lp",            "anylist",       "wqlist",      
};
#endif /* NDEBUG */

#ifndef NDEBUG
/* For tracing reduce actions, the names of all rules are required.
*/
static const char *const yyRuleName[] = {
 /*   0 */ "explain ::= EXPLAIN",
 /*   1 */ "explain ::= EXPLAIN QUERY PLAN",
 /*   2 */ "cmdx ::= cmd",
 /*   3 */ "cmd ::= BEGIN transtype trans_opt",
 /*   4 */ "transtype ::=",
 /*   5 */ "transtype ::= DEFERRED",
 /*   6 */ "transtype ::= IMMEDIATE",
 /*   7 */ "transtype ::= EXCLUSIVE",
 /*   8 */ "cmd ::= COMMIT trans_opt",
 /*   9 */ "cmd ::= END trans_opt",
 /*  10 */ "cmd ::= ROLLBACK trans_opt",
 /*  11 */ "cmd ::= SAVEPOINT nm",
 /*  12 */ "cmd ::= RELEASE savepoint_opt nm",
 /*  13 */ "cmd ::= ROLLBACK trans_opt TO savepoint_opt nm",
 /*  14 */ "create_table ::= createkw temp TABLE ifnotexists nm dbnm",
 /*  15 */ "createkw ::= CREATE",
 /*  16 */ "ifnotexists ::=",
 /*  17 */ "ifnotexists ::= IF NOT EXISTS",
 /*  18 */ "temp ::= TEMP",
 /*  19 */ "temp ::=",
 /*  20 */ "create_table_args ::= LP columnlist conslist_opt RP table_options",
 /*  21 */ "create_table_args ::= AS select",
 /*  22 */ "table_options ::=",
 /*  23 */ "table_options ::= WITHOUT nm",
 /*  24 */ "columnname ::= nm typetoken",
 /*  25 */ "typetoken ::=",
 /*  26 */ "typetoken ::= typename LP signed RP",
 /*  27 */ "typetoken ::= typename LP signed COMMA signed RP",
 /*  28 */ "typename ::= typename ID|STRING",
 /*  29 */ "ccons ::= CONSTRAINT nm",
 /*  30 */ "ccons ::= DEFAULT term",
 /*  31 */ "ccons ::= DEFAULT LP expr RP",
 /*  32 */ "ccons ::= DEFAULT PLUS term",
 /*  33 */ "ccons ::= DEFAULT MINUS term",
 /*  34 */ "ccons ::= DEFAULT ID|INDEXED",
 /*  35 */ "ccons ::= NOT NULL onconf",
 /*  36 */ "ccons ::= PRIMARY KEY sortorder onconf autoinc",
 /*  37 */ "ccons ::= UNIQUE onconf",
 /*  38 */ "ccons ::= CHECK LP expr RP",
 /*  39 */ "ccons ::= REFERENCES nm eidlist_opt refargs",
 /*  40 */ "ccons ::= defer_subclause",
 /*  41 */ "ccons ::= COLLATE ID|STRING",
 /*  42 */ "autoinc ::=",
 /*  43 */ "autoinc ::= AUTOINCR",
 /*  44 */ "refargs ::=",
 /*  45 */ "refargs ::= refargs refarg",
 /*  46 */ "refarg ::= MATCH nm",
 /*  47 */ "refarg ::= ON INSERT refact",
 /*  48 */ "refarg ::= ON DELETE refact",
 /*  49 */ "refarg ::= ON UPDATE refact",
 /*  50 */ "refact ::= SET NULL",
 /*  51 */ "refact ::= SET DEFAULT",
 /*  52 */ "refact ::= CASCADE",
 /*  53 */ "refact ::= RESTRICT",
 /*  54 */ "refact ::= NO ACTION",
 /*  55 */ "defer_subclause ::= NOT DEFERRABLE init_deferred_pred_opt",
 /*  56 */ "defer_subclause ::= DEFERRABLE init_deferred_pred_opt",
 /*  57 */ "init_deferred_pred_opt ::=",
 /*  58 */ "init_deferred_pred_opt ::= INITIALLY DEFERRED",
 /*  59 */ "init_deferred_pred_opt ::= INITIALLY IMMEDIATE",
 /*  60 */ "conslist_opt ::=",
 /*  61 */ "tconscomma ::= COMMA",
 /*  62 */ "tcons ::= CONSTRAINT nm",
 /*  63 */ "tcons ::= PRIMARY KEY LP sortlist autoinc RP onconf",
 /*  64 */ "tcons ::= UNIQUE LP sortlist RP onconf",
 /*  65 */ "tcons ::= CHECK LP expr RP onconf",
 /*  66 */ "tcons ::= FOREIGN KEY LP eidlist RP REFERENCES nm eidlist_opt refargs defer_subclause_opt",
 /*  67 */ "defer_subclause_opt ::=",
 /*  68 */ "onconf ::=",
 /*  69 */ "onconf ::= ON CONFLICT resolvetype",
 /*  70 */ "orconf ::=",
 /*  71 */ "orconf ::= OR resolvetype",
 /*  72 */ "resolvetype ::= IGNORE",
 /*  73 */ "resolvetype ::= REPLACE",
 /*  74 */ "cmd ::= DROP TABLE ifexists fullname",
 /*  75 */ "ifexists ::= IF EXISTS",
 /*  76 */ "ifexists ::=",
 /*  77 */ "cmd ::= createkw temp VIEW ifnotexists nm dbnm eidlist_opt AS select",
 /*  78 */ "cmd ::= DROP VIEW ifexists fullname",
 /*  79 */ "cmd ::= select",
 /*  80 */ "select ::= with selectnowith",
 /*  81 */ "selectnowith ::= selectnowith multiselect_op oneselect",
 /*  82 */ "multiselect_op ::= UNION",
 /*  83 */ "multiselect_op ::= UNION ALL",
 /*  84 */ "multiselect_op ::= EXCEPT|INTERSECT",
 /*  85 */ "oneselect ::= SELECT distinct selcollist from where_opt groupby_opt having_opt orderby_opt limit_opt",
 /*  86 */ "values ::= VALUES LP nexprlist RP",
 /*  87 */ "values ::= values COMMA LP exprlist RP",
 /*  88 */ "distinct ::= DISTINCT",
 /*  89 */ "distinct ::= ALL",
 /*  90 */ "distinct ::=",
 /*  91 */ "sclp ::=",
 /*  92 */ "selcollist ::= sclp expr as",
 /*  93 */ "selcollist ::= sclp STAR",
 /*  94 */ "selcollist ::= sclp nm DOT STAR",
 /*  95 */ "as ::= AS nm",
 /*  96 */ "as ::=",
 /*  97 */ "from ::=",
 /*  98 */ "from ::= FROM seltablist",
 /*  99 */ "stl_prefix ::= seltablist joinop",
 /* 100 */ "stl_prefix ::=",
 /* 101 */ "seltablist ::= stl_prefix nm dbnm as indexed_opt on_opt using_opt",
 /* 102 */ "seltablist ::= stl_prefix nm dbnm LP exprlist RP as on_opt using_opt",
 /* 103 */ "seltablist ::= stl_prefix LP select RP as on_opt using_opt",
 /* 104 */ "seltablist ::= stl_prefix LP seltablist RP as on_opt using_opt",
 /* 105 */ "dbnm ::=",
 /* 106 */ "dbnm ::= DOT nm",
 /* 107 */ "fullname ::= nm dbnm",
 /* 108 */ "joinop ::= COMMA|JOIN",
 /* 109 */ "joinop ::= JOIN_KW JOIN",
 /* 110 */ "joinop ::= JOIN_KW nm JOIN",
 /* 111 */ "joinop ::= JOIN_KW nm nm JOIN",
 /* 112 */ "on_opt ::= ON expr",
 /* 113 */ "on_opt ::=",
 /* 114 */ "indexed_opt ::=",
 /* 115 */ "indexed_opt ::= INDEXED BY nm",
 /* 116 */ "indexed_opt ::= NOT INDEXED",
 /* 117 */ "using_opt ::= USING LP idlist RP",
 /* 118 */ "using_opt ::=",
 /* 119 */ "orderby_opt ::=",
 /* 120 */ "orderby_opt ::= ORDER BY sortlist",
 /* 121 */ "sortlist ::= sortlist COMMA expr sortorder",
 /* 122 */ "sortlist ::= expr sortorder",
 /* 123 */ "sortorder ::= ASC",
 /* 124 */ "sortorder ::= DESC",
 /* 125 */ "sortorder ::=",
 /* 126 */ "groupby_opt ::=",
 /* 127 */ "groupby_opt ::= GROUP BY nexprlist",
 /* 128 */ "having_opt ::=",
 /* 129 */ "having_opt ::= HAVING expr",
 /* 130 */ "limit_opt ::=",
 /* 131 */ "limit_opt ::= LIMIT expr",
 /* 132 */ "limit_opt ::= LIMIT expr OFFSET expr",
 /* 133 */ "limit_opt ::= LIMIT expr COMMA expr",
 /* 134 */ "cmd ::= with DELETE FROM fullname indexed_opt where_opt orderby_opt limit_opt",
 /* 135 */ "where_opt ::=",
 /* 136 */ "where_opt ::= WHERE expr",
 /* 137 */ "cmd ::= with UPDATE orconf fullname indexed_opt SET setlist where_opt orderby_opt limit_opt",
 /* 138 */ "setlist ::= setlist COMMA nm EQ expr",
 /* 139 */ "setlist ::= setlist COMMA LP idlist RP EQ expr",
 /* 140 */ "setlist ::= nm EQ expr",
 /* 141 */ "setlist ::= LP idlist RP EQ expr",
 /* 142 */ "cmd ::= with insert_cmd INTO fullname idlist_opt select",
 /* 143 */ "cmd ::= with insert_cmd INTO fullname idlist_opt DEFAULT VALUES",
 /* 144 */ "insert_cmd ::= INSERT orconf",
 /* 145 */ "insert_cmd ::= REPLACE",
 /* 146 */ "idlist_opt ::=",
 /* 147 */ "idlist_opt ::= LP idlist RP",
 /* 148 */ "idlist ::= idlist COMMA nm",
 /* 149 */ "idlist ::= nm",
 /* 150 */ "expr ::= LP expr RP",
 /* 151 */ "term ::= NULL",
 /* 152 */ "expr ::= ID|INDEXED",
 /* 153 */ "expr ::= JOIN_KW",
 /* 154 */ "expr ::= nm DOT nm",
 /* 155 */ "expr ::= nm DOT nm DOT nm",
 /* 156 */ "term ::= FLOAT|BLOB",
 /* 157 */ "term ::= STRING",
 /* 158 */ "term ::= INTEGER",
 /* 159 */ "expr ::= VARIABLE",
 /* 160 */ "expr ::= expr COLLATE ID|STRING",
 /* 161 */ "expr ::= CAST LP expr AS typetoken RP",
 /* 162 */ "expr ::= ID|INDEXED LP distinct exprlist RP",
 /* 163 */ "expr ::= ID|INDEXED LP STAR RP",
 /* 164 */ "term ::= CTIME_KW",
 /* 165 */ "expr ::= LP nexprlist COMMA expr RP",
 /* 166 */ "expr ::= expr AND expr",
 /* 167 */ "expr ::= expr OR expr",
 /* 168 */ "expr ::= expr LT|GT|GE|LE expr",
 /* 169 */ "expr ::= expr EQ|NE expr",
 /* 170 */ "expr ::= expr BITAND|BITOR|LSHIFT|RSHIFT expr",
 /* 171 */ "expr ::= expr PLUS|MINUS expr",
 /* 172 */ "expr ::= expr STAR|SLASH|REM expr",
 /* 173 */ "expr ::= expr CONCAT expr",
 /* 174 */ "likeop ::= LIKE_KW|MATCH",
 /* 175 */ "likeop ::= NOT LIKE_KW|MATCH",
 /* 176 */ "expr ::= expr likeop expr",
 /* 177 */ "expr ::= expr likeop expr ESCAPE expr",
 /* 178 */ "expr ::= expr ISNULL|NOTNULL",
 /* 179 */ "expr ::= expr NOT NULL",
 /* 180 */ "expr ::= expr IS expr",
 /* 181 */ "expr ::= expr IS NOT expr",
 /* 182 */ "expr ::= NOT expr",
 /* 183 */ "expr ::= BITNOT expr",
 /* 184 */ "expr ::= MINUS expr",
 /* 185 */ "expr ::= PLUS expr",
 /* 186 */ "between_op ::= BETWEEN",
 /* 187 */ "between_op ::= NOT BETWEEN",
 /* 188 */ "expr ::= expr between_op expr AND expr",
 /* 189 */ "in_op ::= IN",
 /* 190 */ "in_op ::= NOT IN",
 /* 191 */ "expr ::= expr in_op LP exprlist RP",
 /* 192 */ "expr ::= LP select RP",
 /* 193 */ "expr ::= expr in_op LP select RP",
 /* 194 */ "expr ::= expr in_op nm dbnm paren_exprlist",
 /* 195 */ "expr ::= EXISTS LP select RP",
 /* 196 */ "expr ::= CASE case_operand case_exprlist case_else END",
 /* 197 */ "case_exprlist ::= case_exprlist WHEN expr THEN expr",
 /* 198 */ "case_exprlist ::= WHEN expr THEN expr",
 /* 199 */ "case_else ::= ELSE expr",
 /* 200 */ "case_else ::=",
 /* 201 */ "case_operand ::= expr",
 /* 202 */ "case_operand ::=",
 /* 203 */ "exprlist ::=",
 /* 204 */ "nexprlist ::= nexprlist COMMA expr",
 /* 205 */ "nexprlist ::= expr",
 /* 206 */ "paren_exprlist ::=",
 /* 207 */ "paren_exprlist ::= LP exprlist RP",
 /* 208 */ "cmd ::= createkw uniqueflag INDEX ifnotexists nm dbnm ON nm LP sortlist RP where_opt",
 /* 209 */ "uniqueflag ::= UNIQUE",
 /* 210 */ "uniqueflag ::=",
 /* 211 */ "eidlist_opt ::=",
 /* 212 */ "eidlist_opt ::= LP eidlist RP",
 /* 213 */ "eidlist ::= eidlist COMMA nm collate sortorder",
 /* 214 */ "eidlist ::= nm collate sortorder",
 /* 215 */ "collate ::=",
 /* 216 */ "collate ::= COLLATE ID|STRING",
 /* 217 */ "cmd ::= DROP INDEX ifexists fullname",
 /* 218 */ "cmd ::= VACUUM",
 /* 219 */ "cmd ::= VACUUM nm",
 /* 220 */ "cmd ::= PRAGMA nm dbnm",
 /* 221 */ "cmd ::= PRAGMA nm dbnm EQ nmnum",
 /* 222 */ "cmd ::= PRAGMA nm dbnm LP nmnum RP",
 /* 223 */ "cmd ::= PRAGMA nm dbnm EQ minus_num",
 /* 224 */ "cmd ::= PRAGMA nm dbnm LP minus_num RP",
 /* 225 */ "plus_num ::= PLUS INTEGER|FLOAT",
 /* 226 */ "minus_num ::= MINUS INTEGER|FLOAT",
 /* 227 */ "cmd ::= createkw trigger_decl BEGIN trigger_cmd_list END",
 /* 228 */ "trigger_decl ::= temp TRIGGER ifnotexists nm dbnm trigger_time trigger_event ON fullname foreach_clause when_clause",
 /* 229 */ "trigger_time ::= BEFORE",
 /* 230 */ "trigger_time ::= AFTER",
 /* 231 */ "trigger_time ::= INSTEAD OF",
 /* 232 */ "trigger_time ::=",
 /* 233 */ "trigger_event ::= DELETE|INSERT",
 /* 234 */ "trigger_event ::= UPDATE",
 /* 235 */ "trigger_event ::= UPDATE OF idlist",
 /* 236 */ "when_clause ::=",
 /* 237 */ "when_clause ::= WHEN expr",
 /* 238 */ "trigger_cmd_list ::= trigger_cmd_list trigger_cmd SEMI",
 /* 239 */ "trigger_cmd_list ::= trigger_cmd SEMI",
 /* 240 */ "trnm ::= nm DOT nm",
 /* 241 */ "tridxby ::= INDEXED BY nm",
 /* 242 */ "tridxby ::= NOT INDEXED",
 /* 243 */ "trigger_cmd ::= UPDATE orconf trnm tridxby SET setlist where_opt",
 /* 244 */ "trigger_cmd ::= insert_cmd INTO trnm idlist_opt select",
 /* 245 */ "trigger_cmd ::= DELETE FROM trnm tridxby where_opt",
 /* 246 */ "trigger_cmd ::= select",
 /* 247 */ "expr ::= RAISE LP IGNORE RP",
 /* 248 */ "expr ::= RAISE LP raisetype COMMA nm RP",
 /* 249 */ "raisetype ::= ROLLBACK",
 /* 250 */ "raisetype ::= ABORT",
 /* 251 */ "raisetype ::= FAIL",
 /* 252 */ "cmd ::= DROP TRIGGER ifexists fullname",
 /* 253 */ "cmd ::= ATTACH database_kw_opt expr AS expr key_opt",
 /* 254 */ "cmd ::= DETACH database_kw_opt expr",
 /* 255 */ "key_opt ::=",
 /* 256 */ "key_opt ::= KEY expr",
 /* 257 */ "cmd ::= REINDEX",
 /* 258 */ "cmd ::= REINDEX nm dbnm",
 /* 259 */ "cmd ::= ANALYZE",
 /* 260 */ "cmd ::= ANALYZE nm dbnm",
 /* 261 */ "cmd ::= ALTER TABLE fullname RENAME TO nm",
 /* 262 */ "cmd ::= ALTER TABLE add_column_fullname ADD kwcolumn_opt columnname carglist",
 /* 263 */ "add_column_fullname ::= fullname",
 /* 264 */ "cmd ::= create_vtab",
 /* 265 */ "cmd ::= create_vtab LP vtabarglist RP",
 /* 266 */ "create_vtab ::= createkw VIRTUAL TABLE ifnotexists nm dbnm USING nm",
 /* 267 */ "vtabarg ::=",
 /* 268 */ "vtabargtoken ::= ANY",
 /* 269 */ "vtabargtoken ::= lp anylist RP",
 /* 270 */ "lp ::= LP",
 /* 271 */ "with ::=",
 /* 272 */ "with ::= WITH wqlist",
 /* 273 */ "with ::= WITH RECURSIVE wqlist",
 /* 274 */ "wqlist ::= nm eidlist_opt AS LP select RP",
 /* 275 */ "wqlist ::= wqlist COMMA nm eidlist_opt AS LP select RP",
 /* 276 */ "input ::= cmdlist",
 /* 277 */ "cmdlist ::= cmdlist ecmd",
 /* 278 */ "cmdlist ::= ecmd",
 /* 279 */ "ecmd ::= SEMI",
 /* 280 */ "ecmd ::= explain cmdx SEMI",
 /* 281 */ "explain ::=",
 /* 282 */ "trans_opt ::=",
 /* 283 */ "trans_opt ::= TRANSACTION",
 /* 284 */ "trans_opt ::= TRANSACTION nm",
 /* 285 */ "savepoint_opt ::= SAVEPOINT",
 /* 286 */ "savepoint_opt ::=",
 /* 287 */ "cmd ::= create_table create_table_args",
 /* 288 */ "columnlist ::= columnlist COMMA columnname carglist",
 /* 289 */ "columnlist ::= columnname carglist",
 /* 290 */ "nm ::= ID|INDEXED",
 /* 291 */ "nm ::= STRING",
 /* 292 */ "nm ::= JOIN_KW",
 /* 293 */ "typetoken ::= typename",
 /* 294 */ "typename ::= ID|STRING",
 /* 295 */ "signed ::= plus_num",
 /* 296 */ "signed ::= minus_num",
 /* 297 */ "carglist ::= carglist ccons",
 /* 298 */ "carglist ::=",
 /* 299 */ "ccons ::= NULL onconf",
 /* 300 */ "conslist_opt ::= COMMA conslist",
 /* 301 */ "conslist ::= conslist tconscomma tcons",
 /* 302 */ "conslist ::= tcons",
 /* 303 */ "tconscomma ::=",
 /* 304 */ "defer_subclause_opt ::= defer_subclause",
 /* 305 */ "resolvetype ::= raisetype",
 /* 306 */ "selectnowith ::= oneselect",
 /* 307 */ "oneselect ::= values",
 /* 308 */ "sclp ::= selcollist COMMA",
 /* 309 */ "as ::= ID|STRING",
 /* 310 */ "expr ::= term",
 /* 311 */ "exprlist ::= nexprlist",
 /* 312 */ "nmnum ::= plus_num",
 /* 313 */ "nmnum ::= nm",
 /* 314 */ "nmnum ::= ON",
 /* 315 */ "nmnum ::= DELETE",
 /* 316 */ "nmnum ::= DEFAULT",
 /* 317 */ "plus_num ::= INTEGER|FLOAT",
 /* 318 */ "foreach_clause ::=",
 /* 319 */ "foreach_clause ::= FOR EACH ROW",
 /* 320 */ "trnm ::= nm",
 /* 321 */ "tridxby ::=",
 /* 322 */ "database_kw_opt ::= DATABASE",
 /* 323 */ "database_kw_opt ::=",
 /* 324 */ "kwcolumn_opt ::=",
 /* 325 */ "kwcolumn_opt ::= COLUMNKW",
 /* 326 */ "vtabarglist ::= vtabarg",
 /* 327 */ "vtabarglist ::= vtabarglist COMMA vtabarg",
 /* 328 */ "vtabarg ::= vtabarg vtabargtoken",
 /* 329 */ "anylist ::=",
 /* 330 */ "anylist ::= anylist LP anylist RP",
 /* 331 */ "anylist ::= anylist ANY",
};
#endif /* NDEBUG */


#if YYSTACKDEPTH<=0
/*
** Try to increase the size of the parser stack.  Return the number
** of errors.  Return 0 on success.
*/
static int yyGrowStack(yyParser *p){
  int newSize;
  int idx;
  yyStackEntry *pNew;

  newSize = p->yystksz*2 + 100;
  idx = p->yytos ? (int)(p->yytos - p->yystack) : 0;
  if( p->yystack==&p->yystk0 ){
    pNew = malloc(newSize*sizeof(pNew[0]));
    if( pNew ) pNew[0] = p->yystk0;
  }else{
    pNew = realloc(p->yystack, newSize*sizeof(pNew[0]));
  }
  if( pNew ){
    p->yystack = pNew;
    p->yytos = &p->yystack[idx];
#ifndef NDEBUG
    if( yyTraceFILE ){
      fprintf(yyTraceFILE,"%sStack grows from %d to %d entries.\n",
              yyTracePrompt, p->yystksz, newSize);
    }
#endif
    p->yystksz = newSize;
  }
  return pNew==0; 
}
#endif

/* Datatype of the argument to the memory allocated passed as the
** second argument to sqlite3ParserAlloc() below.  This can be changed by
** putting an appropriate #define in the %include section of the input
** grammar.
*/
#ifndef YYMALLOCARGTYPE
# define YYMALLOCARGTYPE size_t
#endif

/* 
** This function allocates a new parser.
** The only argument is a pointer to a function which works like
** malloc.
**
** Inputs:
** A pointer to the function used to allocate memory.
**
** Outputs:
** A pointer to a parser.  This pointer is used in subsequent calls
** to sqlite3Parser and sqlite3ParserFree.
*/
void *sqlite3ParserAlloc(void *(*mallocProc)(YYMALLOCARGTYPE)){
  yyParser *pParser;
  pParser = (yyParser*)(*mallocProc)( (YYMALLOCARGTYPE)sizeof(yyParser) );
  if( pParser ){
#ifdef YYTRACKMAXSTACKDEPTH
    pParser->yyhwm = 0;
#endif
#if YYSTACKDEPTH<=0
    pParser->yytos = NULL;
    pParser->yystack = NULL;
    pParser->yystksz = 0;
    if( yyGrowStack(pParser) ){
      pParser->yystack = &pParser->yystk0;
      pParser->yystksz = 1;
    }
#endif
#ifndef YYNOERRORRECOVERY
    pParser->yyerrcnt = -1;
#endif
    pParser->yytos = pParser->yystack;
    pParser->yystack[0].stateno = 0;
    pParser->yystack[0].major = 0;
  }
  return pParser;
}

/* The following function deletes the "minor type" or semantic value
** associated with a symbol.  The symbol can be either a terminal
** or nonterminal. "yymajor" is the symbol code, and "yypminor" is
** a pointer to the value to be deleted.  The code used to do the 
** deletions is derived from the %destructor and/or %token_destructor
** directives of the input grammar.
*/
static void yy_destructor(
  yyParser *yypParser,    /* The parser */
  YYCODETYPE yymajor,     /* Type code for object to destroy */
  YYMINORTYPE *yypminor   /* The object to be destroyed */
){
  sqlite3ParserARG_FETCH;
  switch( yymajor ){
    /* Here is inserted the actions which take place when a
    ** terminal or non-terminal is destroyed.  This can happen
    ** when the symbol is popped from the stack during a
    ** reduce or during error processing or when a parser is 
    ** being destroyed before it is finished parsing.
    **
    ** Note: during a reduce, the only symbols destroyed are those
    ** which appear on the RHS of the rule, but which are *not* used
    ** inside the C code.
    */
/********* Begin destructor definitions ***************************************/
    case 163: /* select */
    case 194: /* selectnowith */
    case 195: /* oneselect */
    case 206: /* values */
{
#line 396 "parse.y"
sqlite3SelectDelete(pParse->db, (yypminor->yy243));
#line 1575 "parse.c"
}
      break;
    case 172: /* term */
    case 173: /* expr */
{
#line 823 "parse.y"
sqlite3ExprDelete(pParse->db, (yypminor->yy190).pExpr);
#line 1583 "parse.c"
}
      break;
    case 177: /* eidlist_opt */
    case 186: /* sortlist */
    case 187: /* eidlist */
    case 199: /* selcollist */
    case 202: /* groupby_opt */
    case 204: /* orderby_opt */
    case 207: /* nexprlist */
    case 208: /* exprlist */
    case 209: /* sclp */
    case 218: /* setlist */
    case 224: /* paren_exprlist */
    case 226: /* case_exprlist */
{
#line 1270 "parse.y"
sqlite3ExprListDelete(pParse->db, (yypminor->yy148));
#line 1601 "parse.c"
}
      break;
    case 193: /* fullname */
    case 200: /* from */
    case 211: /* seltablist */
    case 212: /* stl_prefix */
{
#line 628 "parse.y"
sqlite3SrcListDelete(pParse->db, (yypminor->yy185));
#line 1611 "parse.c"
}
      break;
    case 196: /* with */
    case 250: /* wqlist */
{
#line 1547 "parse.y"
sqlite3WithDelete(pParse->db, (yypminor->yy285));
#line 1619 "parse.c"
}
      break;
    case 201: /* where_opt */
    case 203: /* having_opt */
    case 215: /* on_opt */
    case 225: /* case_operand */
    case 227: /* case_else */
    case 236: /* when_clause */
    case 241: /* key_opt */
{
#line 744 "parse.y"
sqlite3ExprDelete(pParse->db, (yypminor->yy72));
#line 1632 "parse.c"
}
      break;
    case 216: /* using_opt */
    case 217: /* idlist */
    case 220: /* idlist_opt */
{
#line 662 "parse.y"
sqlite3IdListDelete(pParse->db, (yypminor->yy254));
#line 1641 "parse.c"
}
      break;
    case 232: /* trigger_cmd_list */
    case 237: /* trigger_cmd */
{
#line 1384 "parse.y"
sqlite3DeleteTriggerStep(pParse->db, (yypminor->yy145));
#line 1649 "parse.c"
}
      break;
    case 234: /* trigger_event */
{
#line 1370 "parse.y"
sqlite3IdListDelete(pParse->db, (yypminor->yy332).b);
#line 1656 "parse.c"
}
      break;
/********* End destructor definitions *****************************************/
    default:  break;   /* If no destructor action specified: do nothing */
  }
}

/*
** Pop the parser's stack once.
**
** If there is a destructor routine associated with the token which
** is popped from the stack, then call it.
*/
static void yy_pop_parser_stack(yyParser *pParser){
  yyStackEntry *yytos;
  assert( pParser->yytos!=0 );
  assert( pParser->yytos > pParser->yystack );
  yytos = pParser->yytos--;
#ifndef NDEBUG
  if( yyTraceFILE ){
    fprintf(yyTraceFILE,"%sPopping %s\n",
      yyTracePrompt,
      yyTokenName[yytos->major]);
  }
#endif
  yy_destructor(pParser, yytos->major, &yytos->minor);
}

/* 
** Deallocate and destroy a parser.  Destructors are called for
** all stack elements before shutting the parser down.
**
** If the YYPARSEFREENEVERNULL macro exists (for example because it
** is defined in a %include section of the input grammar) then it is
** assumed that the input pointer is never NULL.
*/
void sqlite3ParserFree(
  void *p,                    /* The parser to be deleted */
  void (*freeProc)(void*)     /* Function used to reclaim memory */
){
  yyParser *pParser = (yyParser*)p;
#ifndef YYPARSEFREENEVERNULL
  if( pParser==0 ) return;
#endif
  while( pParser->yytos>pParser->yystack ) yy_pop_parser_stack(pParser);
#if YYSTACKDEPTH<=0
  if( pParser->yystack!=&pParser->yystk0 ) free(pParser->yystack);
#endif
  (*freeProc)((void*)pParser);
}

/*
** Return the peak depth of the stack for a parser.
*/
#ifdef YYTRACKMAXSTACKDEPTH
int sqlite3ParserStackPeak(void *p){
  yyParser *pParser = (yyParser*)p;
  return pParser->yyhwm;
}
#endif

/*
** Find the appropriate action for a parser given the terminal
** look-ahead token iLookAhead.
*/
static unsigned int yy_find_shift_action(
  yyParser *pParser,        /* The parser */
  YYCODETYPE iLookAhead     /* The look-ahead token */
){
  int i;
  int stateno = pParser->yytos->stateno;
 
  if( stateno>=YY_MIN_REDUCE ) return stateno;
  assert( stateno <= YY_SHIFT_COUNT );
  do{
    i = yy_shift_ofst[stateno];
    assert( iLookAhead!=YYNOCODE );
    i += iLookAhead;
    if( i<0 || i>=YY_ACTTAB_COUNT || yy_lookahead[i]!=iLookAhead ){
#ifdef YYFALLBACK
      YYCODETYPE iFallback;            /* Fallback token */
      if( iLookAhead<sizeof(yyFallback)/sizeof(yyFallback[0])
             && (iFallback = yyFallback[iLookAhead])!=0 ){
#ifndef NDEBUG
        if( yyTraceFILE ){
          fprintf(yyTraceFILE, "%sFALLBACK %s => %s\n",
             yyTracePrompt, yyTokenName[iLookAhead], yyTokenName[iFallback]);
        }
#endif
        assert( yyFallback[iFallback]==0 ); /* Fallback loop must terminate */
        iLookAhead = iFallback;
        continue;
      }
#endif
#ifdef YYWILDCARD
      {
        int j = i - iLookAhead + YYWILDCARD;
        if( 
#if YY_SHIFT_MIN+YYWILDCARD<0
          j>=0 &&
#endif
#if YY_SHIFT_MAX+YYWILDCARD>=YY_ACTTAB_COUNT
          j<YY_ACTTAB_COUNT &&
#endif
          yy_lookahead[j]==YYWILDCARD && iLookAhead>0
        ){
#ifndef NDEBUG
          if( yyTraceFILE ){
            fprintf(yyTraceFILE, "%sWILDCARD %s => %s\n",
               yyTracePrompt, yyTokenName[iLookAhead],
               yyTokenName[YYWILDCARD]);
          }
#endif /* NDEBUG */
          return yy_action[j];
        }
      }
#endif /* YYWILDCARD */
      return yy_default[stateno];
    }else{
      return yy_action[i];
    }
  }while(1);
}

/*
** Find the appropriate action for a parser given the non-terminal
** look-ahead token iLookAhead.
*/
static int yy_find_reduce_action(
  int stateno,              /* Current state number */
  YYCODETYPE iLookAhead     /* The look-ahead token */
){
  int i;
#ifdef YYERRORSYMBOL
  if( stateno>YY_REDUCE_COUNT ){
    return yy_default[stateno];
  }
#else
  assert( stateno<=YY_REDUCE_COUNT );
#endif
  i = yy_reduce_ofst[stateno];
  assert( i!=YY_REDUCE_USE_DFLT );
  assert( iLookAhead!=YYNOCODE );
  i += iLookAhead;
#ifdef YYERRORSYMBOL
  if( i<0 || i>=YY_ACTTAB_COUNT || yy_lookahead[i]!=iLookAhead ){
    return yy_default[stateno];
  }
#else
  assert( i>=0 && i<YY_ACTTAB_COUNT );
  assert( yy_lookahead[i]==iLookAhead );
#endif
  return yy_action[i];
}

/*
** The following routine is called if the stack overflows.
*/
static void yyStackOverflow(yyParser *yypParser){
   sqlite3ParserARG_FETCH;
   yypParser->yytos--;
#ifndef NDEBUG
   if( yyTraceFILE ){
     fprintf(yyTraceFILE,"%sStack Overflow!\n",yyTracePrompt);
   }
#endif
   while( yypParser->yytos>yypParser->yystack ) yy_pop_parser_stack(yypParser);
   /* Here code is inserted which will execute if the parser
   ** stack every overflows */
/******** Begin %stack_overflow code ******************************************/
#line 37 "parse.y"

  sqlite3ErrorMsg(pParse, "parser stack overflow");
#line 1830 "parse.c"
/******** End %stack_overflow code ********************************************/
   sqlite3ParserARG_STORE; /* Suppress warning about unused %extra_argument var */
}

/*
** Print tracing information for a SHIFT action
*/
#ifndef NDEBUG
static void yyTraceShift(yyParser *yypParser, int yyNewState){
  if( yyTraceFILE ){
    if( yyNewState<YYNSTATE ){
      fprintf(yyTraceFILE,"%sShift '%s', go to state %d\n",
         yyTracePrompt,yyTokenName[yypParser->yytos->major],
         yyNewState);
    }else{
      fprintf(yyTraceFILE,"%sShift '%s'\n",
         yyTracePrompt,yyTokenName[yypParser->yytos->major]);
    }
  }
}
#else
# define yyTraceShift(X,Y)
#endif

/*
** Perform a shift action.
*/
static void yy_shift(
  yyParser *yypParser,          /* The parser to be shifted */
  int yyNewState,               /* The new state to shift in */
  int yyMajor,                  /* The major token to shift in */
  sqlite3ParserTOKENTYPE yyMinor        /* The minor token to shift in */
){
  yyStackEntry *yytos;
  yypParser->yytos++;
#ifdef YYTRACKMAXSTACKDEPTH
  if( (int)(yypParser->yytos - yypParser->yystack)>yypParser->yyhwm ){
    yypParser->yyhwm++;
    assert( yypParser->yyhwm == (int)(yypParser->yytos - yypParser->yystack) );
  }
#endif
#if YYSTACKDEPTH>0 
  if( yypParser->yytos>=&yypParser->yystack[YYSTACKDEPTH] ){
    yyStackOverflow(yypParser);
    return;
  }
#else
  if( yypParser->yytos>=&yypParser->yystack[yypParser->yystksz] ){
    if( yyGrowStack(yypParser) ){
      yyStackOverflow(yypParser);
      return;
    }
  }
#endif
  if( yyNewState > YY_MAX_SHIFT ){
    yyNewState += YY_MIN_REDUCE - YY_MIN_SHIFTREDUCE;
  }
  yytos = yypParser->yytos;
  yytos->stateno = (YYACTIONTYPE)yyNewState;
  yytos->major = (YYCODETYPE)yyMajor;
  yytos->minor.yy0 = yyMinor;
  yyTraceShift(yypParser, yyNewState);
}

/* The following table contains information about every rule that
** is used during the reduce.
*/
static const struct {
  YYCODETYPE lhs;         /* Symbol on the left-hand side of the rule */
  unsigned char nrhs;     /* Number of right-hand side symbols in the rule */
} yyRuleInfo[] = {
  { 147, 1 },
  { 147, 3 },
  { 148, 1 },
  { 149, 3 },
  { 150, 0 },
  { 150, 1 },
  { 150, 1 },
  { 150, 1 },
  { 149, 2 },
  { 149, 2 },
  { 149, 2 },
  { 149, 2 },
  { 149, 3 },
  { 149, 5 },
  { 154, 6 },
  { 156, 1 },
  { 158, 0 },
  { 158, 3 },
  { 157, 1 },
  { 157, 0 },
  { 155, 5 },
  { 155, 2 },
  { 162, 0 },
  { 162, 2 },
  { 164, 2 },
  { 166, 0 },
  { 166, 4 },
  { 166, 6 },
  { 167, 2 },
  { 171, 2 },
  { 171, 2 },
  { 171, 4 },
  { 171, 3 },
  { 171, 3 },
  { 171, 2 },
  { 171, 3 },
  { 171, 5 },
  { 171, 2 },
  { 171, 4 },
  { 171, 4 },
  { 171, 1 },
  { 171, 2 },
  { 176, 0 },
  { 176, 1 },
  { 178, 0 },
  { 178, 2 },
  { 180, 2 },
  { 180, 3 },
  { 180, 3 },
  { 180, 3 },
  { 181, 2 },
  { 181, 2 },
  { 181, 1 },
  { 181, 1 },
  { 181, 2 },
  { 179, 3 },
  { 179, 2 },
  { 182, 0 },
  { 182, 2 },
  { 182, 2 },
  { 161, 0 },
  { 184, 1 },
  { 185, 2 },
  { 185, 7 },
  { 185, 5 },
  { 185, 5 },
  { 185, 10 },
  { 188, 0 },
  { 174, 0 },
  { 174, 3 },
  { 189, 0 },
  { 189, 2 },
  { 190, 1 },
  { 190, 1 },
  { 149, 4 },
  { 192, 2 },
  { 192, 0 },
  { 149, 9 },
  { 149, 4 },
  { 149, 1 },
  { 163, 2 },
  { 194, 3 },
  { 197, 1 },
  { 197, 2 },
  { 197, 1 },
  { 195, 9 },
  { 206, 4 },
  { 206, 5 },
  { 198, 1 },
  { 198, 1 },
  { 198, 0 },
  { 209, 0 },
  { 199, 3 },
  { 199, 2 },
  { 199, 4 },
  { 210, 2 },
  { 210, 0 },
  { 200, 0 },
  { 200, 2 },
  { 212, 2 },
  { 212, 0 },
  { 211, 7 },
  { 211, 9 },
  { 211, 7 },
  { 211, 7 },
  { 159, 0 },
  { 159, 2 },
  { 193, 2 },
  { 213, 1 },
  { 213, 2 },
  { 213, 3 },
  { 213, 4 },
  { 215, 2 },
  { 215, 0 },
  { 214, 0 },
  { 214, 3 },
  { 214, 2 },
  { 216, 4 },
  { 216, 0 },
  { 204, 0 },
  { 204, 3 },
  { 186, 4 },
  { 186, 2 },
  { 175, 1 },
  { 175, 1 },
  { 175, 0 },
  { 202, 0 },
  { 202, 3 },
  { 203, 0 },
  { 203, 2 },
  { 205, 0 },
  { 205, 2 },
  { 205, 4 },
  { 205, 4 },
  { 149, 8 },
  { 201, 0 },
  { 201, 2 },
  { 149, 10 },
  { 218, 5 },
  { 218, 7 },
  { 218, 3 },
  { 218, 5 },
  { 149, 6 },
  { 149, 7 },
  { 219, 2 },
  { 219, 1 },
  { 220, 0 },
  { 220, 3 },
  { 217, 3 },
  { 217, 1 },
  { 173, 3 },
  { 172, 1 },
  { 173, 1 },
  { 173, 1 },
  { 173, 3 },
  { 173, 5 },
  { 172, 1 },
  { 172, 1 },
  { 172, 1 },
  { 173, 1 },
  { 173, 3 },
  { 173, 6 },
  { 173, 5 },
  { 173, 4 },
  { 172, 1 },
  { 173, 5 },
  { 173, 3 },
  { 173, 3 },
  { 173, 3 },
  { 173, 3 },
  { 173, 3 },
  { 173, 3 },
  { 173, 3 },
  { 173, 3 },
  { 221, 1 },
  { 221, 2 },
  { 173, 3 },
  { 173, 5 },
  { 173, 2 },
  { 173, 3 },
  { 173, 3 },
  { 173, 4 },
  { 173, 2 },
  { 173, 2 },
  { 173, 2 },
  { 173, 2 },
  { 222, 1 },
  { 222, 2 },
  { 173, 5 },
  { 223, 1 },
  { 223, 2 },
  { 173, 5 },
  { 173, 3 },
  { 173, 5 },
  { 173, 5 },
  { 173, 4 },
  { 173, 5 },
  { 226, 5 },
  { 226, 4 },
  { 227, 2 },
  { 227, 0 },
  { 225, 1 },
  { 225, 0 },
  { 208, 0 },
  { 207, 3 },
  { 207, 1 },
  { 224, 0 },
  { 224, 3 },
  { 149, 12 },
  { 228, 1 },
  { 228, 0 },
  { 177, 0 },
  { 177, 3 },
  { 187, 5 },
  { 187, 3 },
  { 229, 0 },
  { 229, 2 },
  { 149, 4 },
  { 149, 1 },
  { 149, 2 },
  { 149, 3 },
  { 149, 5 },
  { 149, 6 },
  { 149, 5 },
  { 149, 6 },
  { 169, 2 },
  { 170, 2 },
  { 149, 5 },
  { 231, 11 },
  { 233, 1 },
  { 233, 1 },
  { 233, 2 },
  { 233, 0 },
  { 234, 1 },
  { 234, 1 },
  { 234, 3 },
  { 236, 0 },
  { 236, 2 },
  { 232, 3 },
  { 232, 2 },
  { 238, 3 },
  { 239, 3 },
  { 239, 2 },
  { 237, 7 },
  { 237, 5 },
  { 237, 5 },
  { 237, 1 },
  { 173, 4 },
  { 173, 6 },
  { 191, 1 },
  { 191, 1 },
  { 191, 1 },
  { 149, 4 },
  { 149, 6 },
  { 149, 3 },
  { 241, 0 },
  { 241, 2 },
  { 149, 1 },
  { 149, 3 },
  { 149, 1 },
  { 149, 3 },
  { 149, 6 },
  { 149, 7 },
  { 242, 1 },
  { 149, 1 },
  { 149, 4 },
  { 244, 8 },
  { 246, 0 },
  { 247, 1 },
  { 247, 3 },
  { 248, 1 },
  { 196, 0 },
  { 196, 2 },
  { 196, 3 },
  { 250, 6 },
  { 250, 8 },
  { 144, 1 },
  { 145, 2 },
  { 145, 1 },
  { 146, 1 },
  { 146, 3 },
  { 147, 0 },
  { 151, 0 },
  { 151, 1 },
  { 151, 2 },
  { 153, 1 },
  { 153, 0 },
  { 149, 2 },
  { 160, 4 },
  { 160, 2 },
  { 152, 1 },
  { 152, 1 },
  { 152, 1 },
  { 166, 1 },
  { 167, 1 },
  { 168, 1 },
  { 168, 1 },
  { 165, 2 },
  { 165, 0 },
  { 171, 2 },
  { 161, 2 },
  { 183, 3 },
  { 183, 1 },
  { 184, 0 },
  { 188, 1 },
  { 190, 1 },
  { 194, 1 },
  { 195, 1 },
  { 209, 2 },
  { 210, 1 },
  { 173, 1 },
  { 208, 1 },
  { 230, 1 },
  { 230, 1 },
  { 230, 1 },
  { 230, 1 },
  { 230, 1 },
  { 169, 1 },
  { 235, 0 },
  { 235, 3 },
  { 238, 1 },
  { 239, 0 },
  { 240, 1 },
  { 240, 0 },
  { 243, 0 },
  { 243, 1 },
  { 245, 1 },
  { 245, 3 },
  { 246, 2 },
  { 249, 0 },
  { 249, 4 },
  { 249, 2 },
};

static void yy_accept(yyParser*);  /* Forward Declaration */

/*
** Perform a reduce action and the shift that must immediately
** follow the reduce.
*/
static void yy_reduce(
  yyParser *yypParser,         /* The parser */
  unsigned int yyruleno        /* Number of the rule by which to reduce */
){
  int yygoto;                     /* The next state */
  int yyact;                      /* The next action */
  yyStackEntry *yymsp;            /* The top of the parser's stack */
  int yysize;                     /* Amount to pop the stack */
  sqlite3ParserARG_FETCH;
  yymsp = yypParser->yytos;
#ifndef NDEBUG
  if( yyTraceFILE && yyruleno<(int)(sizeof(yyRuleName)/sizeof(yyRuleName[0])) ){
    yysize = yyRuleInfo[yyruleno].nrhs;
    fprintf(yyTraceFILE, "%sReduce [%s], go to state %d.\n", yyTracePrompt,
      yyRuleName[yyruleno], yymsp[-yysize].stateno);
  }
#endif /* NDEBUG */

  /* Check that the stack is large enough to grow by a single entry
  ** if the RHS of the rule is empty.  This ensures that there is room
  ** enough on the stack to push the LHS value */
  if( yyRuleInfo[yyruleno].nrhs==0 ){
#ifdef YYTRACKMAXSTACKDEPTH
    if( (int)(yypParser->yytos - yypParser->yystack)>yypParser->yyhwm ){
      yypParser->yyhwm++;
      assert( yypParser->yyhwm == (int)(yypParser->yytos - yypParser->yystack));
    }
#endif
#if YYSTACKDEPTH>0 
    if( yypParser->yytos>=&yypParser->yystack[YYSTACKDEPTH-1] ){
      yyStackOverflow(yypParser);
      return;
    }
#else
    if( yypParser->yytos>=&yypParser->yystack[yypParser->yystksz-1] ){
      if( yyGrowStack(yypParser) ){
        yyStackOverflow(yypParser);
        return;
      }
      yymsp = yypParser->yytos;
    }
#endif
  }

  switch( yyruleno ){
  /* Beginning here are the reduction cases.  A typical example
  ** follows:
  **   case 0:
  **  #line <lineno> <grammarfile>
  **     { ... }           // User supplied code
  **  #line <lineno> <thisfile>
  **     break;
  */
/********** Begin reduce actions **********************************************/
        YYMINORTYPE yylhsminor;
      case 0: /* explain ::= EXPLAIN */
#line 113 "parse.y"
{ pParse->explain = 1; }
#line 2300 "parse.c"
        break;
      case 1: /* explain ::= EXPLAIN QUERY PLAN */
#line 114 "parse.y"
{ pParse->explain = 2; }
#line 2305 "parse.c"
        break;
      case 2: /* cmdx ::= cmd */
#line 116 "parse.y"
{ sqlite3FinishCoding(pParse); }
#line 2310 "parse.c"
        break;
      case 3: /* cmd ::= BEGIN transtype trans_opt */
#line 121 "parse.y"
{sqlite3BeginTransaction(pParse, yymsp[-1].minor.yy194);}
#line 2315 "parse.c"
        break;
      case 4: /* transtype ::= */
#line 126 "parse.y"
{yymsp[1].minor.yy194 = TK_DEFERRED;}
#line 2320 "parse.c"
        break;
      case 5: /* transtype ::= DEFERRED */
      case 6: /* transtype ::= IMMEDIATE */ yytestcase(yyruleno==6);
      case 7: /* transtype ::= EXCLUSIVE */ yytestcase(yyruleno==7);
#line 127 "parse.y"
{yymsp[0].minor.yy194 = yymsp[0].major; /*A-overwrites-X*/}
#line 2327 "parse.c"
        break;
      case 8: /* cmd ::= COMMIT trans_opt */
      case 9: /* cmd ::= END trans_opt */ yytestcase(yyruleno==9);
#line 130 "parse.y"
{sqlite3CommitTransaction(pParse);}
#line 2333 "parse.c"
        break;
      case 10: /* cmd ::= ROLLBACK trans_opt */
#line 132 "parse.y"
{sqlite3RollbackTransaction(pParse);}
#line 2338 "parse.c"
        break;
      case 11: /* cmd ::= SAVEPOINT nm */
#line 136 "parse.y"
{
  sqlite3Savepoint(pParse, SAVEPOINT_BEGIN, &yymsp[0].minor.yy0);
}
#line 2345 "parse.c"
        break;
      case 12: /* cmd ::= RELEASE savepoint_opt nm */
#line 139 "parse.y"
{
  sqlite3Savepoint(pParse, SAVEPOINT_RELEASE, &yymsp[0].minor.yy0);
}
#line 2352 "parse.c"
        break;
      case 13: /* cmd ::= ROLLBACK trans_opt TO savepoint_opt nm */
#line 142 "parse.y"
{
  sqlite3Savepoint(pParse, SAVEPOINT_ROLLBACK, &yymsp[0].minor.yy0);
}
#line 2359 "parse.c"
        break;
      case 14: /* create_table ::= createkw temp TABLE ifnotexists nm dbnm */
#line 149 "parse.y"
{
   sqlite3StartTable(pParse,&yymsp[-1].minor.yy0,&yymsp[0].minor.yy0,yymsp[-4].minor.yy194,0,0,yymsp[-2].minor.yy194);
}
#line 2366 "parse.c"
        break;
      case 15: /* createkw ::= CREATE */
#line 152 "parse.y"
{disableLookaside(pParse);}
#line 2371 "parse.c"
        break;
      case 16: /* ifnotexists ::= */
      case 19: /* temp ::= */ yytestcase(yyruleno==19);
      case 22: /* table_options ::= */ yytestcase(yyruleno==22);
      case 42: /* autoinc ::= */ yytestcase(yyruleno==42);
      case 57: /* init_deferred_pred_opt ::= */ yytestcase(yyruleno==57);
      case 67: /* defer_subclause_opt ::= */ yytestcase(yyruleno==67);
      case 76: /* ifexists ::= */ yytestcase(yyruleno==76);
      case 90: /* distinct ::= */ yytestcase(yyruleno==90);
      case 215: /* collate ::= */ yytestcase(yyruleno==215);
#line 155 "parse.y"
{yymsp[1].minor.yy194 = 0;}
#line 2384 "parse.c"
        break;
      case 17: /* ifnotexists ::= IF NOT EXISTS */
#line 156 "parse.y"
{yymsp[-2].minor.yy194 = 1;}
#line 2389 "parse.c"
        break;
      case 18: /* temp ::= TEMP */
      case 43: /* autoinc ::= AUTOINCR */ yytestcase(yyruleno==43);
#line 159 "parse.y"
{yymsp[0].minor.yy194 = 1;}
#line 2395 "parse.c"
        break;
      case 20: /* create_table_args ::= LP columnlist conslist_opt RP table_options */
#line 162 "parse.y"
{
  sqlite3EndTable(pParse,&yymsp[-2].minor.yy0,&yymsp[-1].minor.yy0,yymsp[0].minor.yy194,0);
}
#line 2402 "parse.c"
        break;
      case 21: /* create_table_args ::= AS select */
#line 165 "parse.y"
{
  sqlite3EndTable(pParse,0,0,0,yymsp[0].minor.yy243);
  sqlite3SelectDelete(pParse->db, yymsp[0].minor.yy243);
}
#line 2410 "parse.c"
        break;
      case 23: /* table_options ::= WITHOUT nm */
#line 171 "parse.y"
{
  if( yymsp[0].minor.yy0.n==5 && sqlite3_strnicmp(yymsp[0].minor.yy0.z,"rowid",5)==0 ){
    yymsp[-1].minor.yy194 = TF_WithoutRowid | TF_NoVisibleRowid;
  }else{
    yymsp[-1].minor.yy194 = 0;
    sqlite3ErrorMsg(pParse, "unknown table option: %.*s", yymsp[0].minor.yy0.n, yymsp[0].minor.yy0.z);
  }
}
#line 2422 "parse.c"
        break;
      case 24: /* columnname ::= nm typetoken */
#line 181 "parse.y"
{sqlite3AddColumn(pParse,&yymsp[-1].minor.yy0,&yymsp[0].minor.yy0);}
#line 2427 "parse.c"
        break;
      case 25: /* typetoken ::= */
      case 60: /* conslist_opt ::= */ yytestcase(yyruleno==60);
      case 96: /* as ::= */ yytestcase(yyruleno==96);
#line 246 "parse.y"
{yymsp[1].minor.yy0.n = 0; yymsp[1].minor.yy0.z = 0;}
#line 2434 "parse.c"
        break;
      case 26: /* typetoken ::= typename LP signed RP */
#line 248 "parse.y"
{
  yymsp[-3].minor.yy0.n = (int)(&yymsp[0].minor.yy0.z[yymsp[0].minor.yy0.n] - yymsp[-3].minor.yy0.z);
}
#line 2441 "parse.c"
        break;
      case 27: /* typetoken ::= typename LP signed COMMA signed RP */
#line 251 "parse.y"
{
  yymsp[-5].minor.yy0.n = (int)(&yymsp[0].minor.yy0.z[yymsp[0].minor.yy0.n] - yymsp[-5].minor.yy0.z);
}
#line 2448 "parse.c"
        break;
      case 28: /* typename ::= typename ID|STRING */
#line 256 "parse.y"
{yymsp[-1].minor.yy0.n=yymsp[0].minor.yy0.n+(int)(yymsp[0].minor.yy0.z-yymsp[-1].minor.yy0.z);}
#line 2453 "parse.c"
        break;
      case 29: /* ccons ::= CONSTRAINT nm */
      case 62: /* tcons ::= CONSTRAINT nm */ yytestcase(yyruleno==62);
#line 265 "parse.y"
{pParse->constraintName = yymsp[0].minor.yy0;}
#line 2459 "parse.c"
        break;
      case 30: /* ccons ::= DEFAULT term */
      case 32: /* ccons ::= DEFAULT PLUS term */ yytestcase(yyruleno==32);
#line 266 "parse.y"
{sqlite3AddDefaultValue(pParse,&yymsp[0].minor.yy190);}
#line 2465 "parse.c"
        break;
      case 31: /* ccons ::= DEFAULT LP expr RP */
#line 267 "parse.y"
{sqlite3AddDefaultValue(pParse,&yymsp[-1].minor.yy190);}
#line 2470 "parse.c"
        break;
      case 33: /* ccons ::= DEFAULT MINUS term */
#line 269 "parse.y"
{
  ExprSpan v;
  v.pExpr = sqlite3PExpr(pParse, TK_UMINUS, yymsp[0].minor.yy190.pExpr, 0, 0);
  v.zStart = yymsp[-1].minor.yy0.z;
  v.zEnd = yymsp[0].minor.yy190.zEnd;
  sqlite3AddDefaultValue(pParse,&v);
}
#line 2481 "parse.c"
        break;
      case 34: /* ccons ::= DEFAULT ID|INDEXED */
#line 276 "parse.y"
{
  ExprSpan v;
  spanExpr(&v, pParse, TK_STRING, yymsp[0].minor.yy0);
  sqlite3AddDefaultValue(pParse,&v);
}
#line 2490 "parse.c"
        break;
      case 35: /* ccons ::= NOT NULL onconf */
#line 286 "parse.y"
{sqlite3AddNotNull(pParse, yymsp[0].minor.yy194);}
#line 2495 "parse.c"
        break;
      case 36: /* ccons ::= PRIMARY KEY sortorder onconf autoinc */
#line 288 "parse.y"
{sqlite3AddPrimaryKey(pParse,0,yymsp[-1].minor.yy194,yymsp[0].minor.yy194,yymsp[-2].minor.yy194);}
#line 2500 "parse.c"
        break;
      case 37: /* ccons ::= UNIQUE onconf */
#line 289 "parse.y"
{sqlite3CreateIndex(pParse,0,0,0,0,yymsp[0].minor.yy194,0,0,0,0,
                                   SQLITE_IDXTYPE_UNIQUE);}
#line 2506 "parse.c"
        break;
      case 38: /* ccons ::= CHECK LP expr RP */
#line 291 "parse.y"
{sqlite3AddCheckConstraint(pParse,yymsp[-1].minor.yy190.pExpr);}
#line 2511 "parse.c"
        break;
      case 39: /* ccons ::= REFERENCES nm eidlist_opt refargs */
#line 293 "parse.y"
{sqlite3CreateForeignKey(pParse,0,&yymsp[-2].minor.yy0,yymsp[-1].minor.yy148,yymsp[0].minor.yy194);}
#line 2516 "parse.c"
        break;
      case 40: /* ccons ::= defer_subclause */
#line 294 "parse.y"
{sqlite3DeferForeignKey(pParse,yymsp[0].minor.yy194);}
#line 2521 "parse.c"
        break;
      case 41: /* ccons ::= COLLATE ID|STRING */
#line 295 "parse.y"
{sqlite3AddCollateType(pParse, &yymsp[0].minor.yy0);}
#line 2526 "parse.c"
        break;
      case 44: /* refargs ::= */
#line 308 "parse.y"
{ yymsp[1].minor.yy194 = OE_None*0x0101; /* EV: R-19803-45884 */}
#line 2531 "parse.c"
        break;
      case 45: /* refargs ::= refargs refarg */
#line 309 "parse.y"
{ yymsp[-1].minor.yy194 = (yymsp[-1].minor.yy194 & ~yymsp[0].minor.yy497.mask) | yymsp[0].minor.yy497.value; }
#line 2536 "parse.c"
        break;
      case 46: /* refarg ::= MATCH nm */
#line 311 "parse.y"
{ yymsp[-1].minor.yy497.value = 0;     yymsp[-1].minor.yy497.mask = 0x000000; }
#line 2541 "parse.c"
        break;
      case 47: /* refarg ::= ON INSERT refact */
#line 312 "parse.y"
{ yymsp[-2].minor.yy497.value = 0;     yymsp[-2].minor.yy497.mask = 0x000000; }
#line 2546 "parse.c"
        break;
      case 48: /* refarg ::= ON DELETE refact */
#line 313 "parse.y"
{ yymsp[-2].minor.yy497.value = yymsp[0].minor.yy194;     yymsp[-2].minor.yy497.mask = 0x0000ff; }
#line 2551 "parse.c"
        break;
      case 49: /* refarg ::= ON UPDATE refact */
#line 314 "parse.y"
{ yymsp[-2].minor.yy497.value = yymsp[0].minor.yy194<<8;  yymsp[-2].minor.yy497.mask = 0x00ff00; }
#line 2556 "parse.c"
        break;
      case 50: /* refact ::= SET NULL */
#line 316 "parse.y"
{ yymsp[-1].minor.yy194 = OE_SetNull;  /* EV: R-33326-45252 */}
#line 2561 "parse.c"
        break;
      case 51: /* refact ::= SET DEFAULT */
#line 317 "parse.y"
{ yymsp[-1].minor.yy194 = OE_SetDflt;  /* EV: R-33326-45252 */}
#line 2566 "parse.c"
        break;
      case 52: /* refact ::= CASCADE */
#line 318 "parse.y"
{ yymsp[0].minor.yy194 = OE_Cascade;  /* EV: R-33326-45252 */}
#line 2571 "parse.c"
        break;
      case 53: /* refact ::= RESTRICT */
#line 319 "parse.y"
{ yymsp[0].minor.yy194 = OE_Restrict; /* EV: R-33326-45252 */}
#line 2576 "parse.c"
        break;
      case 54: /* refact ::= NO ACTION */
#line 320 "parse.y"
{ yymsp[-1].minor.yy194 = OE_None;     /* EV: R-33326-45252 */}
#line 2581 "parse.c"
        break;
      case 55: /* defer_subclause ::= NOT DEFERRABLE init_deferred_pred_opt */
#line 322 "parse.y"
{yymsp[-2].minor.yy194 = 0;}
#line 2586 "parse.c"
        break;
      case 56: /* defer_subclause ::= DEFERRABLE init_deferred_pred_opt */
      case 71: /* orconf ::= OR resolvetype */ yytestcase(yyruleno==71);
      case 144: /* insert_cmd ::= INSERT orconf */ yytestcase(yyruleno==144);
#line 323 "parse.y"
{yymsp[-1].minor.yy194 = yymsp[0].minor.yy194;}
#line 2593 "parse.c"
        break;
      case 58: /* init_deferred_pred_opt ::= INITIALLY DEFERRED */
      case 75: /* ifexists ::= IF EXISTS */ yytestcase(yyruleno==75);
      case 187: /* between_op ::= NOT BETWEEN */ yytestcase(yyruleno==187);
      case 190: /* in_op ::= NOT IN */ yytestcase(yyruleno==190);
      case 216: /* collate ::= COLLATE ID|STRING */ yytestcase(yyruleno==216);
#line 326 "parse.y"
{yymsp[-1].minor.yy194 = 1;}
#line 2602 "parse.c"
        break;
      case 59: /* init_deferred_pred_opt ::= INITIALLY IMMEDIATE */
#line 327 "parse.y"
{yymsp[-1].minor.yy194 = 0;}
#line 2607 "parse.c"
        break;
      case 61: /* tconscomma ::= COMMA */
#line 333 "parse.y"
{pParse->constraintName.n = 0;}
#line 2612 "parse.c"
        break;
      case 63: /* tcons ::= PRIMARY KEY LP sortlist autoinc RP onconf */
#line 337 "parse.y"
{sqlite3AddPrimaryKey(pParse,yymsp[-3].minor.yy148,yymsp[0].minor.yy194,yymsp[-2].minor.yy194,0);}
#line 2617 "parse.c"
        break;
      case 64: /* tcons ::= UNIQUE LP sortlist RP onconf */
#line 339 "parse.y"
{sqlite3CreateIndex(pParse,0,0,0,yymsp[-2].minor.yy148,yymsp[0].minor.yy194,0,0,0,0,
                                       SQLITE_IDXTYPE_UNIQUE);}
#line 2623 "parse.c"
        break;
      case 65: /* tcons ::= CHECK LP expr RP onconf */
#line 342 "parse.y"
{sqlite3AddCheckConstraint(pParse,yymsp[-2].minor.yy190.pExpr);}
#line 2628 "parse.c"
        break;
      case 66: /* tcons ::= FOREIGN KEY LP eidlist RP REFERENCES nm eidlist_opt refargs defer_subclause_opt */
#line 344 "parse.y"
{
    sqlite3CreateForeignKey(pParse, yymsp[-6].minor.yy148, &yymsp[-3].minor.yy0, yymsp[-2].minor.yy148, yymsp[-1].minor.yy194);
    sqlite3DeferForeignKey(pParse, yymsp[0].minor.yy194);
}
#line 2636 "parse.c"
        break;
      case 68: /* onconf ::= */
      case 70: /* orconf ::= */ yytestcase(yyruleno==70);
#line 358 "parse.y"
{yymsp[1].minor.yy194 = OE_Default;}
#line 2642 "parse.c"
        break;
      case 69: /* onconf ::= ON CONFLICT resolvetype */
#line 359 "parse.y"
{yymsp[-2].minor.yy194 = yymsp[0].minor.yy194;}
#line 2647 "parse.c"
        break;
      case 72: /* resolvetype ::= IGNORE */
#line 363 "parse.y"
{yymsp[0].minor.yy194 = OE_Ignore;}
#line 2652 "parse.c"
        break;
      case 73: /* resolvetype ::= REPLACE */
      case 145: /* insert_cmd ::= REPLACE */ yytestcase(yyruleno==145);
#line 364 "parse.y"
{yymsp[0].minor.yy194 = OE_Replace;}
#line 2658 "parse.c"
        break;
      case 74: /* cmd ::= DROP TABLE ifexists fullname */
#line 368 "parse.y"
{
  sqlite3DropTable(pParse, yymsp[0].minor.yy185, 0, yymsp[-1].minor.yy194);
}
#line 2665 "parse.c"
        break;
      case 77: /* cmd ::= createkw temp VIEW ifnotexists nm dbnm eidlist_opt AS select */
#line 379 "parse.y"
{
  sqlite3CreateView(pParse, &yymsp[-8].minor.yy0, &yymsp[-4].minor.yy0, &yymsp[-3].minor.yy0, yymsp[-2].minor.yy148, yymsp[0].minor.yy243, yymsp[-7].minor.yy194, yymsp[-5].minor.yy194);
}
#line 2672 "parse.c"
        break;
      case 78: /* cmd ::= DROP VIEW ifexists fullname */
#line 382 "parse.y"
{
  sqlite3DropTable(pParse, yymsp[0].minor.yy185, 1, yymsp[-1].minor.yy194);
}
#line 2679 "parse.c"
        break;
      case 79: /* cmd ::= select */
#line 389 "parse.y"
{
  SelectDest dest = {SRT_Output, 0, 0, 0, 0, 0};
  sqlite3Select(pParse, yymsp[0].minor.yy243, &dest);
  sqlite3SelectDelete(pParse->db, yymsp[0].minor.yy243);
}
#line 2688 "parse.c"
        break;
      case 80: /* select ::= with selectnowith */
#line 426 "parse.y"
{
  Select *p = yymsp[0].minor.yy243;
  if( p ){
    p->pWith = yymsp[-1].minor.yy285;
    parserDoubleLinkSelect(pParse, p);
  }else{
    sqlite3WithDelete(pParse->db, yymsp[-1].minor.yy285);
  }
  yymsp[-1].minor.yy243 = p; /*A-overwrites-W*/
}
#line 2702 "parse.c"
        break;
      case 81: /* selectnowith ::= selectnowith multiselect_op oneselect */
#line 439 "parse.y"
{
  Select *pRhs = yymsp[0].minor.yy243;
  Select *pLhs = yymsp[-2].minor.yy243;
  if( pRhs && pRhs->pPrior ){
    SrcList *pFrom;
    Token x;
    x.n = 0;
    parserDoubleLinkSelect(pParse, pRhs);
    pFrom = sqlite3SrcListAppendFromTerm(pParse,0,0,0,&x,pRhs,0,0);
    pRhs = sqlite3SelectNew(pParse,0,pFrom,0,0,0,0,0,0,0);
  }
  if( pRhs ){
    pRhs->op = (u8)yymsp[-1].minor.yy194;
    pRhs->pPrior = pLhs;
    if( ALWAYS(pLhs) ) pLhs->selFlags &= ~SF_MultiValue;
    pRhs->selFlags &= ~SF_MultiValue;
    if( yymsp[-1].minor.yy194!=TK_ALL ) pParse->hasCompound = 1;
  }else{
    sqlite3SelectDelete(pParse->db, pLhs);
  }
  yymsp[-2].minor.yy243 = pRhs;
}
#line 2728 "parse.c"
        break;
      case 82: /* multiselect_op ::= UNION */
      case 84: /* multiselect_op ::= EXCEPT|INTERSECT */ yytestcase(yyruleno==84);
#line 462 "parse.y"
{yymsp[0].minor.yy194 = yymsp[0].major; /*A-overwrites-OP*/}
#line 2734 "parse.c"
        break;
      case 83: /* multiselect_op ::= UNION ALL */
#line 463 "parse.y"
{yymsp[-1].minor.yy194 = TK_ALL;}
#line 2739 "parse.c"
        break;
      case 85: /* oneselect ::= SELECT distinct selcollist from where_opt groupby_opt having_opt orderby_opt limit_opt */
#line 467 "parse.y"
{
#if SELECTTRACE_ENABLED
  Token s = yymsp[-8].minor.yy0; /*A-overwrites-S*/
#endif
  yymsp[-8].minor.yy243 = sqlite3SelectNew(pParse,yymsp[-6].minor.yy148,yymsp[-5].minor.yy185,yymsp[-4].minor.yy72,yymsp[-3].minor.yy148,yymsp[-2].minor.yy72,yymsp[-1].minor.yy148,yymsp[-7].minor.yy194,yymsp[0].minor.yy354.pLimit,yymsp[0].minor.yy354.pOffset);
#if SELECTTRACE_ENABLED
  /* Populate the Select.zSelName[] string that is used to help with
  ** query planner debugging, to differentiate between multiple Select
  ** objects in a complex query.
  **
  ** If the SELECT keyword is immediately followed by a C-style comment
  ** then extract the first few alphanumeric characters from within that
  ** comment to be the zSelName value.  Otherwise, the label is #N where
  ** is an integer that is incremented with each SELECT statement seen.
  */
  if( yymsp[-8].minor.yy243!=0 ){
    const char *z = s.z+6;
    int i;
    sqlite3_snprintf(sizeof(yymsp[-8].minor.yy243->zSelName), yymsp[-8].minor.yy243->zSelName, "#%d",
                     ++pParse->nSelect);
    while( z[0]==' ' ) z++;
    if( z[0]=='/' && z[1]=='*' ){
      z += 2;
      while( z[0]==' ' ) z++;
      for(i=0; sqlite3Isalnum(z[i]); i++){}
      sqlite3_snprintf(sizeof(yymsp[-8].minor.yy243->zSelName), yymsp[-8].minor.yy243->zSelName, "%.*s", i, z);
    }
  }
#endif /* SELECTRACE_ENABLED */
}
#line 2773 "parse.c"
        break;
      case 86: /* values ::= VALUES LP nexprlist RP */
#line 501 "parse.y"
{
  yymsp[-3].minor.yy243 = sqlite3SelectNew(pParse,yymsp[-1].minor.yy148,0,0,0,0,0,SF_Values,0,0);
}
#line 2780 "parse.c"
        break;
      case 87: /* values ::= values COMMA LP exprlist RP */
#line 504 "parse.y"
{
  Select *pRight, *pLeft = yymsp[-4].minor.yy243;
  pRight = sqlite3SelectNew(pParse,yymsp[-1].minor.yy148,0,0,0,0,0,SF_Values|SF_MultiValue,0,0);
  if( ALWAYS(pLeft) ) pLeft->selFlags &= ~SF_MultiValue;
  if( pRight ){
    pRight->op = TK_ALL;
    pRight->pPrior = pLeft;
    yymsp[-4].minor.yy243 = pRight;
  }else{
    yymsp[-4].minor.yy243 = pLeft;
  }
}
#line 2796 "parse.c"
        break;
      case 88: /* distinct ::= DISTINCT */
#line 521 "parse.y"
{yymsp[0].minor.yy194 = SF_Distinct;}
#line 2801 "parse.c"
        break;
      case 89: /* distinct ::= ALL */
#line 522 "parse.y"
{yymsp[0].minor.yy194 = SF_All;}
#line 2806 "parse.c"
        break;
      case 91: /* sclp ::= */
      case 119: /* orderby_opt ::= */ yytestcase(yyruleno==119);
      case 126: /* groupby_opt ::= */ yytestcase(yyruleno==126);
      case 203: /* exprlist ::= */ yytestcase(yyruleno==203);
      case 206: /* paren_exprlist ::= */ yytestcase(yyruleno==206);
      case 211: /* eidlist_opt ::= */ yytestcase(yyruleno==211);
#line 535 "parse.y"
{yymsp[1].minor.yy148 = 0;}
#line 2816 "parse.c"
        break;
      case 92: /* selcollist ::= sclp expr as */
#line 536 "parse.y"
{
   yymsp[-2].minor.yy148 = sqlite3ExprListAppend(pParse, yymsp[-2].minor.yy148, yymsp[-1].minor.yy190.pExpr);
   if( yymsp[0].minor.yy0.n>0 ) sqlite3ExprListSetName(pParse, yymsp[-2].minor.yy148, &yymsp[0].minor.yy0, 1);
   sqlite3ExprListSetSpan(pParse,yymsp[-2].minor.yy148,&yymsp[-1].minor.yy190);
}
#line 2825 "parse.c"
        break;
      case 93: /* selcollist ::= sclp STAR */
#line 541 "parse.y"
{
  Expr *p = sqlite3Expr(pParse->db, TK_ASTERISK, 0);
  yymsp[-1].minor.yy148 = sqlite3ExprListAppend(pParse, yymsp[-1].minor.yy148, p);
}
#line 2833 "parse.c"
        break;
      case 94: /* selcollist ::= sclp nm DOT STAR */
#line 545 "parse.y"
{
  Expr *pRight = sqlite3PExpr(pParse, TK_ASTERISK, 0, 0, 0);
  Expr *pLeft = sqlite3PExpr(pParse, TK_ID, 0, 0, &yymsp[-2].minor.yy0);
  Expr *pDot = sqlite3PExpr(pParse, TK_DOT, pLeft, pRight, 0);
  yymsp[-3].minor.yy148 = sqlite3ExprListAppend(pParse,yymsp[-3].minor.yy148, pDot);
}
#line 2843 "parse.c"
        break;
      case 95: /* as ::= AS nm */
      case 106: /* dbnm ::= DOT nm */ yytestcase(yyruleno==106);
      case 225: /* plus_num ::= PLUS INTEGER|FLOAT */ yytestcase(yyruleno==225);
      case 226: /* minus_num ::= MINUS INTEGER|FLOAT */ yytestcase(yyruleno==226);
#line 556 "parse.y"
{yymsp[-1].minor.yy0 = yymsp[0].minor.yy0;}
#line 2851 "parse.c"
        break;
      case 97: /* from ::= */
#line 570 "parse.y"
{yymsp[1].minor.yy185 = sqlite3DbMallocZero(pParse->db, sizeof(*yymsp[1].minor.yy185));}
#line 2856 "parse.c"
        break;
      case 98: /* from ::= FROM seltablist */
#line 571 "parse.y"
{
  yymsp[-1].minor.yy185 = yymsp[0].minor.yy185;
  sqlite3SrcListShiftJoinType(yymsp[-1].minor.yy185);
}
#line 2864 "parse.c"
        break;
      case 99: /* stl_prefix ::= seltablist joinop */
#line 579 "parse.y"
{
   if( ALWAYS(yymsp[-1].minor.yy185 && yymsp[-1].minor.yy185->nSrc>0) ) yymsp[-1].minor.yy185->a[yymsp[-1].minor.yy185->nSrc-1].fg.jointype = (u8)yymsp[0].minor.yy194;
}
#line 2871 "parse.c"
        break;
      case 100: /* stl_prefix ::= */
#line 582 "parse.y"
{yymsp[1].minor.yy185 = 0;}
#line 2876 "parse.c"
        break;
      case 101: /* seltablist ::= stl_prefix nm dbnm as indexed_opt on_opt using_opt */
#line 584 "parse.y"
{
  yymsp[-6].minor.yy185 = sqlite3SrcListAppendFromTerm(pParse,yymsp[-6].minor.yy185,&yymsp[-5].minor.yy0,&yymsp[-4].minor.yy0,&yymsp[-3].minor.yy0,0,yymsp[-1].minor.yy72,yymsp[0].minor.yy254);
  sqlite3SrcListIndexedBy(pParse, yymsp[-6].minor.yy185, &yymsp[-2].minor.yy0);
}
#line 2884 "parse.c"
        break;
      case 102: /* seltablist ::= stl_prefix nm dbnm LP exprlist RP as on_opt using_opt */
#line 589 "parse.y"
{
  yymsp[-8].minor.yy185 = sqlite3SrcListAppendFromTerm(pParse,yymsp[-8].minor.yy185,&yymsp[-7].minor.yy0,&yymsp[-6].minor.yy0,&yymsp[-2].minor.yy0,0,yymsp[-1].minor.yy72,yymsp[0].minor.yy254);
  sqlite3SrcListFuncArgs(pParse, yymsp[-8].minor.yy185, yymsp[-4].minor.yy148);
}
#line 2892 "parse.c"
        break;
      case 103: /* seltablist ::= stl_prefix LP select RP as on_opt using_opt */
#line 595 "parse.y"
{
    yymsp[-6].minor.yy185 = sqlite3SrcListAppendFromTerm(pParse,yymsp[-6].minor.yy185,0,0,&yymsp[-2].minor.yy0,yymsp[-4].minor.yy243,yymsp[-1].minor.yy72,yymsp[0].minor.yy254);
  }
#line 2899 "parse.c"
        break;
      case 104: /* seltablist ::= stl_prefix LP seltablist RP as on_opt using_opt */
#line 599 "parse.y"
{
    if( yymsp[-6].minor.yy185==0 && yymsp[-2].minor.yy0.n==0 && yymsp[-1].minor.yy72==0 && yymsp[0].minor.yy254==0 ){
      yymsp[-6].minor.yy185 = yymsp[-4].minor.yy185;
    }else if( yymsp[-4].minor.yy185->nSrc==1 ){
      yymsp[-6].minor.yy185 = sqlite3SrcListAppendFromTerm(pParse,yymsp[-6].minor.yy185,0,0,&yymsp[-2].minor.yy0,0,yymsp[-1].minor.yy72,yymsp[0].minor.yy254);
      if( yymsp[-6].minor.yy185 ){
        struct SrcList_item *pNew = &yymsp[-6].minor.yy185->a[yymsp[-6].minor.yy185->nSrc-1];
        struct SrcList_item *pOld = yymsp[-4].minor.yy185->a;
        pNew->zName = pOld->zName;
        pNew->zDatabase = pOld->zDatabase;
        pNew->pSelect = pOld->pSelect;
        pOld->zName = pOld->zDatabase = 0;
        pOld->pSelect = 0;
      }
      sqlite3SrcListDelete(pParse->db, yymsp[-4].minor.yy185);
    }else{
      Select *pSubquery;
      sqlite3SrcListShiftJoinType(yymsp[-4].minor.yy185);
      pSubquery = sqlite3SelectNew(pParse,0,yymsp[-4].minor.yy185,0,0,0,0,SF_NestedFrom,0,0);
      yymsp[-6].minor.yy185 = sqlite3SrcListAppendFromTerm(pParse,yymsp[-6].minor.yy185,0,0,&yymsp[-2].minor.yy0,pSubquery,yymsp[-1].minor.yy72,yymsp[0].minor.yy254);
    }
  }
#line 2925 "parse.c"
        break;
      case 105: /* dbnm ::= */
      case 114: /* indexed_opt ::= */ yytestcase(yyruleno==114);
#line 624 "parse.y"
{yymsp[1].minor.yy0.z=0; yymsp[1].minor.yy0.n=0;}
#line 2931 "parse.c"
        break;
      case 107: /* fullname ::= nm dbnm */
#line 630 "parse.y"
{yymsp[-1].minor.yy185 = sqlite3SrcListAppend(pParse->db,0,&yymsp[-1].minor.yy0,&yymsp[0].minor.yy0); /*A-overwrites-X*/}
#line 2936 "parse.c"
        break;
      case 108: /* joinop ::= COMMA|JOIN */
#line 633 "parse.y"
{ yymsp[0].minor.yy194 = JT_INNER; }
#line 2941 "parse.c"
        break;
      case 109: /* joinop ::= JOIN_KW JOIN */
#line 635 "parse.y"
{yymsp[-1].minor.yy194 = sqlite3JoinType(pParse,&yymsp[-1].minor.yy0,0,0);  /*X-overwrites-A*/}
#line 2946 "parse.c"
        break;
      case 110: /* joinop ::= JOIN_KW nm JOIN */
#line 637 "parse.y"
{yymsp[-2].minor.yy194 = sqlite3JoinType(pParse,&yymsp[-2].minor.yy0,&yymsp[-1].minor.yy0,0); /*X-overwrites-A*/}
#line 2951 "parse.c"
        break;
      case 111: /* joinop ::= JOIN_KW nm nm JOIN */
#line 639 "parse.y"
{yymsp[-3].minor.yy194 = sqlite3JoinType(pParse,&yymsp[-3].minor.yy0,&yymsp[-2].minor.yy0,&yymsp[-1].minor.yy0);/*X-overwrites-A*/}
#line 2956 "parse.c"
        break;
      case 112: /* on_opt ::= ON expr */
      case 129: /* having_opt ::= HAVING expr */ yytestcase(yyruleno==129);
      case 136: /* where_opt ::= WHERE expr */ yytestcase(yyruleno==136);
      case 199: /* case_else ::= ELSE expr */ yytestcase(yyruleno==199);
#line 643 "parse.y"
{yymsp[-1].minor.yy72 = yymsp[0].minor.yy190.pExpr;}
#line 2964 "parse.c"
        break;
      case 113: /* on_opt ::= */
      case 128: /* having_opt ::= */ yytestcase(yyruleno==128);
      case 135: /* where_opt ::= */ yytestcase(yyruleno==135);
      case 200: /* case_else ::= */ yytestcase(yyruleno==200);
      case 202: /* case_operand ::= */ yytestcase(yyruleno==202);
#line 644 "parse.y"
{yymsp[1].minor.yy72 = 0;}
#line 2973 "parse.c"
        break;
      case 115: /* indexed_opt ::= INDEXED BY nm */
#line 658 "parse.y"
{yymsp[-2].minor.yy0 = yymsp[0].minor.yy0;}
#line 2978 "parse.c"
        break;
      case 116: /* indexed_opt ::= NOT INDEXED */
#line 659 "parse.y"
{yymsp[-1].minor.yy0.z=0; yymsp[-1].minor.yy0.n=1;}
#line 2983 "parse.c"
        break;
      case 117: /* using_opt ::= USING LP idlist RP */
#line 663 "parse.y"
{yymsp[-3].minor.yy254 = yymsp[-1].minor.yy254;}
#line 2988 "parse.c"
        break;
      case 118: /* using_opt ::= */
      case 146: /* idlist_opt ::= */ yytestcase(yyruleno==146);
#line 664 "parse.y"
{yymsp[1].minor.yy254 = 0;}
#line 2994 "parse.c"
        break;
      case 120: /* orderby_opt ::= ORDER BY sortlist */
      case 127: /* groupby_opt ::= GROUP BY nexprlist */ yytestcase(yyruleno==127);
#line 678 "parse.y"
{yymsp[-2].minor.yy148 = yymsp[0].minor.yy148;}
#line 3000 "parse.c"
        break;
      case 121: /* sortlist ::= sortlist COMMA expr sortorder */
#line 679 "parse.y"
{
  yymsp[-3].minor.yy148 = sqlite3ExprListAppend(pParse,yymsp[-3].minor.yy148,yymsp[-1].minor.yy190.pExpr);
  sqlite3ExprListSetSortOrder(yymsp[-3].minor.yy148,yymsp[0].minor.yy194);
}
#line 3008 "parse.c"
        break;
      case 122: /* sortlist ::= expr sortorder */
#line 683 "parse.y"
{
  yymsp[-1].minor.yy148 = sqlite3ExprListAppend(pParse,0,yymsp[-1].minor.yy190.pExpr); /*A-overwrites-Y*/
  sqlite3ExprListSetSortOrder(yymsp[-1].minor.yy148,yymsp[0].minor.yy194);
}
#line 3016 "parse.c"
        break;
      case 123: /* sortorder ::= ASC */
#line 690 "parse.y"
{yymsp[0].minor.yy194 = SQLITE_SO_ASC;}
#line 3021 "parse.c"
        break;
      case 124: /* sortorder ::= DESC */
#line 691 "parse.y"
{yymsp[0].minor.yy194 = SQLITE_SO_DESC;}
#line 3026 "parse.c"
        break;
      case 125: /* sortorder ::= */
#line 692 "parse.y"
{yymsp[1].minor.yy194 = SQLITE_SO_UNDEFINED;}
#line 3031 "parse.c"
        break;
      case 130: /* limit_opt ::= */
#line 717 "parse.y"
{yymsp[1].minor.yy354.pLimit = 0; yymsp[1].minor.yy354.pOffset = 0;}
#line 3036 "parse.c"
        break;
      case 131: /* limit_opt ::= LIMIT expr */
#line 718 "parse.y"
{yymsp[-1].minor.yy354.pLimit = yymsp[0].minor.yy190.pExpr; yymsp[-1].minor.yy354.pOffset = 0;}
#line 3041 "parse.c"
        break;
      case 132: /* limit_opt ::= LIMIT expr OFFSET expr */
#line 720 "parse.y"
{yymsp[-3].minor.yy354.pLimit = yymsp[-2].minor.yy190.pExpr; yymsp[-3].minor.yy354.pOffset = yymsp[0].minor.yy190.pExpr;}
#line 3046 "parse.c"
        break;
      case 133: /* limit_opt ::= LIMIT expr COMMA expr */
#line 722 "parse.y"
{yymsp[-3].minor.yy354.pOffset = yymsp[-2].minor.yy190.pExpr; yymsp[-3].minor.yy354.pLimit = yymsp[0].minor.yy190.pExpr;}
#line 3051 "parse.c"
        break;
      case 134: /* cmd ::= with DELETE FROM fullname indexed_opt where_opt orderby_opt limit_opt */
#line 728 "parse.y"
{
  sqlite3WithPush(pParse, yymsp[-7].minor.yy285, 1);
  sqlite3SrcListIndexedBy(pParse, yymsp[-4].minor.yy185, &yymsp[-3].minor.yy0);
  yymsp[-2].minor.yy72 = sqlite3LimitWhere(pParse, yymsp[-4].minor.yy185, yymsp[-2].minor.yy72, yymsp[-1].minor.yy148, yymsp[0].minor.yy354.pLimit, yymsp[0].minor.yy354.pOffset, "DELETE");
  sqlite3DeleteFrom(pParse,yymsp[-4].minor.yy185,yymsp[-2].minor.yy72);
}
#line 3061 "parse.c"
        break;
      case 137: /* cmd ::= with UPDATE orconf fullname indexed_opt SET setlist where_opt orderby_opt limit_opt */
#line 753 "parse.y"
{
  sqlite3WithPush(pParse, yymsp[-9].minor.yy285, 1);
  sqlite3SrcListIndexedBy(pParse, yymsp[-6].minor.yy185, &yymsp[-5].minor.yy0);
  sqlite3ExprListCheckLength(pParse,yymsp[-3].minor.yy148,"set list"); 
  yymsp[-2].minor.yy72 = sqlite3LimitWhere(pParse, yymsp[-6].minor.yy185, yymsp[-2].minor.yy72, yymsp[-1].minor.yy148, yymsp[0].minor.yy354.pLimit, yymsp[0].minor.yy354.pOffset, "UPDATE");
  sqlite3Update(pParse,yymsp[-6].minor.yy185,yymsp[-3].minor.yy148,yymsp[-2].minor.yy72,yymsp[-7].minor.yy194);
}
#line 3072 "parse.c"
        break;
      case 138: /* setlist ::= setlist COMMA nm EQ expr */
#line 774 "parse.y"
{
  yymsp[-4].minor.yy148 = sqlite3ExprListAppend(pParse, yymsp[-4].minor.yy148, yymsp[0].minor.yy190.pExpr);
  sqlite3ExprListSetName(pParse, yymsp[-4].minor.yy148, &yymsp[-2].minor.yy0, 1);
}
#line 3080 "parse.c"
        break;
      case 139: /* setlist ::= setlist COMMA LP idlist RP EQ expr */
#line 778 "parse.y"
{
  yymsp[-6].minor.yy148 = sqlite3ExprListAppendVector(pParse, yymsp[-6].minor.yy148, yymsp[-3].minor.yy254, yymsp[0].minor.yy190.pExpr);
}
#line 3087 "parse.c"
        break;
      case 140: /* setlist ::= nm EQ expr */
#line 781 "parse.y"
{
  yylhsminor.yy148 = sqlite3ExprListAppend(pParse, 0, yymsp[0].minor.yy190.pExpr);
  sqlite3ExprListSetName(pParse, yylhsminor.yy148, &yymsp[-2].minor.yy0, 1);
}
#line 3095 "parse.c"
  yymsp[-2].minor.yy148 = yylhsminor.yy148;
        break;
      case 141: /* setlist ::= LP idlist RP EQ expr */
#line 785 "parse.y"
{
  yymsp[-4].minor.yy148 = sqlite3ExprListAppendVector(pParse, 0, yymsp[-3].minor.yy254, yymsp[0].minor.yy190.pExpr);
}
#line 3103 "parse.c"
        break;
      case 142: /* cmd ::= with insert_cmd INTO fullname idlist_opt select */
#line 791 "parse.y"
{
  sqlite3WithPush(pParse, yymsp[-5].minor.yy285, 1);
  sqlite3Insert(pParse, yymsp[-2].minor.yy185, yymsp[0].minor.yy243, yymsp[-1].minor.yy254, yymsp[-4].minor.yy194);
}
#line 3111 "parse.c"
        break;
      case 143: /* cmd ::= with insert_cmd INTO fullname idlist_opt DEFAULT VALUES */
#line 796 "parse.y"
{
  sqlite3WithPush(pParse, yymsp[-6].minor.yy285, 1);
  sqlite3Insert(pParse, yymsp[-3].minor.yy185, 0, yymsp[-2].minor.yy254, yymsp[-5].minor.yy194);
}
#line 3119 "parse.c"
        break;
      case 147: /* idlist_opt ::= LP idlist RP */
#line 811 "parse.y"
{yymsp[-2].minor.yy254 = yymsp[-1].minor.yy254;}
#line 3124 "parse.c"
        break;
      case 148: /* idlist ::= idlist COMMA nm */
#line 813 "parse.y"
{yymsp[-2].minor.yy254 = sqlite3IdListAppend(pParse->db,yymsp[-2].minor.yy254,&yymsp[0].minor.yy0);}
#line 3129 "parse.c"
        break;
      case 149: /* idlist ::= nm */
#line 815 "parse.y"
{yymsp[0].minor.yy254 = sqlite3IdListAppend(pParse->db,0,&yymsp[0].minor.yy0); /*A-overwrites-Y*/}
#line 3134 "parse.c"
        break;
      case 150: /* expr ::= LP expr RP */
#line 865 "parse.y"
{spanSet(&yymsp[-2].minor.yy190,&yymsp[-2].minor.yy0,&yymsp[0].minor.yy0); /*A-overwrites-B*/  yymsp[-2].minor.yy190.pExpr = yymsp[-1].minor.yy190.pExpr;}
#line 3139 "parse.c"
        break;
      case 151: /* term ::= NULL */
      case 156: /* term ::= FLOAT|BLOB */ yytestcase(yyruleno==156);
      case 157: /* term ::= STRING */ yytestcase(yyruleno==157);
#line 866 "parse.y"
{spanExpr(&yymsp[0].minor.yy190,pParse,yymsp[0].major,yymsp[0].minor.yy0);/*A-overwrites-X*/}
#line 3146 "parse.c"
        break;
      case 152: /* expr ::= ID|INDEXED */
      case 153: /* expr ::= JOIN_KW */ yytestcase(yyruleno==153);
#line 867 "parse.y"
{spanExpr(&yymsp[0].minor.yy190,pParse,TK_ID,yymsp[0].minor.yy0); /*A-overwrites-X*/}
#line 3152 "parse.c"
        break;
      case 154: /* expr ::= nm DOT nm */
#line 869 "parse.y"
{
  Expr *temp1 = sqlite3ExprAlloc(pParse->db, TK_ID, &yymsp[-2].minor.yy0, 1);
  Expr *temp2 = sqlite3ExprAlloc(pParse->db, TK_ID, &yymsp[0].minor.yy0, 1);
  spanSet(&yymsp[-2].minor.yy190,&yymsp[-2].minor.yy0,&yymsp[0].minor.yy0); /*A-overwrites-X*/
  yymsp[-2].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_DOT, temp1, temp2, 0);
}
#line 3162 "parse.c"
        break;
      case 155: /* expr ::= nm DOT nm DOT nm */
#line 875 "parse.y"
{
  Expr *temp1 = sqlite3ExprAlloc(pParse->db, TK_ID, &yymsp[-4].minor.yy0, 1);
  Expr *temp2 = sqlite3ExprAlloc(pParse->db, TK_ID, &yymsp[-2].minor.yy0, 1);
  Expr *temp3 = sqlite3ExprAlloc(pParse->db, TK_ID, &yymsp[0].minor.yy0, 1);
  Expr *temp4 = sqlite3PExpr(pParse, TK_DOT, temp2, temp3, 0);
  spanSet(&yymsp[-4].minor.yy190,&yymsp[-4].minor.yy0,&yymsp[0].minor.yy0); /*A-overwrites-X*/
  yymsp[-4].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_DOT, temp1, temp4, 0);
}
#line 3174 "parse.c"
        break;
      case 158: /* term ::= INTEGER */
#line 885 "parse.y"
{
  yylhsminor.yy190.pExpr = sqlite3ExprAlloc(pParse->db, TK_INTEGER, &yymsp[0].minor.yy0, 1);
  yylhsminor.yy190.zStart = yymsp[0].minor.yy0.z;
  yylhsminor.yy190.zEnd = yymsp[0].minor.yy0.z + yymsp[0].minor.yy0.n;
  if( yylhsminor.yy190.pExpr ) yylhsminor.yy190.pExpr->flags |= EP_Leaf;
}
#line 3184 "parse.c"
  yymsp[0].minor.yy190 = yylhsminor.yy190;
        break;
      case 159: /* expr ::= VARIABLE */
#line 891 "parse.y"
{
  if( !(yymsp[0].minor.yy0.z[0]=='#' && sqlite3Isdigit(yymsp[0].minor.yy0.z[1])) ){
    u32 n = yymsp[0].minor.yy0.n;
    spanExpr(&yymsp[0].minor.yy190, pParse, TK_VARIABLE, yymsp[0].minor.yy0);
    sqlite3ExprAssignVarNumber(pParse, yymsp[0].minor.yy190.pExpr, n);
  }else{
    /* When doing a nested parse, one can include terms in an expression
    ** that look like this:   #1 #2 ...  These terms refer to registers
    ** in the virtual machine.  #N is the N-th register. */
    Token t = yymsp[0].minor.yy0; /*A-overwrites-X*/
    assert( t.n>=2 );
    spanSet(&yymsp[0].minor.yy190, &t, &t);
    if( pParse->nested==0 ){
      sqlite3ErrorMsg(pParse, "near \"%T\": syntax error", &t);
      yymsp[0].minor.yy190.pExpr = 0;
    }else{
      yymsp[0].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_REGISTER, 0, 0, 0);
      if( yymsp[0].minor.yy190.pExpr ) sqlite3GetInt32(&t.z[1], &yymsp[0].minor.yy190.pExpr->iTable);
    }
  }
}
#line 3210 "parse.c"
        break;
      case 160: /* expr ::= expr COLLATE ID|STRING */
#line 912 "parse.y"
{
  yymsp[-2].minor.yy190.pExpr = sqlite3ExprAddCollateToken(pParse, yymsp[-2].minor.yy190.pExpr, &yymsp[0].minor.yy0, 1);
  yymsp[-2].minor.yy190.zEnd = &yymsp[0].minor.yy0.z[yymsp[0].minor.yy0.n];
}
#line 3218 "parse.c"
        break;
      case 161: /* expr ::= CAST LP expr AS typetoken RP */
#line 917 "parse.y"
{
  spanSet(&yymsp[-5].minor.yy190,&yymsp[-5].minor.yy0,&yymsp[0].minor.yy0); /*A-overwrites-X*/
  yymsp[-5].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_CAST, yymsp[-3].minor.yy190.pExpr, 0, &yymsp[-1].minor.yy0);
}
#line 3226 "parse.c"
        break;
      case 162: /* expr ::= ID|INDEXED LP distinct exprlist RP */
#line 922 "parse.y"
{
  if( yymsp[-1].minor.yy148 && yymsp[-1].minor.yy148->nExpr>pParse->db->aLimit[SQLITE_LIMIT_FUNCTION_ARG] ){
    sqlite3ErrorMsg(pParse, "too many arguments on function %T", &yymsp[-4].minor.yy0);
  }
  yylhsminor.yy190.pExpr = sqlite3ExprFunction(pParse, yymsp[-1].minor.yy148, &yymsp[-4].minor.yy0);
  spanSet(&yylhsminor.yy190,&yymsp[-4].minor.yy0,&yymsp[0].minor.yy0);
  if( yymsp[-2].minor.yy194==SF_Distinct && yylhsminor.yy190.pExpr ){
    yylhsminor.yy190.pExpr->flags |= EP_Distinct;
  }
}
#line 3240 "parse.c"
  yymsp[-4].minor.yy190 = yylhsminor.yy190;
        break;
      case 163: /* expr ::= ID|INDEXED LP STAR RP */
#line 932 "parse.y"
{
  yylhsminor.yy190.pExpr = sqlite3ExprFunction(pParse, 0, &yymsp[-3].minor.yy0);
  spanSet(&yylhsminor.yy190,&yymsp[-3].minor.yy0,&yymsp[0].minor.yy0);
}
#line 3249 "parse.c"
  yymsp[-3].minor.yy190 = yylhsminor.yy190;
        break;
      case 164: /* term ::= CTIME_KW */
#line 936 "parse.y"
{
  yylhsminor.yy190.pExpr = sqlite3ExprFunction(pParse, 0, &yymsp[0].minor.yy0);
  spanSet(&yylhsminor.yy190, &yymsp[0].minor.yy0, &yymsp[0].minor.yy0);
}
#line 3258 "parse.c"
  yymsp[0].minor.yy190 = yylhsminor.yy190;
        break;
      case 165: /* expr ::= LP nexprlist COMMA expr RP */
#line 965 "parse.y"
{
  ExprList *pList = sqlite3ExprListAppend(pParse, yymsp[-3].minor.yy148, yymsp[-1].minor.yy190.pExpr);
  yylhsminor.yy190.pExpr = sqlite3PExpr(pParse, TK_VECTOR, 0, 0, 0);
  if( yylhsminor.yy190.pExpr ){
    yylhsminor.yy190.pExpr->x.pList = pList;
    spanSet(&yylhsminor.yy190, &yymsp[-4].minor.yy0, &yymsp[0].minor.yy0);
  }else{
    sqlite3ExprListDelete(pParse->db, pList);
  }
}
#line 3273 "parse.c"
  yymsp[-4].minor.yy190 = yylhsminor.yy190;
        break;
      case 166: /* expr ::= expr AND expr */
      case 167: /* expr ::= expr OR expr */ yytestcase(yyruleno==167);
      case 168: /* expr ::= expr LT|GT|GE|LE expr */ yytestcase(yyruleno==168);
      case 169: /* expr ::= expr EQ|NE expr */ yytestcase(yyruleno==169);
      case 170: /* expr ::= expr BITAND|BITOR|LSHIFT|RSHIFT expr */ yytestcase(yyruleno==170);
      case 171: /* expr ::= expr PLUS|MINUS expr */ yytestcase(yyruleno==171);
      case 172: /* expr ::= expr STAR|SLASH|REM expr */ yytestcase(yyruleno==172);
      case 173: /* expr ::= expr CONCAT expr */ yytestcase(yyruleno==173);
#line 976 "parse.y"
{spanBinaryExpr(pParse,yymsp[-1].major,&yymsp[-2].minor.yy190,&yymsp[0].minor.yy190);}
#line 3286 "parse.c"
        break;
      case 174: /* likeop ::= LIKE_KW|MATCH */
#line 989 "parse.y"
{yymsp[0].minor.yy0=yymsp[0].minor.yy0;/*A-overwrites-X*/}
#line 3291 "parse.c"
        break;
      case 175: /* likeop ::= NOT LIKE_KW|MATCH */
#line 990 "parse.y"
{yymsp[-1].minor.yy0=yymsp[0].minor.yy0; yymsp[-1].minor.yy0.n|=0x80000000; /*yymsp[-1].minor.yy0-overwrite-yymsp[0].minor.yy0*/}
#line 3296 "parse.c"
        break;
      case 176: /* expr ::= expr likeop expr */
#line 991 "parse.y"
{
  ExprList *pList;
  int bNot = yymsp[-1].minor.yy0.n & 0x80000000;
  yymsp[-1].minor.yy0.n &= 0x7fffffff;
  pList = sqlite3ExprListAppend(pParse,0, yymsp[0].minor.yy190.pExpr);
  pList = sqlite3ExprListAppend(pParse,pList, yymsp[-2].minor.yy190.pExpr);
  yymsp[-2].minor.yy190.pExpr = sqlite3ExprFunction(pParse, pList, &yymsp[-1].minor.yy0);
  exprNot(pParse, bNot, &yymsp[-2].minor.yy190);
  yymsp[-2].minor.yy190.zEnd = yymsp[0].minor.yy190.zEnd;
  if( yymsp[-2].minor.yy190.pExpr ) yymsp[-2].minor.yy190.pExpr->flags |= EP_InfixFunc;
}
#line 3311 "parse.c"
        break;
      case 177: /* expr ::= expr likeop expr ESCAPE expr */
#line 1002 "parse.y"
{
  ExprList *pList;
  int bNot = yymsp[-3].minor.yy0.n & 0x80000000;
  yymsp[-3].minor.yy0.n &= 0x7fffffff;
  pList = sqlite3ExprListAppend(pParse,0, yymsp[-2].minor.yy190.pExpr);
  pList = sqlite3ExprListAppend(pParse,pList, yymsp[-4].minor.yy190.pExpr);
  pList = sqlite3ExprListAppend(pParse,pList, yymsp[0].minor.yy190.pExpr);
  yymsp[-4].minor.yy190.pExpr = sqlite3ExprFunction(pParse, pList, &yymsp[-3].minor.yy0);
  exprNot(pParse, bNot, &yymsp[-4].minor.yy190);
  yymsp[-4].minor.yy190.zEnd = yymsp[0].minor.yy190.zEnd;
  if( yymsp[-4].minor.yy190.pExpr ) yymsp[-4].minor.yy190.pExpr->flags |= EP_InfixFunc;
}
#line 3327 "parse.c"
        break;
      case 178: /* expr ::= expr ISNULL|NOTNULL */
#line 1029 "parse.y"
{spanUnaryPostfix(pParse,yymsp[0].major,&yymsp[-1].minor.yy190,&yymsp[0].minor.yy0);}
#line 3332 "parse.c"
        break;
      case 179: /* expr ::= expr NOT NULL */
#line 1030 "parse.y"
{spanUnaryPostfix(pParse,TK_NOTNULL,&yymsp[-2].minor.yy190,&yymsp[0].minor.yy0);}
#line 3337 "parse.c"
        break;
      case 180: /* expr ::= expr IS expr */
#line 1051 "parse.y"
{
  spanBinaryExpr(pParse,TK_IS,&yymsp[-2].minor.yy190,&yymsp[0].minor.yy190);
  binaryToUnaryIfNull(pParse, yymsp[0].minor.yy190.pExpr, yymsp[-2].minor.yy190.pExpr, TK_ISNULL);
}
#line 3345 "parse.c"
        break;
      case 181: /* expr ::= expr IS NOT expr */
#line 1055 "parse.y"
{
  spanBinaryExpr(pParse,TK_ISNOT,&yymsp[-3].minor.yy190,&yymsp[0].minor.yy190);
  binaryToUnaryIfNull(pParse, yymsp[0].minor.yy190.pExpr, yymsp[-3].minor.yy190.pExpr, TK_NOTNULL);
}
#line 3353 "parse.c"
        break;
      case 182: /* expr ::= NOT expr */
      case 183: /* expr ::= BITNOT expr */ yytestcase(yyruleno==183);
#line 1079 "parse.y"
{spanUnaryPrefix(&yymsp[-1].minor.yy190,pParse,yymsp[-1].major,&yymsp[0].minor.yy190,&yymsp[-1].minor.yy0);/*A-overwrites-B*/}
#line 3359 "parse.c"
        break;
      case 184: /* expr ::= MINUS expr */
#line 1083 "parse.y"
{spanUnaryPrefix(&yymsp[-1].minor.yy190,pParse,TK_UMINUS,&yymsp[0].minor.yy190,&yymsp[-1].minor.yy0);/*A-overwrites-B*/}
#line 3364 "parse.c"
        break;
      case 185: /* expr ::= PLUS expr */
#line 1085 "parse.y"
{spanUnaryPrefix(&yymsp[-1].minor.yy190,pParse,TK_UPLUS,&yymsp[0].minor.yy190,&yymsp[-1].minor.yy0);/*A-overwrites-B*/}
#line 3369 "parse.c"
        break;
      case 186: /* between_op ::= BETWEEN */
      case 189: /* in_op ::= IN */ yytestcase(yyruleno==189);
#line 1088 "parse.y"
{yymsp[0].minor.yy194 = 0;}
#line 3375 "parse.c"
        break;
      case 188: /* expr ::= expr between_op expr AND expr */
#line 1090 "parse.y"
{
  ExprList *pList = sqlite3ExprListAppend(pParse,0, yymsp[-2].minor.yy190.pExpr);
  pList = sqlite3ExprListAppend(pParse,pList, yymsp[0].minor.yy190.pExpr);
  yymsp[-4].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_BETWEEN, yymsp[-4].minor.yy190.pExpr, 0, 0);
  if( yymsp[-4].minor.yy190.pExpr ){
    yymsp[-4].minor.yy190.pExpr->x.pList = pList;
  }else{
    sqlite3ExprListDelete(pParse->db, pList);
  } 
  exprNot(pParse, yymsp[-3].minor.yy194, &yymsp[-4].minor.yy190);
  yymsp[-4].minor.yy190.zEnd = yymsp[0].minor.yy190.zEnd;
}
#line 3391 "parse.c"
        break;
      case 191: /* expr ::= expr in_op LP exprlist RP */
#line 1106 "parse.y"
{
    if( yymsp[-1].minor.yy148==0 ){
      /* Expressions of the form
      **
      **      expr1 IN ()
      **      expr1 NOT IN ()
      **
      ** simplify to constants 0 (false) and 1 (true), respectively,
      ** regardless of the value of expr1.
      */
      sqlite3ExprDelete(pParse->db, yymsp[-4].minor.yy190.pExpr);
      yymsp[-4].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_INTEGER, 0, 0, &sqlite3IntTokens[yymsp[-3].minor.yy194]);
    }else if( yymsp[-1].minor.yy148->nExpr==1 ){
      /* Expressions of the form:
      **
      **      expr1 IN (?1)
      **      expr1 NOT IN (?2)
      **
      ** with exactly one value on the RHS can be simplified to something
      ** like this:
      **
      **      expr1 == ?1
      **      expr1 <> ?2
      **
      ** But, the RHS of the == or <> is marked with the EP_Generic flag
      ** so that it may not contribute to the computation of comparison
      ** affinity or the collating sequence to use for comparison.  Otherwise,
      ** the semantics would be subtly different from IN or NOT IN.
      */
      Expr *pRHS = yymsp[-1].minor.yy148->a[0].pExpr;
      yymsp[-1].minor.yy148->a[0].pExpr = 0;
      sqlite3ExprListDelete(pParse->db, yymsp[-1].minor.yy148);
      /* pRHS cannot be NULL because a malloc error would have been detected
      ** before now and control would have never reached this point */
      if( ALWAYS(pRHS) ){
        pRHS->flags &= ~EP_Collate;
        pRHS->flags |= EP_Generic;
      }
      yymsp[-4].minor.yy190.pExpr = sqlite3PExpr(pParse, yymsp[-3].minor.yy194 ? TK_NE : TK_EQ, yymsp[-4].minor.yy190.pExpr, pRHS, 0);
    }else{
      yymsp[-4].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_IN, yymsp[-4].minor.yy190.pExpr, 0, 0);
      if( yymsp[-4].minor.yy190.pExpr ){
        yymsp[-4].minor.yy190.pExpr->x.pList = yymsp[-1].minor.yy148;
        sqlite3ExprSetHeightAndFlags(pParse, yymsp[-4].minor.yy190.pExpr);
      }else{
        sqlite3ExprListDelete(pParse->db, yymsp[-1].minor.yy148);
      }
      exprNot(pParse, yymsp[-3].minor.yy194, &yymsp[-4].minor.yy190);
    }
    yymsp[-4].minor.yy190.zEnd = &yymsp[0].minor.yy0.z[yymsp[0].minor.yy0.n];
  }
#line 3446 "parse.c"
        break;
      case 192: /* expr ::= LP select RP */
#line 1157 "parse.y"
{
    spanSet(&yymsp[-2].minor.yy190,&yymsp[-2].minor.yy0,&yymsp[0].minor.yy0); /*A-overwrites-B*/
    yymsp[-2].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_SELECT, 0, 0, 0);
    sqlite3PExprAddSelect(pParse, yymsp[-2].minor.yy190.pExpr, yymsp[-1].minor.yy243);
  }
#line 3455 "parse.c"
        break;
      case 193: /* expr ::= expr in_op LP select RP */
#line 1162 "parse.y"
{
    yymsp[-4].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_IN, yymsp[-4].minor.yy190.pExpr, 0, 0);
    sqlite3PExprAddSelect(pParse, yymsp[-4].minor.yy190.pExpr, yymsp[-1].minor.yy243);
    exprNot(pParse, yymsp[-3].minor.yy194, &yymsp[-4].minor.yy190);
    yymsp[-4].minor.yy190.zEnd = &yymsp[0].minor.yy0.z[yymsp[0].minor.yy0.n];
  }
#line 3465 "parse.c"
        break;
      case 194: /* expr ::= expr in_op nm dbnm paren_exprlist */
#line 1168 "parse.y"
{
    SrcList *pSrc = sqlite3SrcListAppend(pParse->db, 0,&yymsp[-2].minor.yy0,&yymsp[-1].minor.yy0);
    Select *pSelect = sqlite3SelectNew(pParse, 0,pSrc,0,0,0,0,0,0,0);
    if( yymsp[0].minor.yy148 )  sqlite3SrcListFuncArgs(pParse, pSelect ? pSrc : 0, yymsp[0].minor.yy148);
    yymsp[-4].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_IN, yymsp[-4].minor.yy190.pExpr, 0, 0);
    sqlite3PExprAddSelect(pParse, yymsp[-4].minor.yy190.pExpr, pSelect);
    exprNot(pParse, yymsp[-3].minor.yy194, &yymsp[-4].minor.yy190);
    yymsp[-4].minor.yy190.zEnd = yymsp[-1].minor.yy0.z ? &yymsp[-1].minor.yy0.z[yymsp[-1].minor.yy0.n] : &yymsp[-2].minor.yy0.z[yymsp[-2].minor.yy0.n];
  }
#line 3478 "parse.c"
        break;
      case 195: /* expr ::= EXISTS LP select RP */
#line 1177 "parse.y"
{
    Expr *p;
    spanSet(&yymsp[-3].minor.yy190,&yymsp[-3].minor.yy0,&yymsp[0].minor.yy0); /*A-overwrites-B*/
    p = yymsp[-3].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_EXISTS, 0, 0, 0);
    sqlite3PExprAddSelect(pParse, p, yymsp[-1].minor.yy243);
  }
#line 3488 "parse.c"
        break;
      case 196: /* expr ::= CASE case_operand case_exprlist case_else END */
#line 1186 "parse.y"
{
  spanSet(&yymsp[-4].minor.yy190,&yymsp[-4].minor.yy0,&yymsp[0].minor.yy0);  /*A-overwrites-C*/
  yymsp[-4].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_CASE, yymsp[-3].minor.yy72, 0, 0);
  if( yymsp[-4].minor.yy190.pExpr ){
    yymsp[-4].minor.yy190.pExpr->x.pList = yymsp[-1].minor.yy72 ? sqlite3ExprListAppend(pParse,yymsp[-2].minor.yy148,yymsp[-1].minor.yy72) : yymsp[-2].minor.yy148;
    sqlite3ExprSetHeightAndFlags(pParse, yymsp[-4].minor.yy190.pExpr);
  }else{
    sqlite3ExprListDelete(pParse->db, yymsp[-2].minor.yy148);
    sqlite3ExprDelete(pParse->db, yymsp[-1].minor.yy72);
  }
}
#line 3503 "parse.c"
        break;
      case 197: /* case_exprlist ::= case_exprlist WHEN expr THEN expr */
#line 1199 "parse.y"
{
  yymsp[-4].minor.yy148 = sqlite3ExprListAppend(pParse,yymsp[-4].minor.yy148, yymsp[-2].minor.yy190.pExpr);
  yymsp[-4].minor.yy148 = sqlite3ExprListAppend(pParse,yymsp[-4].minor.yy148, yymsp[0].minor.yy190.pExpr);
}
#line 3511 "parse.c"
        break;
      case 198: /* case_exprlist ::= WHEN expr THEN expr */
#line 1203 "parse.y"
{
  yymsp[-3].minor.yy148 = sqlite3ExprListAppend(pParse,0, yymsp[-2].minor.yy190.pExpr);
  yymsp[-3].minor.yy148 = sqlite3ExprListAppend(pParse,yymsp[-3].minor.yy148, yymsp[0].minor.yy190.pExpr);
}
#line 3519 "parse.c"
        break;
      case 201: /* case_operand ::= expr */
#line 1213 "parse.y"
{yymsp[0].minor.yy72 = yymsp[0].minor.yy190.pExpr; /*A-overwrites-X*/}
#line 3524 "parse.c"
        break;
      case 204: /* nexprlist ::= nexprlist COMMA expr */
#line 1224 "parse.y"
{yymsp[-2].minor.yy148 = sqlite3ExprListAppend(pParse,yymsp[-2].minor.yy148,yymsp[0].minor.yy190.pExpr);}
#line 3529 "parse.c"
        break;
      case 205: /* nexprlist ::= expr */
#line 1226 "parse.y"
{yymsp[0].minor.yy148 = sqlite3ExprListAppend(pParse,0,yymsp[0].minor.yy190.pExpr); /*A-overwrites-Y*/}
#line 3534 "parse.c"
        break;
      case 207: /* paren_exprlist ::= LP exprlist RP */
      case 212: /* eidlist_opt ::= LP eidlist RP */ yytestcase(yyruleno==212);
#line 1234 "parse.y"
{yymsp[-2].minor.yy148 = yymsp[-1].minor.yy148;}
#line 3540 "parse.c"
        break;
      case 208: /* cmd ::= createkw uniqueflag INDEX ifnotexists nm dbnm ON nm LP sortlist RP where_opt */
#line 1241 "parse.y"
{
  sqlite3CreateIndex(pParse, &yymsp[-7].minor.yy0, &yymsp[-6].minor.yy0, 
                     sqlite3SrcListAppend(pParse->db,0,&yymsp[-4].minor.yy0,0), yymsp[-2].minor.yy148, yymsp[-10].minor.yy194,
                      &yymsp[-11].minor.yy0, yymsp[0].minor.yy72, SQLITE_SO_ASC, yymsp[-8].minor.yy194, SQLITE_IDXTYPE_APPDEF);
}
#line 3549 "parse.c"
        break;
      case 209: /* uniqueflag ::= UNIQUE */
      case 250: /* raisetype ::= ABORT */ yytestcase(yyruleno==250);
#line 1248 "parse.y"
{yymsp[0].minor.yy194 = OE_Abort;}
#line 3555 "parse.c"
        break;
      case 210: /* uniqueflag ::= */
#line 1249 "parse.y"
{yymsp[1].minor.yy194 = OE_None;}
#line 3560 "parse.c"
        break;
      case 213: /* eidlist ::= eidlist COMMA nm collate sortorder */
#line 1299 "parse.y"
{
  yymsp[-4].minor.yy148 = parserAddExprIdListTerm(pParse, yymsp[-4].minor.yy148, &yymsp[-2].minor.yy0, yymsp[-1].minor.yy194, yymsp[0].minor.yy194);
}
#line 3567 "parse.c"
        break;
      case 214: /* eidlist ::= nm collate sortorder */
#line 1302 "parse.y"
{
  yymsp[-2].minor.yy148 = parserAddExprIdListTerm(pParse, 0, &yymsp[-2].minor.yy0, yymsp[-1].minor.yy194, yymsp[0].minor.yy194); /*A-overwrites-Y*/
}
#line 3574 "parse.c"
        break;
      case 217: /* cmd ::= DROP INDEX ifexists fullname */
#line 1313 "parse.y"
{sqlite3DropIndex(pParse, yymsp[0].minor.yy185, yymsp[-1].minor.yy194);}
#line 3579 "parse.c"
        break;
      case 218: /* cmd ::= VACUUM */
#line 1319 "parse.y"
{sqlite3Vacuum(pParse,0);}
#line 3584 "parse.c"
        break;
      case 219: /* cmd ::= VACUUM nm */
#line 1320 "parse.y"
{sqlite3Vacuum(pParse,&yymsp[0].minor.yy0);}
#line 3589 "parse.c"
        break;
      case 220: /* cmd ::= PRAGMA nm dbnm */
#line 1327 "parse.y"
{sqlite3Pragma(pParse,&yymsp[-1].minor.yy0,&yymsp[0].minor.yy0,0,0);}
#line 3594 "parse.c"
        break;
      case 221: /* cmd ::= PRAGMA nm dbnm EQ nmnum */
#line 1328 "parse.y"
{sqlite3Pragma(pParse,&yymsp[-3].minor.yy0,&yymsp[-2].minor.yy0,&yymsp[0].minor.yy0,0);}
#line 3599 "parse.c"
        break;
      case 222: /* cmd ::= PRAGMA nm dbnm LP nmnum RP */
#line 1329 "parse.y"
{sqlite3Pragma(pParse,&yymsp[-4].minor.yy0,&yymsp[-3].minor.yy0,&yymsp[-1].minor.yy0,0);}
#line 3604 "parse.c"
        break;
      case 223: /* cmd ::= PRAGMA nm dbnm EQ minus_num */
#line 1331 "parse.y"
{sqlite3Pragma(pParse,&yymsp[-3].minor.yy0,&yymsp[-2].minor.yy0,&yymsp[0].minor.yy0,1);}
#line 3609 "parse.c"
        break;
      case 224: /* cmd ::= PRAGMA nm dbnm LP minus_num RP */
#line 1333 "parse.y"
{sqlite3Pragma(pParse,&yymsp[-4].minor.yy0,&yymsp[-3].minor.yy0,&yymsp[-1].minor.yy0,1);}
#line 3614 "parse.c"
        break;
      case 227: /* cmd ::= createkw trigger_decl BEGIN trigger_cmd_list END */
#line 1349 "parse.y"
{
  Token all;
  all.z = yymsp[-3].minor.yy0.z;
  all.n = (int)(yymsp[0].minor.yy0.z - yymsp[-3].minor.yy0.z) + yymsp[0].minor.yy0.n;
  sqlite3FinishTrigger(pParse, yymsp[-1].minor.yy145, &all);
}
#line 3624 "parse.c"
        break;
      case 228: /* trigger_decl ::= temp TRIGGER ifnotexists nm dbnm trigger_time trigger_event ON fullname foreach_clause when_clause */
#line 1358 "parse.y"
{
  sqlite3BeginTrigger(pParse, &yymsp[-7].minor.yy0, &yymsp[-6].minor.yy0, yymsp[-5].minor.yy194, yymsp[-4].minor.yy332.a, yymsp[-4].minor.yy332.b, yymsp[-2].minor.yy185, yymsp[0].minor.yy72, yymsp[-10].minor.yy194, yymsp[-8].minor.yy194);
  yymsp[-10].minor.yy0 = (yymsp[-6].minor.yy0.n==0?yymsp[-7].minor.yy0:yymsp[-6].minor.yy0); /*A-overwrites-T*/
}
#line 3632 "parse.c"
        break;
      case 229: /* trigger_time ::= BEFORE */
#line 1364 "parse.y"
{ yymsp[0].minor.yy194 = TK_BEFORE; }
#line 3637 "parse.c"
        break;
      case 230: /* trigger_time ::= AFTER */
#line 1365 "parse.y"
{ yymsp[0].minor.yy194 = TK_AFTER;  }
#line 3642 "parse.c"
        break;
      case 231: /* trigger_time ::= INSTEAD OF */
#line 1366 "parse.y"
{ yymsp[-1].minor.yy194 = TK_INSTEAD;}
#line 3647 "parse.c"
        break;
      case 232: /* trigger_time ::= */
#line 1367 "parse.y"
{ yymsp[1].minor.yy194 = TK_BEFORE; }
#line 3652 "parse.c"
        break;
      case 233: /* trigger_event ::= DELETE|INSERT */
      case 234: /* trigger_event ::= UPDATE */ yytestcase(yyruleno==234);
#line 1371 "parse.y"
{yymsp[0].minor.yy332.a = yymsp[0].major; /*A-overwrites-X*/ yymsp[0].minor.yy332.b = 0;}
#line 3658 "parse.c"
        break;
      case 235: /* trigger_event ::= UPDATE OF idlist */
#line 1373 "parse.y"
{yymsp[-2].minor.yy332.a = TK_UPDATE; yymsp[-2].minor.yy332.b = yymsp[0].minor.yy254;}
#line 3663 "parse.c"
        break;
      case 236: /* when_clause ::= */
      case 255: /* key_opt ::= */ yytestcase(yyruleno==255);
#line 1380 "parse.y"
{ yymsp[1].minor.yy72 = 0; }
#line 3669 "parse.c"
        break;
      case 237: /* when_clause ::= WHEN expr */
      case 256: /* key_opt ::= KEY expr */ yytestcase(yyruleno==256);
#line 1381 "parse.y"
{ yymsp[-1].minor.yy72 = yymsp[0].minor.yy190.pExpr; }
#line 3675 "parse.c"
        break;
      case 238: /* trigger_cmd_list ::= trigger_cmd_list trigger_cmd SEMI */
#line 1385 "parse.y"
{
  assert( yymsp[-2].minor.yy145!=0 );
  yymsp[-2].minor.yy145->pLast->pNext = yymsp[-1].minor.yy145;
  yymsp[-2].minor.yy145->pLast = yymsp[-1].minor.yy145;
}
#line 3684 "parse.c"
        break;
      case 239: /* trigger_cmd_list ::= trigger_cmd SEMI */
#line 1390 "parse.y"
{ 
  assert( yymsp[-1].minor.yy145!=0 );
  yymsp[-1].minor.yy145->pLast = yymsp[-1].minor.yy145;
}
#line 3692 "parse.c"
        break;
      case 240: /* trnm ::= nm DOT nm */
#line 1401 "parse.y"
{
  yymsp[-2].minor.yy0 = yymsp[0].minor.yy0;
  sqlite3ErrorMsg(pParse, 
        "qualified table names are not allowed on INSERT, UPDATE, and DELETE "
        "statements within triggers");
}
#line 3702 "parse.c"
        break;
      case 241: /* tridxby ::= INDEXED BY nm */
#line 1413 "parse.y"
{
  sqlite3ErrorMsg(pParse,
        "the INDEXED BY clause is not allowed on UPDATE or DELETE statements "
        "within triggers");
}
#line 3711 "parse.c"
        break;
      case 242: /* tridxby ::= NOT INDEXED */
#line 1418 "parse.y"
{
  sqlite3ErrorMsg(pParse,
        "the NOT INDEXED clause is not allowed on UPDATE or DELETE statements "
        "within triggers");
}
#line 3720 "parse.c"
        break;
      case 243: /* trigger_cmd ::= UPDATE orconf trnm tridxby SET setlist where_opt */
#line 1431 "parse.y"
{yymsp[-6].minor.yy145 = sqlite3TriggerUpdateStep(pParse->db, &yymsp[-4].minor.yy0, yymsp[-1].minor.yy148, yymsp[0].minor.yy72, yymsp[-5].minor.yy194);}
#line 3725 "parse.c"
        break;
      case 244: /* trigger_cmd ::= insert_cmd INTO trnm idlist_opt select */
#line 1435 "parse.y"
{yymsp[-4].minor.yy145 = sqlite3TriggerInsertStep(pParse->db, &yymsp[-2].minor.yy0, yymsp[-1].minor.yy254, yymsp[0].minor.yy243, yymsp[-4].minor.yy194);/*A-overwrites-R*/}
#line 3730 "parse.c"
        break;
      case 245: /* trigger_cmd ::= DELETE FROM trnm tridxby where_opt */
#line 1439 "parse.y"
{yymsp[-4].minor.yy145 = sqlite3TriggerDeleteStep(pParse->db, &yymsp[-2].minor.yy0, yymsp[0].minor.yy72);}
#line 3735 "parse.c"
        break;
      case 246: /* trigger_cmd ::= select */
#line 1443 "parse.y"
{yymsp[0].minor.yy145 = sqlite3TriggerSelectStep(pParse->db, yymsp[0].minor.yy243); /*A-overwrites-X*/}
#line 3740 "parse.c"
        break;
      case 247: /* expr ::= RAISE LP IGNORE RP */
#line 1446 "parse.y"
{
  spanSet(&yymsp[-3].minor.yy190,&yymsp[-3].minor.yy0,&yymsp[0].minor.yy0);  /*A-overwrites-X*/
  yymsp[-3].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_RAISE, 0, 0, 0); 
  if( yymsp[-3].minor.yy190.pExpr ){
    yymsp[-3].minor.yy190.pExpr->affinity = OE_Ignore;
  }
}
#line 3751 "parse.c"
        break;
      case 248: /* expr ::= RAISE LP raisetype COMMA nm RP */
#line 1453 "parse.y"
{
  spanSet(&yymsp[-5].minor.yy190,&yymsp[-5].minor.yy0,&yymsp[0].minor.yy0);  /*A-overwrites-X*/
  yymsp[-5].minor.yy190.pExpr = sqlite3PExpr(pParse, TK_RAISE, 0, 0, &yymsp[-1].minor.yy0); 
  if( yymsp[-5].minor.yy190.pExpr ) {
    yymsp[-5].minor.yy190.pExpr->affinity = (char)yymsp[-3].minor.yy194;
  }
}
#line 3762 "parse.c"
        break;
      case 249: /* raisetype ::= ROLLBACK */
#line 1463 "parse.y"
{yymsp[0].minor.yy194 = OE_Rollback;}
#line 3767 "parse.c"
        break;
      case 251: /* raisetype ::= FAIL */
#line 1465 "parse.y"
{yymsp[0].minor.yy194 = OE_Fail;}
#line 3772 "parse.c"
        break;
      case 252: /* cmd ::= DROP TRIGGER ifexists fullname */
#line 1470 "parse.y"
{
  sqlite3DropTrigger(pParse,yymsp[0].minor.yy185,yymsp[-1].minor.yy194);
}
#line 3779 "parse.c"
        break;
      case 253: /* cmd ::= ATTACH database_kw_opt expr AS expr key_opt */
#line 1477 "parse.y"
{
  sqlite3Attach(pParse, yymsp[-3].minor.yy190.pExpr, yymsp[-1].minor.yy190.pExpr, yymsp[0].minor.yy72);
}
#line 3786 "parse.c"
        break;
      case 254: /* cmd ::= DETACH database_kw_opt expr */
#line 1480 "parse.y"
{
  sqlite3Detach(pParse, yymsp[0].minor.yy190.pExpr);
}
#line 3793 "parse.c"
        break;
      case 257: /* cmd ::= REINDEX */
#line 1495 "parse.y"
{sqlite3Reindex(pParse, 0, 0);}
#line 3798 "parse.c"
        break;
      case 258: /* cmd ::= REINDEX nm dbnm */
#line 1496 "parse.y"
{sqlite3Reindex(pParse, &yymsp[-1].minor.yy0, &yymsp[0].minor.yy0);}
#line 3803 "parse.c"
        break;
      case 259: /* cmd ::= ANALYZE */
#line 1501 "parse.y"
{sqlite3Analyze(pParse, 0, 0);}
#line 3808 "parse.c"
        break;
      case 260: /* cmd ::= ANALYZE nm dbnm */
#line 1502 "parse.y"
{sqlite3Analyze(pParse, &yymsp[-1].minor.yy0, &yymsp[0].minor.yy0);}
#line 3813 "parse.c"
        break;
      case 261: /* cmd ::= ALTER TABLE fullname RENAME TO nm */
#line 1507 "parse.y"
{
  sqlite3AlterRenameTable(pParse,yymsp[-3].minor.yy185,&yymsp[0].minor.yy0);
}
#line 3820 "parse.c"
        break;
      case 262: /* cmd ::= ALTER TABLE add_column_fullname ADD kwcolumn_opt columnname carglist */
#line 1511 "parse.y"
{
  yymsp[-1].minor.yy0.n = (int)(pParse->sLastToken.z-yymsp[-1].minor.yy0.z) + pParse->sLastToken.n;
  sqlite3AlterFinishAddColumn(pParse, &yymsp[-1].minor.yy0);
}
#line 3828 "parse.c"
        break;
      case 263: /* add_column_fullname ::= fullname */
#line 1515 "parse.y"
{
  disableLookaside(pParse);
  sqlite3AlterBeginAddColumn(pParse, yymsp[0].minor.yy185);
}
#line 3836 "parse.c"
        break;
      case 264: /* cmd ::= create_vtab */
#line 1525 "parse.y"
{sqlite3VtabFinishParse(pParse,0);}
#line 3841 "parse.c"
        break;
      case 265: /* cmd ::= create_vtab LP vtabarglist RP */
#line 1526 "parse.y"
{sqlite3VtabFinishParse(pParse,&yymsp[0].minor.yy0);}
#line 3846 "parse.c"
        break;
      case 266: /* create_vtab ::= createkw VIRTUAL TABLE ifnotexists nm dbnm USING nm */
#line 1528 "parse.y"
{
    sqlite3VtabBeginParse(pParse, &yymsp[-3].minor.yy0, &yymsp[-2].minor.yy0, &yymsp[0].minor.yy0, yymsp[-4].minor.yy194);
}
#line 3853 "parse.c"
        break;
      case 267: /* vtabarg ::= */
#line 1533 "parse.y"
{sqlite3VtabArgInit(pParse);}
#line 3858 "parse.c"
        break;
      case 268: /* vtabargtoken ::= ANY */
      case 269: /* vtabargtoken ::= lp anylist RP */ yytestcase(yyruleno==269);
      case 270: /* lp ::= LP */ yytestcase(yyruleno==270);
#line 1535 "parse.y"
{sqlite3VtabArgExtend(pParse,&yymsp[0].minor.yy0);}
#line 3865 "parse.c"
        break;
      case 271: /* with ::= */
#line 1550 "parse.y"
{yymsp[1].minor.yy285 = 0;}
#line 3870 "parse.c"
        break;
      case 272: /* with ::= WITH wqlist */
#line 1552 "parse.y"
{ yymsp[-1].minor.yy285 = yymsp[0].minor.yy285; }
#line 3875 "parse.c"
        break;
      case 273: /* with ::= WITH RECURSIVE wqlist */
#line 1553 "parse.y"
{ yymsp[-2].minor.yy285 = yymsp[0].minor.yy285; }
#line 3880 "parse.c"
        break;
      case 274: /* wqlist ::= nm eidlist_opt AS LP select RP */
#line 1555 "parse.y"
{
  yymsp[-5].minor.yy285 = sqlite3WithAdd(pParse, 0, &yymsp[-5].minor.yy0, yymsp[-4].minor.yy148, yymsp[-1].minor.yy243); /*A-overwrites-X*/
}
#line 3887 "parse.c"
        break;
      case 275: /* wqlist ::= wqlist COMMA nm eidlist_opt AS LP select RP */
#line 1558 "parse.y"
{
  yymsp[-7].minor.yy285 = sqlite3WithAdd(pParse, yymsp[-7].minor.yy285, &yymsp[-5].minor.yy0, yymsp[-4].minor.yy148, yymsp[-1].minor.yy243);
}
#line 3894 "parse.c"
        break;
      default:
      /* (276) input ::= cmdlist */ yytestcase(yyruleno==276);
      /* (277) cmdlist ::= cmdlist ecmd */ yytestcase(yyruleno==277);
      /* (278) cmdlist ::= ecmd (OPTIMIZED OUT) */ assert(yyruleno!=278);
      /* (279) ecmd ::= SEMI */ yytestcase(yyruleno==279);
      /* (280) ecmd ::= explain cmdx SEMI */ yytestcase(yyruleno==280);
      /* (281) explain ::= */ yytestcase(yyruleno==281);
      /* (282) trans_opt ::= */ yytestcase(yyruleno==282);
      /* (283) trans_opt ::= TRANSACTION */ yytestcase(yyruleno==283);
      /* (284) trans_opt ::= TRANSACTION nm */ yytestcase(yyruleno==284);
      /* (285) savepoint_opt ::= SAVEPOINT */ yytestcase(yyruleno==285);
      /* (286) savepoint_opt ::= */ yytestcase(yyruleno==286);
      /* (287) cmd ::= create_table create_table_args */ yytestcase(yyruleno==287);
      /* (288) columnlist ::= columnlist COMMA columnname carglist */ yytestcase(yyruleno==288);
      /* (289) columnlist ::= columnname carglist */ yytestcase(yyruleno==289);
      /* (290) nm ::= ID|INDEXED */ yytestcase(yyruleno==290);
      /* (291) nm ::= STRING */ yytestcase(yyruleno==291);
      /* (292) nm ::= JOIN_KW */ yytestcase(yyruleno==292);
      /* (293) typetoken ::= typename */ yytestcase(yyruleno==293);
      /* (294) typename ::= ID|STRING */ yytestcase(yyruleno==294);
      /* (295) signed ::= plus_num (OPTIMIZED OUT) */ assert(yyruleno!=295);
      /* (296) signed ::= minus_num (OPTIMIZED OUT) */ assert(yyruleno!=296);
      /* (297) carglist ::= carglist ccons */ yytestcase(yyruleno==297);
      /* (298) carglist ::= */ yytestcase(yyruleno==298);
      /* (299) ccons ::= NULL onconf */ yytestcase(yyruleno==299);
      /* (300) conslist_opt ::= COMMA conslist */ yytestcase(yyruleno==300);
      /* (301) conslist ::= conslist tconscomma tcons */ yytestcase(yyruleno==301);
      /* (302) conslist ::= tcons (OPTIMIZED OUT) */ assert(yyruleno!=302);
      /* (303) tconscomma ::= */ yytestcase(yyruleno==303);
      /* (304) defer_subclause_opt ::= defer_subclause (OPTIMIZED OUT) */ assert(yyruleno!=304);
      /* (305) resolvetype ::= raisetype (OPTIMIZED OUT) */ assert(yyruleno!=305);
      /* (306) selectnowith ::= oneselect (OPTIMIZED OUT) */ assert(yyruleno!=306);
      /* (307) oneselect ::= values */ yytestcase(yyruleno==307);
      /* (308) sclp ::= selcollist COMMA */ yytestcase(yyruleno==308);
      /* (309) as ::= ID|STRING */ yytestcase(yyruleno==309);
      /* (310) expr ::= term (OPTIMIZED OUT) */ assert(yyruleno!=310);
      /* (311) exprlist ::= nexprlist */ yytestcase(yyruleno==311);
      /* (312) nmnum ::= plus_num (OPTIMIZED OUT) */ assert(yyruleno!=312);
      /* (313) nmnum ::= nm (OPTIMIZED OUT) */ assert(yyruleno!=313);
      /* (314) nmnum ::= ON */ yytestcase(yyruleno==314);
      /* (315) nmnum ::= DELETE */ yytestcase(yyruleno==315);
      /* (316) nmnum ::= DEFAULT */ yytestcase(yyruleno==316);
      /* (317) plus_num ::= INTEGER|FLOAT */ yytestcase(yyruleno==317);
      /* (318) foreach_clause ::= */ yytestcase(yyruleno==318);
      /* (319) foreach_clause ::= FOR EACH ROW */ yytestcase(yyruleno==319);
      /* (320) trnm ::= nm */ yytestcase(yyruleno==320);
      /* (321) tridxby ::= */ yytestcase(yyruleno==321);
      /* (322) database_kw_opt ::= DATABASE */ yytestcase(yyruleno==322);
      /* (323) database_kw_opt ::= */ yytestcase(yyruleno==323);
      /* (324) kwcolumn_opt ::= */ yytestcase(yyruleno==324);
      /* (325) kwcolumn_opt ::= COLUMNKW */ yytestcase(yyruleno==325);
      /* (326) vtabarglist ::= vtabarg */ yytestcase(yyruleno==326);
      /* (327) vtabarglist ::= vtabarglist COMMA vtabarg */ yytestcase(yyruleno==327);
      /* (328) vtabarg ::= vtabarg vtabargtoken */ yytestcase(yyruleno==328);
      /* (329) anylist ::= */ yytestcase(yyruleno==329);
      /* (330) anylist ::= anylist LP anylist RP */ yytestcase(yyruleno==330);
      /* (331) anylist ::= anylist ANY */ yytestcase(yyruleno==331);
        break;
/********** End reduce actions ************************************************/
  };
  assert( yyruleno<sizeof(yyRuleInfo)/sizeof(yyRuleInfo[0]) );
  yygoto = yyRuleInfo[yyruleno].lhs;
  yysize = yyRuleInfo[yyruleno].nrhs;
  yyact = yy_find_reduce_action(yymsp[-yysize].stateno,(YYCODETYPE)yygoto);
  if( yyact <= YY_MAX_SHIFTREDUCE ){
    if( yyact>YY_MAX_SHIFT ){
      yyact += YY_MIN_REDUCE - YY_MIN_SHIFTREDUCE;
    }
    yymsp -= yysize-1;
    yypParser->yytos = yymsp;
    yymsp->stateno = (YYACTIONTYPE)yyact;
    yymsp->major = (YYCODETYPE)yygoto;
    yyTraceShift(yypParser, yyact);
  }else{
    assert( yyact == YY_ACCEPT_ACTION );
    yypParser->yytos -= yysize;
    yy_accept(yypParser);
  }
}

/*
** The following code executes when the parse fails
*/
#ifndef YYNOERRORRECOVERY
static void yy_parse_failed(
  yyParser *yypParser           /* The parser */
){
  sqlite3ParserARG_FETCH;
#ifndef NDEBUG
  if( yyTraceFILE ){
    fprintf(yyTraceFILE,"%sFail!\n",yyTracePrompt);
  }
#endif
  while( yypParser->yytos>yypParser->yystack ) yy_pop_parser_stack(yypParser);
  /* Here code is inserted which will be executed whenever the
  ** parser fails */
/************ Begin %parse_failure code ***************************************/
/************ End %parse_failure code *****************************************/
  sqlite3ParserARG_STORE; /* Suppress warning about unused %extra_argument variable */
}
#endif /* YYNOERRORRECOVERY */

/*
** The following code executes when a syntax error first occurs.
*/
static void yy_syntax_error(
  yyParser *yypParser,           /* The parser */
  int yymajor,                   /* The major type of the error token */
  sqlite3ParserTOKENTYPE yyminor         /* The minor type of the error token */
){
  sqlite3ParserARG_FETCH;
#define TOKEN yyminor
/************ Begin %syntax_error code ****************************************/
#line 32 "parse.y"

  UNUSED_PARAMETER(yymajor);  /* Silence some compiler warnings */
  assert( TOKEN.z[0] );  /* The tokenizer always gives us a token */
  sqlite3ErrorMsg(pParse, "near \"%T\": syntax error", &TOKEN);
#line 4014 "parse.c"
/************ End %syntax_error code ******************************************/
  sqlite3ParserARG_STORE; /* Suppress warning about unused %extra_argument variable */
}

/*
** The following is executed when the parser accepts
*/
static void yy_accept(
  yyParser *yypParser           /* The parser */
){
  sqlite3ParserARG_FETCH;
#ifndef NDEBUG
  if( yyTraceFILE ){
    fprintf(yyTraceFILE,"%sAccept!\n",yyTracePrompt);
  }
#endif
#ifndef YYNOERRORRECOVERY
  yypParser->yyerrcnt = -1;
#endif
  assert( yypParser->yytos==yypParser->yystack );
  /* Here code is inserted which will be executed whenever the
  ** parser accepts */
/*********** Begin %parse_accept code *****************************************/
/*********** End %parse_accept code *******************************************/
  sqlite3ParserARG_STORE; /* Suppress warning about unused %extra_argument variable */
}

/* The main parser program.
** The first argument is a pointer to a structure obtained from
** "sqlite3ParserAlloc" which describes the current state of the parser.
** The second argument is the major token number.  The third is
** the minor token.  The fourth optional argument is whatever the
** user wants (and specified in the grammar) and is available for
** use by the action routines.
**
** Inputs:
** <ul>
** <li> A pointer to the parser (an opaque structure.)
** <li> The major token number.
** <li> The minor token number.
** <li> An option argument of a grammar-specified type.
** </ul>
**
** Outputs:
** None.
*/
void sqlite3Parser(
  void *yyp,                   /* The parser */
  int yymajor,                 /* The major token code number */
  sqlite3ParserTOKENTYPE yyminor       /* The value for the token */
  sqlite3ParserARG_PDECL               /* Optional %extra_argument parameter */
){
  YYMINORTYPE yyminorunion;
  unsigned int yyact;   /* The parser action. */
#if !defined(YYERRORSYMBOL) && !defined(YYNOERRORRECOVERY)
  int yyendofinput;     /* True if we are at the end of input */
#endif
#ifdef YYERRORSYMBOL
  int yyerrorhit = 0;   /* True if yymajor has invoked an error */
#endif
  yyParser *yypParser;  /* The parser */

  yypParser = (yyParser*)yyp;
  assert( yypParser->yytos!=0 );
#if !defined(YYERRORSYMBOL) && !defined(YYNOERRORRECOVERY)
  yyendofinput = (yymajor==0);
#endif
  sqlite3ParserARG_STORE;

#ifndef NDEBUG
  if( yyTraceFILE ){
    fprintf(yyTraceFILE,"%sInput '%s'\n",yyTracePrompt,yyTokenName[yymajor]);
  }
#endif

  do{
    yyact = yy_find_shift_action(yypParser,(YYCODETYPE)yymajor);
    if( yyact <= YY_MAX_SHIFTREDUCE ){
      yy_shift(yypParser,yyact,yymajor,yyminor);
#ifndef YYNOERRORRECOVERY
      yypParser->yyerrcnt--;
#endif
      yymajor = YYNOCODE;
    }else if( yyact <= YY_MAX_REDUCE ){
      yy_reduce(yypParser,yyact-YY_MIN_REDUCE);
    }else{
      assert( yyact == YY_ERROR_ACTION );
      yyminorunion.yy0 = yyminor;
#ifdef YYERRORSYMBOL
      int yymx;
#endif
#ifndef NDEBUG
      if( yyTraceFILE ){
        fprintf(yyTraceFILE,"%sSyntax Error!\n",yyTracePrompt);
      }
#endif
#ifdef YYERRORSYMBOL
      /* A syntax error has occurred.
      ** The response to an error depends upon whether or not the
      ** grammar defines an error token "ERROR".  
      **
      ** This is what we do if the grammar does define ERROR:
      **
      **  * Call the %syntax_error function.
      **
      **  * Begin popping the stack until we enter a state where
      **    it is legal to shift the error symbol, then shift
      **    the error symbol.
      **
      **  * Set the error count to three.
      **
      **  * Begin accepting and shifting new tokens.  No new error
      **    processing will occur until three tokens have been
      **    shifted successfully.
      **
      */
      if( yypParser->yyerrcnt<0 ){
        yy_syntax_error(yypParser,yymajor,yyminor);
      }
      yymx = yypParser->yytos->major;
      if( yymx==YYERRORSYMBOL || yyerrorhit ){
#ifndef NDEBUG
        if( yyTraceFILE ){
          fprintf(yyTraceFILE,"%sDiscard input token %s\n",
             yyTracePrompt,yyTokenName[yymajor]);
        }
#endif
        yy_destructor(yypParser, (YYCODETYPE)yymajor, &yyminorunion);
        yymajor = YYNOCODE;
      }else{
        while( yypParser->yytos >= yypParser->yystack
            && yymx != YYERRORSYMBOL
            && (yyact = yy_find_reduce_action(
                        yypParser->yytos->stateno,
                        YYERRORSYMBOL)) >= YY_MIN_REDUCE
        ){
          yy_pop_parser_stack(yypParser);
        }
        if( yypParser->yytos < yypParser->yystack || yymajor==0 ){
          yy_destructor(yypParser,(YYCODETYPE)yymajor,&yyminorunion);
          yy_parse_failed(yypParser);
#ifndef YYNOERRORRECOVERY
          yypParser->yyerrcnt = -1;
#endif
          yymajor = YYNOCODE;
        }else if( yymx!=YYERRORSYMBOL ){
          yy_shift(yypParser,yyact,YYERRORSYMBOL,yyminor);
        }
      }
      yypParser->yyerrcnt = 3;
      yyerrorhit = 1;
#elif defined(YYNOERRORRECOVERY)
      /* If the YYNOERRORRECOVERY macro is defined, then do not attempt to
      ** do any kind of error recovery.  Instead, simply invoke the syntax
      ** error routine and continue going as if nothing had happened.
      **
      ** Applications can set this macro (for example inside %include) if
      ** they intend to abandon the parse upon the first syntax error seen.
      */
      yy_syntax_error(yypParser,yymajor, yyminor);
      yy_destructor(yypParser,(YYCODETYPE)yymajor,&yyminorunion);
      yymajor = YYNOCODE;
      
#else  /* YYERRORSYMBOL is not defined */
      /* This is what we do if the grammar does not define ERROR:
      **
      **  * Report an error message, and throw away the input token.
      **
      **  * If the input token is $, then fail the parse.
      **
      ** As before, subsequent error messages are suppressed until
      ** three input tokens have been successfully shifted.
      */
      if( yypParser->yyerrcnt<=0 ){
        yy_syntax_error(yypParser,yymajor, yyminor);
      }
      yypParser->yyerrcnt = 3;
      yy_destructor(yypParser,(YYCODETYPE)yymajor,&yyminorunion);
      if( yyendofinput ){
        yy_parse_failed(yypParser);
#ifndef YYNOERRORRECOVERY
        yypParser->yyerrcnt = -1;
#endif
      }
      yymajor = YYNOCODE;
#endif
    }
  }while( yymajor!=YYNOCODE && yypParser->yytos>yypParser->yystack );
#ifndef NDEBUG
  if( yyTraceFILE ){
    yyStackEntry *i;
    char cDiv = '[';
    fprintf(yyTraceFILE,"%sReturn. Stack=",yyTracePrompt);
    for(i=&yypParser->yystack[1]; i<=yypParser->yytos; i++){
      fprintf(yyTraceFILE,"%c%s", cDiv, yyTokenName[i->major]);
      cDiv = ' ';
    }
    fprintf(yyTraceFILE,"]\n");
  }
#endif
  return;
}
