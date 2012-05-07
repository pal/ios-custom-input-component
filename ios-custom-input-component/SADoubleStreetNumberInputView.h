//
//  SADoubleStreetNumberInputView.h
//  ios-custom-input-component
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAStreetNumberInput.h"

@interface SADoubleStreetNumberInputView : UIView <SAStreetNumberInput, UITextFieldDelegate>

  @property (nonatomic, retain) UITextField *numberTextField;
@property (nonatomic, retain) UITextField *letterTextField;

- (IBAction) increaseValueInTextField:(id)sender;
- (IBAction) decreaseValueInTextField:(id)sender;

@end

