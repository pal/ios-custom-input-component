//
//  SACounterUtil.m
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import "SACounterUtil.h"


// Private API
@interface SACounterUtil ()
+ (int) getInt:(NSString *)str;
@end

@implementation SACounterUtil

+ (NSString *) nextNumber:(NSString *)in_val_s {
  int in_val = [SACounterUtil getInt:in_val_s];

  if (in_val < 0) {
    return [NSString stringWithFormat:@"%d", MIN_NUMERIC_VALUE];
  }
  int ret_val = ++in_val;
  if (ret_val > MAX_NUMERIC_VALUE) {
    return @"";
  } else {
    return [NSString stringWithFormat:@"%d", ret_val];
  }
}

+ (NSString *) prevNumber:(NSString *)in_val_s {
  int in_val = [SACounterUtil getInt:in_val_s];

  if (in_val < 0) {
    return [NSString stringWithFormat:@"%d", MAX_NUMERIC_VALUE];
  }
  int ret_val = --in_val;
  if (ret_val < MIN_NUMERIC_VALUE) {
    return @"";
  } else {
    return [NSString stringWithFormat:@"%d", ret_val];
  }
}

+ (NSString *) nextString:(NSString *)in_val {
  if ((in_val == nil) || (in_val.length < 1)) {
    return [NSString stringWithFormat:@"%c", MIN_CHAR_VALUE];
  }
  unichar ret_val = [in_val characterAtIndex:0] + 1;
  if (ret_val > MAX_CHAR_VALUE) {
    return @"";
  } else {
    return [NSString stringWithCharacters:&ret_val length:1];
  }
}

+ (NSString *) prevString:(NSString *)in_val {
  if ((in_val == nil) || (in_val.length < 1)) {
    return [NSString stringWithFormat:@"%c", MAX_CHAR_VALUE];
  }
  unichar ret_val = [in_val characterAtIndex:0] - 1;
  if (ret_val < MIN_CHAR_VALUE) {
    return @"";
  } else {
    return [NSString stringWithCharacters:&ret_val length:1];
  }
}

+ (int) getInt:(NSString *)str {
  if ((str == nil) || (str.length < 1)) {
    return -1;
  }
  NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
  [f setNumberStyle:NSNumberFormatterDecimalStyle];
  NSNumber *myNumber = [f numberFromString:str];
  return [myNumber intValue];
}

@end
