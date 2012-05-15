//
//  SADoubleStreetNumberInputView.m
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import "SADoubleStreetNumberInputView.h"
#import "SARepeatingButton.h"
#import "SACounterUtil.h"
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// Private methods
@interface SADoubleStreetNumberInputView ()
- (UITextField *) createTextFieldWithFrame:(CGRect)frame;
- (UIButton *) createArrowButtonWithFrame:(CGRect)frame image:(NSString *)imgPath;
@end

@implementation SADoubleStreetNumberInputView

@synthesize numberTextField, letterTextField;
@synthesize upButton1, upButton2, downButton1, downButton2;

- (void) baseInit {
  numberTextField = nil;
  letterTextField = nil;
  self.backgroundColor = BG_COLOR;
}

- (id) initWithFrame:(CGRect)frame {
  self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT)];
  if (self) {
    [self baseInit];
  }
  return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    [self baseInit];
    self.frame = (CGRectMake(super.frame.origin.x, super.frame.origin.y, SCREEN_WIDTH, VIEW_HEIGHT));
  }
  return self;
}

- (UITextField *) createTextFieldWithFrame:(CGRect)frame {
  UITextField *textField = [[UITextField alloc] initWithFrame:frame];

  textField.borderStyle = UITextBorderStyleNone;
  textField.font = [UIFont boldSystemFontOfSize:FONT_SIZE];
  textField.textColor = [UIColor whiteColor];
  textField.textAlignment = UITextAlignmentCenter;
  textField.autocorrectionType = UITextAutocorrectionTypeNo;
  textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
  textField.keyboardType = UIKeyboardTypeDefault;
  textField.returnKeyType = UIReturnKeyDone;
  textField.clearButtonMode = UITextFieldViewModeNever;
  textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textField.delegate = self;
  textField.text = @"";
  textField.adjustsFontSizeToFitWidth = YES;
  return textField;
}

- (UIButton *) createArrowButtonWithFrame:(CGRect)frame image:(NSString *)imgPath {
  UIImage *image = [UIImage imageNamed:imgPath];
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

  button.tag = NUMBER_FIELD_TAG;
  button.frame = frame;
  [button setBackgroundImage:image forState:UIControlStateNormal];

  return button;
}

- (void) layoutSubviews {

  [super layoutSubviews];

  upButton1 = [SARepeatingButton buttonWithDirection:SARepeatingButtonDirectionUp atPoint:CGPointMake((((SCREEN_WIDTH / 8) * 1) - (BUTTON_WIDTH / 2)), BOTTOM_BTN_Y)];
  [upButton1 addTarget:self action:@selector(increaseValueNumber:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:upButton1];

  upButton2 = [SARepeatingButton buttonWithDirection:SARepeatingButtonDirectionUp atPoint:CGPointMake((((SCREEN_WIDTH / 8) * 3) - (BUTTON_WIDTH / 2)), BOTTOM_BTN_Y)];
  [upButton2 addTarget:self action:@selector(increaseValueLetter:) forControlEvents:UIControlEventTouchUpInside];
  upButton2.tag = STRING_FIELD_TAG;
  [self addSubview:upButton2];

  downButton1 = [SARepeatingButton buttonWithDirection:SARepeatingButtonDirectionDown atPoint:CGPointMake((((SCREEN_WIDTH / 8) * 5) - (BUTTON_WIDTH / 2)), BOTTOM_BTN_Y)];
  [downButton1 addTarget:self action:@selector(decreaseValueNumber:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:downButton1];

  downButton2 = [SARepeatingButton buttonWithDirection:SARepeatingButtonDirectionDown atPoint:CGPointMake((((SCREEN_WIDTH / 8) * 7) - (BUTTON_WIDTH / 2)), BOTTOM_BTN_Y)];
  [downButton2 addTarget:self action:@selector(decreaseValueLetter:) forControlEvents:UIControlEventTouchUpInside];
  downButton2.tag = STRING_FIELD_TAG;
  [self addSubview:downButton2];

  numberTextField = [self createTextFieldWithFrame:CGRectMake(0, BUTTON_HEIGHT + BUTTON_SPACE + TOP_BTN_Y, (SCREEN_WIDTH / 2), TEXT_FIELD_HEIGHT)];
  numberTextField.keyboardType = UIKeyboardTypeNumberPad;
  [self addSubview:numberTextField];

  letterTextField = [self createTextFieldWithFrame:CGRectMake(SCREEN_WIDTH / 2, BUTTON_HEIGHT + BUTTON_SPACE + TOP_BTN_Y, (SCREEN_WIDTH / 2), TEXT_FIELD_HEIGHT)];
  [self addSubview:letterTextField];
} // layoutSubviews

- (void) increaseValueNumber:(id)sender {
  [self endEditing:TRUE];
  numberTextField.text = [SACounterUtil nextNumber:numberTextField.text];
}
- (void) decreaseValueNumber:(id)sender {
  [self endEditing:TRUE];
  numberTextField.text = [SACounterUtil prevNumber:numberTextField.text];
}
- (void) increaseValueLetter:(id)sender {
  [self endEditing:TRUE];
  letterTextField.text = [SACounterUtil nextString:letterTextField.text];
}
- (void) decreaseValueLetter:(id)sender {
  [self endEditing:TRUE];
  letterTextField.text = [SACounterUtil prevString:letterTextField.text];
}

- (NSString *) getAddress {
  return [NSString stringWithFormat:@"%@%@", numberTextField.text, letterTextField.text];
}

// UITextFieldDelegate methods
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
  [textField resignFirstResponder];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
  return TRUE;
}

// Always use upper case chars
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  if (textField == letterTextField) {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    BOOL ok = (newLength > [self maxLengthForInputField:textField]) ? NO : YES;
    if (ok) {
      textField.text = [textField.text stringByReplacingCharactersInRange:range withString:[string uppercaseString]];
    }
    return NO;
  } else {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    BOOL ok = (newLength > [self maxLengthForInputField:textField]) ? NO : YES;
    return [string isEqualToString:@""] ||
           (ok && ([string stringByTrimmingCharactersInSet:
                    [[NSCharacterSet decimalDigitCharacterSet] invertedSet]].length > 0));
  }

  return NO;
}

- (int) maxLengthForInputField:(UITextField *)textField {
  if (textField == letterTextField) {
    return 1;
  } else {
    return 3;
  }
}

@end
