//
//  SAViewController.h
//  ios-custom-input-component
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import "SADoubleStreetNumberInputView.h"
#import <UIKit/UIKit.h>

@interface SAViewController : UIViewController
  @property (nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (nonatomic) IBOutlet SADoubleStreetNumberInputView *input;

- (IBAction) showCurrentValue:(id)sender;
@end
