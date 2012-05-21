//
//  SAStreetNumberInput.h
//  Protocol for custom input of street number.
//
//  Copyright (c) 2012 Acando. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SAStreetNumberInput
- (NSString *) getAddress;
- (IBAction) setAddress:(NSString *)newAddress;
- (IBAction) isActiveInputMethod:(BOOL)active;
@end
