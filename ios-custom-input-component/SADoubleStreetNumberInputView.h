//
//  SADoubleStreetNumberInputView.h
//  ios-custom-input-component
//
//  Created by Pål Brattberg on 5/2/12.
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAStreetNumberInput.h"

@interface SADoubleStreetNumberInputView : UIView <SAStreetNumberInput>

@property (nonatomic, retain) IBOutlet UIViewController<UITextFieldDelegate> *viewController;

- (UITextField*)createTextFieldWithFrame:(CGRect)frame;

@end

