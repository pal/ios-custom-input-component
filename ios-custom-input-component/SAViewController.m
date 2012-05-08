//
//  SAViewController.m
//  ios-custom-input-component
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import "SAViewController.h"

@interface SAViewController ()
@property (nonatomic) UITapGestureRecognizer *tapRecognizer;
@end

@implementation SAViewController

@synthesize tapRecognizer;
@synthesize streetNumberInputView;

- (void) showCurrentValue:(id)sender {
  NSLog(@"Address: %@", [streetNumberInputView getAddress]);
  UIAlertView *alert = [[UIAlertView alloc]
                            initWithTitle:@"Vald adress"
                                  message:[streetNumberInputView getAddress]
                                 delegate:nil
                        cancelButtonTitle:@"OK"
                        otherButtonTitles:nil];
  [alert show];
}

- (void) viewDidLoad {
  [super viewDidLoad];

  // Handle background clicks
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];

  [nc addObserver:self
         selector:@selector(keyboardWillShow:)
             name:UIKeyboardWillShowNotification
           object:nil];

  [nc addObserver:self
         selector:@selector(keyboardWillHide:)
             name:UIKeyboardWillHideNotification
           object:nil];

  tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(didTapAnywhere:)];
}


- (void) keyboardWillShow:(NSNotification *)note {
  [self.view addGestureRecognizer:tapRecognizer];
}

- (void) keyboardWillHide:(NSNotification *)note {
  [self.view removeGestureRecognizer:tapRecognizer];
}

- (void) didTapAnywhere:(UITapGestureRecognizer *)recognizer {
  [self.view endEditing:TRUE];
}

- (void) viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
