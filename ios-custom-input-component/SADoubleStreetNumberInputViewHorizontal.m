//
//  SADoubleStreetNumberInputViewHorizontal.m
//  ios-custom-input-component
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import "SADoubleStreetNumberInputViewHorizontal.h"

@implementation SADoubleStreetNumberInputViewHorizontal

- (void) layoutSubviews {
  [super layoutSubviews];

  [self upButton1].frame = CGRectMake((((SCREEN_WIDTH / 8) * 1) - (BUTTON_WIDTH / 2)), BOTTOM_BTN_Y,
                                      BUTTON_WIDTH, BUTTON_HEIGHT);
  [self downButton1].frame = CGRectMake((((SCREEN_WIDTH / 8) * 3) - (BUTTON_WIDTH / 2)), BOTTOM_BTN_Y,
                                        BUTTON_WIDTH, BUTTON_HEIGHT);
  [self upButton2].frame = CGRectMake((((SCREEN_WIDTH / 8) * 5) - (BUTTON_WIDTH / 2)), BOTTOM_BTN_Y,
                                      BUTTON_WIDTH, BUTTON_HEIGHT);
  [self downButton2].frame = CGRectMake((((SCREEN_WIDTH / 8) * 7) - (BUTTON_WIDTH / 2)), BOTTOM_BTN_Y,
                                        BUTTON_WIDTH, BUTTON_HEIGHT);
}

@end
