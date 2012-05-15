//
//  SASingleInputStreetNumberInputView.m
//  ios-custom-input-component
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import "SASingleInputStreetNumberInputView.h"

@implementation SASingleInputStreetNumberInputView

- (void) layoutSubviews {
  [super layoutSubviews];

  // Remove buttons
  [[self upButton1] removeFromSuperview];
  [[self downButton1] removeFromSuperview];
  [[self upButton2] removeFromSuperview];
  [[self downButton2] removeFromSuperview];

  // Remove number input field
  [[self numberTextField] removeFromSuperview];

  // Resize text input field to width
  CGRect origRect = self.letterTextField.frame;
  self.letterTextField.frame = CGRectMake(0, origRect.origin.y, SCREEN_WIDTH, origRect.size.height);
}

- (int) maxLengthForInputField:(UITextField *)textField {
  return 30;
}

@end
