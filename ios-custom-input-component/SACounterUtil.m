//
//  SACounterUtil.m
//  ios-custom-input-component
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

  if (isnan(in_val)) {
    return DEFAULT_NUMERIC_VALUE;
  }
  int ret_val = ++in_val;
  if (ret_val > MAX_NUMERIC_VALUE) {
    ret_val = MIN_NUMERIC_VALUE;
  }
  return [NSString stringWithFormat:@"%d", ret_val];
}

+ (NSString *) prevNumber:(NSString *)in_val_s {
  int in_val = [SACounterUtil getInt:in_val_s];

  if (isnan(in_val)) {
    return DEFAULT_NUMERIC_VALUE;
  }
  int ret_val = --in_val;
  if (ret_val < MIN_NUMERIC_VALUE) {
    ret_val = MAX_NUMERIC_VALUE;
  }
  return [NSString stringWithFormat:@"%d", ret_val];
}

+ (NSString *) nextString:(NSString *)in_val {
  if ((in_val == nil) || (in_val.length < 1)) {
    return DEFAULT_STRING_VALUE;
  }
  unichar in_char = [in_val characterAtIndex:0];
  int ret_val = ++in_char;
  if (ret_val > MAX_CHAR_VALUE) {
    ret_val = MIN_CHAR_VALUE;
  }
  return [NSString stringWithCharacters:&ret_val length:1];
}

+ (NSString *) prevString:(NSString *)in_val {
  if ((in_val == nil) || (in_val.length < 1)) {
    return DEFAULT_STRING_VALUE;
  }
  unichar in_char = [in_val characterAtIndex:0];
  int ret_val = --in_char;
  if (ret_val < MIN_CHAR_VALUE) {
    ret_val = MAX_CHAR_VALUE;
  }
  return [NSString stringWithCharacters:&ret_val length:1];
}

+ (int) getInt:(NSString *)str {
  NSNumberFormatter *f = [[NSNumberFormatter alloc] init];

  [f setNumberStyle:NSNumberFormatterDecimalStyle];
  NSNumber *myNumber = [f numberFromString:str];
  return [myNumber intValue];
}

@end
