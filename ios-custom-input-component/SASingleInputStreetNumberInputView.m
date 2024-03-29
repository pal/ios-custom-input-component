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
  self.letterTextField.font = [UIFont boldSystemFontOfSize:32];
  self.letterTextField.placeholder = @"Enter street number";
}

- (int) maxLengthForInputField:(UITextField *)textField {
  return 30;
}

- (void) isActiveInputMethod:(BOOL)active {
  if (!active) {
    [self endEditing:TRUE];
  } else {
    [self.letterTextField becomeFirstResponder];
  }
}

- (void) setAddress:(NSString *)newAddress {
  self.letterTextField.text = newAddress;
}


@end
