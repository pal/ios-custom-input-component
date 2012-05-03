//
//  SAViewController.m
//  ios-custom-input-component
//
//  Created by Pål Brattberg on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SAViewController.h"

@interface SAViewController ()

@end

@implementation SAViewController

@synthesize tapRecognizer;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  
  [nc addObserver:self selector:@selector(keyboardWillShow:) name:
   UIKeyboardWillShowNotification object:nil];
  
  [nc addObserver:self selector:@selector(keyboardWillHide:) name:
   UIKeyboardWillHideNotification object:nil];
  
  tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(didTapAnywhere:)];
  
  
  
}

-(void) keyboardWillShow:(NSNotification *) note {
  [self.view addGestureRecognizer:tapRecognizer];
}

-(void) keyboardWillHide:(NSNotification *) note
{
  [self.view removeGestureRecognizer:tapRecognizer];
}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {    
  [self.view endEditing:TRUE];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
