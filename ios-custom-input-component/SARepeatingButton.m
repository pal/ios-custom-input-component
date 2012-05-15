//
//  SARepeatingButton.m
//  ios-custom-input-component
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import "SARepeatingButton.h"

@interface SARepeatingButton ()
@property UILongPressGestureRecognizer *longPress;
@property (retain) id btnTarget;
@property SEL btnTargetAction;
@property NSTimer *buttonHoldTimer;
@end

@implementation SARepeatingButton

@synthesize longPress, buttonHoldTimer, btnTarget, btnTargetAction;

+ (SARepeatingButton *) buttonWithDirection:(SARepeatingButtonDirection)direction atPoint:(CGPoint)point {

  SARepeatingButton *btn = [self buttonWithType:UIButtonTypeCustom];

  [btn setFrame:CGRectMake(point.x, point.y, BUTTON_WIDTH, BUTTON_HEIGHT)];
  NSString *imgPath = (SARepeatingButtonDirectionUp == direction) ? @"icon_arrowBigUp.png" : @"icon_arrowBigDown.png";
  [btn setBackgroundImage:[UIImage imageNamed:imgPath] forState:UIControlStateNormal];
  return btn;
}

- (void) addLongPressRecognizer {
}

// Override to add long-hold recognizer (that does whatever the button itself does)te
- (void) addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
  [super addTarget:target action:action forControlEvents:controlEvents];
  self.btnTarget = target;
  self.btnTargetAction = action;

  longPress = [[UILongPressGestureRecognizer alloc]
               initWithTarget:self
                       action:@selector(handleLongPress:)];
  longPress.minimumPressDuration = 0.4;
  [self addGestureRecognizer:longPress];
}

- (void) handleLongPress:(UILongPressGestureRecognizer *)gesture {
  if (UIGestureRecognizerStateBegan == gesture.state) {
    self.buttonHoldTimer = [NSTimer
                            scheduledTimerWithTimeInterval:0.15
                                                    target:self selector:@selector(timerFireMethod:)
                                                  userInfo:nil repeats:YES];
  }

  if (UIGestureRecognizerStateChanged == gesture.state) {
    // Finger moved
    // TODO: Design what should happen when user moves finger off button
  }

  if (UIGestureRecognizerStateEnded == gesture.state) {
    [self.buttonHoldTimer invalidate];
    self.buttonHoldTimer = nil;
  }
} // handleLongPress

- (void) timerFireMethod:(id *)sender {
  // Remove warning since this is safe by design (but ARC can't tell since it's decided during runtime)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
  [btnTarget performSelector:btnTargetAction withObject:self];
#pragma clang diagnostic pop
}

@end
