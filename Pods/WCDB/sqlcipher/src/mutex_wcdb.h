/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef mutex_wcdb_h
#define mutex_wcdb_h

#if SQLITE_WCDB_SIGNAL_RETRY

#include "sqlite3.h"

typedef struct sqlite3_thread sqlite3_thread;
typedef struct sqlite3_condition sqlite3_condition;

sqlite3_condition* pthreadCondAlloc();

void pthreadCondFree(sqlite3_condition* c);

int pthreadCondWait(sqlite3_condition* c, sqlite3_mutex* p, int timeout);

void pthreadCondSignal(sqlite3_condition* c, sqlite3_thread* t);

void pthreadCondBroadcast(sqlite3_condition* c);

sqlite3_thread* pthreadAlloc();

void pthreadFree(sqlite3_thread* t);

void pthreadSelf(sqlite3_thread* t);

int pthreadIsMain();

sqlite3_mutex* unixVFSMutex(void);

#endif //SQLITE_WCDB_SIGNAL_RETRY

#endif /* mutex_wcdb_h */
