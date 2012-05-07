//
//  SADoubleStreetNumberInputView.m
//  ios-custom-input-component
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import "SADoubleStreetNumberInputView.h"
#import "SACounterUtil.h"
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define STRING_FIELD_TAG  1
#define NUMBER_FIELD_TAG  2
#define FONT_SIZE         60
#define BG_COLOR          [UIColor blackColor]

// Define positions for drawing on screen
#define SCREEN_WIDTH      [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT     [[UIScreen mainScreen] bounds].size.height
#define BUTTON_WIDTH      37
#define BUTTON_HEIGHT     30

#define LEFT_BUTTON_X     ((SCREEN_WIDTH / 4) - (BUTTON_WIDTH / 2))
#define RIGHT_BUTTON_X    (LEFT_BUTTON_X + (SCREEN_WIDTH / 2))
#define TEXT_FIELD_HEIGHT FONT_SIZE

#define BUTTON_SPACE      5
#define TOP_BTN_Y         0
#define BOTTOM_BTN_Y      (TEXT_FIELD_HEIGHT + BUTTON_HEIGHT + BUTTON_SPACE * 2)


// Private methods
@interface SADoubleStreetNumberInputView ()
- (UITextField *) createTextFieldWithFrame:(CGRect)frame;
- (UIButton *) createArrowButtonWithFrame:(CGRect)frame image:(NSString *)imgPath;
@end


@implementation SADoubleStreetNumberInputView

@synthesize numberTextField, letterTextField;


- (void) baseInit {
  numberTextField = nil;
  letterTextField = nil;
  self.backgroundColor = BG_COLOR;
}

- (id) initWithFrame:(CGRect)frame {
  self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BOTTOM_BTN_Y + BUTTON_HEIGHT)];
  if (self) {
    [self baseInit];
  }
  return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    [self baseInit];
    self.frame = (CGRectMake(super.frame.origin.x, super.frame.origin.y, SCREEN_WIDTH, BOTTOM_BTN_Y + BUTTON_HEIGHT));
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


  UIButton *upButton1 = [self createArrowButtonWithFrame:CGRectMake(LEFT_BUTTON_X, TOP_BTN_Y, BUTTON_WIDTH, BUTTON_HEIGHT) image:@"btn-up.png"];
  [upButton1 addTarget:self action:@selector(increaseValueInTextField:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:upButton1];

  UIButton *upButton2 = [self createArrowButtonWithFrame:CGRectMake(RIGHT_BUTTON_X, TOP_BTN_Y, BUTTON_WIDTH, BUTTON_HEIGHT) image:@"btn-up.png"];
  [upButton2 addTarget:self action:@selector(increaseValueInTextField:) forControlEvents:UIControlEventTouchUpInside];
  upButton2.tag = STRING_FIELD_TAG;
  [self addSubview:upButton2];

  UIButton *downButton = [self createArrowButtonWithFrame:CGRectMake(LEFT_BUTTON_X, BOTTOM_BTN_Y, BUTTON_WIDTH, BUTTON_HEIGHT) image:@"btn-down.png"];
  [downButton addTarget:self action:@selector(decreaseValueInTextField:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:downButton];

  UIButton *downButton2 = [self createArrowButtonWithFrame:CGRectMake(RIGHT_BUTTON_X, BOTTOM_BTN_Y, BUTTON_WIDTH, BUTTON_HEIGHT) image:@"btn-down.png"];
  [downButton2 addTarget:self action:@selector(decreaseValueInTextField:) forControlEvents:UIControlEventTouchUpInside];
  downButton2.tag = STRING_FIELD_TAG;
  [self addSubview:downButton2];

  // view is 320x460
  numberTextField = [self createTextFieldWithFrame:CGRectMake(0, BUTTON_HEIGHT + BUTTON_SPACE, (SCREEN_WIDTH / 2), TEXT_FIELD_HEIGHT)];
  [self addSubview:numberTextField];

  letterTextField = [self createTextFieldWithFrame:CGRectMake(SCREEN_WIDTH / 2, BUTTON_HEIGHT + BUTTON_SPACE, (SCREEN_WIDTH / 2), TEXT_FIELD_HEIGHT)];
  [self addSubview:letterTextField];
} // layoutSubviews

- (void) increaseValueInTextField:(id)sender {
  UITextField *textField = ((UIButton *)sender).tag == NUMBER_FIELD_TAG ? numberTextField : letterTextField;

  if (textField == numberTextField) {
    textField.text = [SACounterUtil nextNumber:numberTextField.text];
  } else {
    textField.text = [SACounterUtil nextString:letterTextField.text];
  }
}

- (void) decreaseValueInTextField:(id)sender {
  UITextField *textField = ((UIButton *)sender).tag == NUMBER_FIELD_TAG ? numberTextField : letterTextField;

  if (textField == numberTextField) {
    textField.text = [SACounterUtil prevNumber:numberTextField.text];
  } else {
    textField.text = [SACounterUtil prevString:letterTextField.text];
  }
}

- (NSString *) getAddress {
  return [NSString stringWithFormat:@"%@%@", numberTextField.text, letterTextField.text];
}


/*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   - (void)drawRect:(CGRect)rect
   {
    // Drawing code
   }
 */

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
  textField.text = [textField.text stringByReplacingCharactersInRange:range withString:[string uppercaseString]];
  return NO;
}

@end
