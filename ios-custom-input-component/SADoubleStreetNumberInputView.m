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
@synthesize viewController;

- (void)baseInit {
  _streetNumber = nil;
  self.backgroundColor = [UIColor blackColor];
}

- (id)initWithFrame:(CGRect)frame
{
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
  textField.borderStyle = UITextBorderStyleNone;
  textField.font = [UIFont boldSystemFontOfSize:62];
  textField.textColor = [UIColor whiteColor];
  textField.placeholder = @"789";
  textField.autocorrectionType = UITextAutocorrectionTypeNo;
  textField.keyboardType = UIKeyboardTypeDefault;
  textField.returnKeyType = UIReturnKeyDone;
  textField.clearButtonMode = UITextFieldViewModeNever;
  textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;    
  return textField;
}

- (void)layoutSubviews {
  
  [super layoutSubviews];
  
  // view is 320x460
  UITextField *textField = [self createTextFieldWithFrame:CGRectMake(10, 10, 140, 100)];
  textField.delegate = viewController;
  [self addSubview:textField];
  
  UITextField *textField2 = [self createTextFieldWithFrame:CGRectMake(150, 10, 140, 100)];

  //  UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 140, 100)];
  textField2.keyboardType = UIKeyboardTypeDefault;
  textField2.placeholder = @"ABC";
  textField2.returnKeyType = UIReturnKeyDone;
  textField2.delegate = viewController;
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

@end
