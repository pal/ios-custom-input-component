//
//  SACounterUtil.h
//  Helper class to increment/decrement string and number values.
//  Used for allowing button-based modification of street number values.
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SACounterUtil : NSObject

#define MIN_NUMERIC_VALUE 1
#define MAX_NUMERIC_VALUE 999

#define MIN_CHAR_VALUE    'A'
#define MAX_CHAR_VALUE    'Z'

+ (NSString *) nextNumber:(NSString *)in_val;
+ (NSString *) prevNumber:(NSString *)in_val;

+ (NSString *) nextString:(NSString *)in_val;
+ (NSString *) prevString:(NSString *)in_val;

@end
