//
//  SADoubleStreetNumberInputView.h
//  ios-custom-input-component
//
//  Created by Pål Brattberg on 5/2/12.
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAStreetNumberInput.h"

@interface SADoubleStreetNumberInputView : UIView <SAStreetNumberInput, UITextFieldDelegate>

- (UITextField*)createTextFieldWithFrame:(CGRect)frame;
- (UIButton*)createArrowButtonWithFrame:(CGRect)frame image:(NSString*)imgPath;

@property (nonatomic,retain) UITextField * numberTextField;
@property (nonatomic,retain) UITextField * letterTextField;


- (IBAction)increaseValueInTextField:(id)sender;
- (IBAction)decreaseValueInTextField:(id)sender;

@end

