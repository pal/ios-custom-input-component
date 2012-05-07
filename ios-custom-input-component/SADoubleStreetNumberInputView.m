//
//  SADoubleStreetNumberInputView.m
//  ios-custom-input-component
//
//  Created by Pål Brattberg on 5/2/12.
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import "SADoubleStreetNumberInputView.h"
#import "SACounterUtil.h"
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define STRING_FIELD_TAG 1
#define NUMBER_FIELD_TAG 2


// Private methods
@interface SADoubleStreetNumberInputView ()
- (UITextField*)createTextFieldWithFrame:(CGRect)frame;
- (UIButton*)createArrowButtonWithFrame:(CGRect)frame image:(NSString*)imgPath;
@end


@implementation SADoubleStreetNumberInputView

@synthesize numberTextField, letterTextField;


- (void)baseInit {
  numberTextField = nil;
  letterTextField = nil;
  self.backgroundColor = [UIColor lightGrayColor];
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self baseInit];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    [self baseInit];
  }
  return self;
}

-(UITextField *)createTextFieldWithFrame:(CGRect)frame {
  UITextField *textField = [[UITextField alloc] initWithFrame:frame];
  textField.borderStyle = UITextBorderStyleLine;  // TODO Change to None
  textField.font = [UIFont boldSystemFontOfSize:62];
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


-(UIButton *)createArrowButtonWithFrame:(CGRect)frame image:(NSString *)imgPath {
  UIImage *image = [UIImage imageNamed:imgPath];
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.tag = NUMBER_FIELD_TAG;
  button.frame = frame;
  [button setBackgroundImage:image forState:UIControlStateNormal];
  return button;
}

- (void)layoutSubviews {
  
  [super layoutSubviews];
  
  UIButton *upButton1 = [self createArrowButtonWithFrame:CGRectMake(30, 2, 37, 30) image:@"btn-up.png"];
  [upButton1 addTarget:self action:@selector(increaseValueInTextField:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:upButton1];

  UIButton *upButton2 = [self createArrowButtonWithFrame:CGRectMake(170, 2, 37, 30) image:@"btn-up.png"];
  [upButton2 addTarget:self action:@selector(increaseValueInTextField:) forControlEvents:UIControlEventTouchUpInside];
  upButton2.tag = STRING_FIELD_TAG;
  [self addSubview:upButton2];

  UIButton *downButton = [self createArrowButtonWithFrame:CGRectMake(30, 182, 37, 30) image:@"btn-down.png"];
  [downButton addTarget:self action:@selector(decreaseValueInTextField:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:downButton];

  UIButton *downButton2 = [self createArrowButtonWithFrame:CGRectMake(170, 182, 37, 30) image:@"btn-down.png"];
  [downButton2 addTarget:self action:@selector(decreaseValueInTextField:) forControlEvents:UIControlEventTouchUpInside];
  downButton2.tag = STRING_FIELD_TAG;
  [self addSubview:downButton2];

  // view is 320x460
  numberTextField = [self createTextFieldWithFrame:CGRectMake(10, 80, 140, 100)];
  [self addSubview:numberTextField];
  
  letterTextField = [self createTextFieldWithFrame:CGRectMake(150, 80, 140, 100)];
  [self addSubview:letterTextField];
}

-(void)increaseValueInTextField:(id)sender {
  UITextField *textField = ((UIButton*)sender).tag == NUMBER_FIELD_TAG ? numberTextField : letterTextField;
  
  if (textField == numberTextField) {
    textField.text = [SACounterUtil nextNumber:numberTextField.text];
  } else {
    textField.text = [SACounterUtil nextString:letterTextField.text];
  }
}

-(void)decreaseValueInTextField:(id)sender {
  UITextField *textField = ((UIButton*)sender).tag == NUMBER_FIELD_TAG ? numberTextField : letterTextField;
  
  if (textField == numberTextField) {
    textField.text = [SACounterUtil prevNumber:numberTextField.text];
  } else {
    textField.text = [SACounterUtil prevString:letterTextField.text];
  }
}

-(NSString *)getAddress {
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
  [textField resignFirstResponder];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  return TRUE;
}

// Always use upper case chars
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  textField.text = [textField.text stringByReplacingCharactersInRange:range withString:[string uppercaseString]]; 
  return NO;
}

@end
