//
//  UIColor+Extensions.m
//  Pods
//
//  Created by 李伯坤 on 2017/8/29.
//
//

#import "UIColor+Extensions.h"

int getIntegerFromHexString(NSString *str) {
    int nValue = 0;
    for (int i = 0; i < [str length]; i++)
    {
        int nLetterValue = 0;
        
        if ([str characterAtIndex:i] >='0' && [str characterAtIndex:i] <='9') {
            nLetterValue += ([str characterAtIndex:i] - '0');
        }
        else{
            switch ([str characterAtIndex:i])
            {
                case 'a':case 'A':
                    nLetterValue = 10;break;
                case 'b':case 'B':
                    nLetterValue = 11;break;
                case 'c': case 'C':
                    nLetterValue = 12;break;
                case 'd':case 'D':
                    nLetterValue = 13;break;
                case 'e': case 'E':
                    nLetterValue = 14;break;
                case 'f': case 'F':
                    nLetterValue = 15;break;
                default:nLetterValue = '0';
            }
        }
        
        nValue = nValue * 16 + nLetterValue; //16进制
    }
    return nValue;
}

@implementation UIColor (Extensions)

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(float)alpha
{
    UIColor *color = [UIColor clearColor];
    
    if ([[hexString substringToIndex:1] isEqualToString:@"#"]) {
        
        if ([hexString length]==7) {
            NSRange range = NSMakeRange(1,2);
            NSString *strRed = [hexString substringWithRange:range];
            
            range.location = 3;
            NSString *strGreen = [hexString substringWithRange:range];
            
            range.location = 5;
            NSString *strBlue = [hexString substringWithRange:range];
            
            float r = getIntegerFromHexString(strRed);
            float g = getIntegerFromHexString(strGreen);
            float b = getIntegerFromHexString(strBlue);
            
            color = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:alpha];
        }
    }
    return color;
}

@end
