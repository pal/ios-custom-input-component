//
//  SADoubleStreetNumberInputView.m
//  ios-custom-input-component
//
//  Created by Pål Brattberg on 5/2/12.
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import "SADoubleStreetNumberInputView.h"
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>

@implementation SADoubleStreetNumberInputView

@synthesize streetNumber = _streetNumber;
//@synthesize viewController;

- (void)baseInit {
  _streetNumber = nil;
  self.backgroundColor = [UIColor blackColor];
  //  self.viewController
  
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
  return textField;
}

- (void)layoutSubviews {
  
  [super layoutSubviews];
  
  // view is 320x460
  UITextField *textField = [self createTextFieldWithFrame:CGRectMake(10, 10, 140, 100)];
  [self addSubview:textField];
  
  UITextField *textField2 = [self createTextFieldWithFrame:CGRectMake(150, 10, 140, 100)];
  [self addSubview:textField2];
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

// Always use upper case chars
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  textField.text = [textField.text stringByReplacingCharactersInRange:range withString:[string uppercaseString]]; 
  return NO;
}

@end
