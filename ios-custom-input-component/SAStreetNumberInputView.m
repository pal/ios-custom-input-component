//
//  SAStreetNumberInputView.m
//  ios-custom-input-component
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import "SAStreetNumberInputView.h"
#import "SADoubleStreetNumberInputView.h"
#import "SADoubleStreetNumberInputViewHorizontal.h"

@interface SAStreetNumberInputView ()
@property (nonatomic) IBOutlet UIView <SAStreetNumberInput> *input1;
@property (nonatomic) IBOutlet UIView <SAStreetNumberInput> *input2;
@property (nonatomic) IBOutlet UIView <SAStreetNumberInput> *currentView;
@end

@implementation SAStreetNumberInputView

@synthesize input1, input2, currentView;

- (void) rootInitWithFrame:(CGRect)frame {
  input1 = [[SADoubleStreetNumberInputView alloc] initWithFrame:frame];
  input2 = [[SADoubleStreetNumberInputViewHorizontal alloc] initWithFrame:frame];
  [self addSubview:input1];
  currentView = input1;
  [input2 removeFromSuperview];
  self.frame = CGRectMake(super.frame.origin.x, super.frame.origin.y, CGRectGetWidth(input1.frame), CGRectGetHeight(input1.frame));
}

- (id) initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    [self rootInitWithFrame:frame];
  }
  return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    [self rootInitWithFrame:super.frame];
  }
  return self;
}

- (NSString *) getAddress {
  return [currentView getAddress];
}

- (void) changeView:(id)sender {

  float width = self.frame.size.width;
  float height = self.frame.size.height;

  // my nextView hasn't been added to the main view yet, so set the frame to be off-screen
  UIView<SAStreetNumberInput> *nextView = (currentView == input1) ? input2 : input1;

  [nextView setFrame:CGRectMake(width, 0.0, width, height)];

  // then add it to the main view

  [self addSubview:nextView];

  // now animate moving the current view off to the left while the next view is moved into place

  [UIView animateWithDuration:0.4f
                        delay:0.0f
                      options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                   animations: ^{
     [nextView setFrame:currentView.frame];
     [currentView setFrame:CGRectMake (-width, 0.0, width, height)];
   }
                   completion: ^(BOOL finished) {
     // do whatever post processing you want (such as resetting what is "current" and what is "next")
     currentView = nextView;
   }];
} // changeView

@end
