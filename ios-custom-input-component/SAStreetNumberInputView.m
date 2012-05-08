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
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:0.5];
  if ([input1 superview]) {
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:YES];
    [input1 removeFromSuperview];
    [self addSubview:input2];
  } else if ([input2 superview]) {
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self cache:YES];
    [input2 removeFromSuperview];
    [self addSubview:input1];
  }
  [UIView commitAnimations];
}

@end
