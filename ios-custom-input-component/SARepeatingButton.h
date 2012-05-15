//
//  SARepeatingButton.h
//  ios-custom-input-component
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  SARepeatingButtonDirectionUp = 0,
  SARepeatingButtonDirectionDown,
} SARepeatingButtonDirection;

#define BUTTON_WIDTH  37
#define BUTTON_HEIGHT 30

@interface SARepeatingButton : UIButton
+ (id) buttonWithDirection:(SARepeatingButtonDirection)direction atPoint:(CGPoint)point;
@end
