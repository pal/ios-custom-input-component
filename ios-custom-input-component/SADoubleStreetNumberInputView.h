//
//  SADoubleStreetNumberInputView.h
//  Input street name and number using arrows under and over the text fields.
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAStreetNumberInput.h"
#import "SARepeatingButton.h"

// Defined in public header for subclass usage
#define STRING_FIELD_TAG  1
#define NUMBER_FIELD_TAG  2
#define FONT_SIZE         60
#define BG_COLOR          [UIColor colorWithPatternImage:[UIImage imageNamed:@"fade_area_bg.png"]];

// Define positions for drawing on screen
#define SCREEN_WIDTH      [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT     [[UIScreen mainScreen] bounds].size.height

#define LEFT_BUTTON_X     ((SCREEN_WIDTH / 4) - (BUTTON_WIDTH / 2))
#define RIGHT_BUTTON_X    (LEFT_BUTTON_X + (SCREEN_WIDTH / 2))
#define TEXT_FIELD_HEIGHT FONT_SIZE
#define VIEW_HEIGHT       184

#define BUTTON_SPACE      5
#define TOP_BTN_Y         ((VIEW_HEIGHT - (TEXT_FIELD_HEIGHT + (BUTTON_HEIGHT + BUTTON_SPACE) * 2)) / 2)
#define BOTTOM_BTN_Y      (TEXT_FIELD_HEIGHT + TOP_BTN_Y + BUTTON_HEIGHT + BUTTON_SPACE * 2)

@interface SADoubleStreetNumberInputView : UIView <SAStreetNumberInput, UITextFieldDelegate>

  @property (nonatomic, retain) UITextField *numberTextField;
@property (nonatomic, retain) UITextField *letterTextField;

// keeping these buttons visible for subclasses
@property (retain) SARepeatingButton *upButton1;
@property (retain) SARepeatingButton *upButton2;
@property (retain) SARepeatingButton *downButton1;
@property (retain) SARepeatingButton *downButton2;

- (IBAction) increaseValueNumber:(id)sender;
- (IBAction) decreaseValueNumber:(id)sender;
- (IBAction) increaseValueLetter:(id)sender;
- (IBAction) decreaseValueLetter:(id)sender;
- (int) maxLengthForInputField:(UITextField *)textField;

@end

