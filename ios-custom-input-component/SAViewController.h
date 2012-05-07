//
//  SAViewController.h
//  ios-custom-input-component
//
//  Created by Pål Brattberg on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SADoubleStreetNumberInputView.h"
#import <UIKit/UIKit.h>

@interface SAViewController : UIViewController
  @property (nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;
 @property (nonatomic) IBOutlet SADoubleStreetNumberInputView* input;

-(IBAction)showCurrentValue:(id)sender;
@end
