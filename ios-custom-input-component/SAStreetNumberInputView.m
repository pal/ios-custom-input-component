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
  self.backgroundColor = [UIColor clearColor];
  input1 = [[SADoubleStreetNumberInputView alloc] initWithFrame:frame];
  input2 = [[SADoubleStreetNumberInputViewHorizontal alloc] initWithFrame:frame];
  [self addSubview:input1];
  currentView = input1;
  [input2 removeFromSuperview];
  self.frame = CGRectMake(super.frame.origin.x, super.frame.origin.y, CGRectGetWidth(input1.frame), CGRectGetHeight(input1.frame));

  UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
  leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
  [self addGestureRecognizer:leftSwipeGestureRecognizer];

  UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
  rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
  [self addGestureRecognizer:rightSwipeGestureRecognizer];
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

- (IBAction) handleSwipe:(UISwipeGestureRecognizer *)recognizer {
  BOOL leftSwipe = (recognizer.direction == UISwipeGestureRecognizerDirectionLeft);

  float width = self.frame.size.width;
  float height = self.frame.size.height;

  // my nextView hasn't been added to the main view yet, so set the frame to be off-screen
  UIView<SAStreetNumberInput> *nextView = (currentView == input1) ? input2 : input1;


  int nextViewStartingPosition = -width;
  int currentViewEndPosition = width;
  if (leftSwipe) {
    NSLog(@"swipe left");
    nextViewStartingPosition = width;
    currentViewEndPosition = -width;
  } else {
    NSLog(@"swipe right");
  }


  [nextView setFrame:CGRectMake(nextViewStartingPosition, 0.0, width, height)];

  // then add it to the main view
  [self addSubview:nextView];



  // now animate moving the current view off to the direction of the swipe while the next view is moved into place
  [UIView animateWithDuration:0.4f
                        delay:0.0f
                      options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                   animations: ^{
     [nextView setFrame:currentView.frame];
     [currentView setFrame:CGRectMake (currentViewEndPosition, 0.0, width, height)];
   }
                   completion: ^(BOOL finished) {
     // do whatever post processing you want (such as resetting what is "current" and what is "next")
     currentView = nextView;
   }];
} // handleSwipe
@end
