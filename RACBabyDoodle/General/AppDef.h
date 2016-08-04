//
//  AppDef.h
//  RACBabyDoodle
//
//  Created by Qian Meng on 5/5/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#ifndef AppDef_h
#define AppDef_h


#define XAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define WHITECOLOR [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1]

#define TOTAL_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define TOTAL_WIDTH [[UIScreen mainScreen] bounds].size.width


NS_INLINE BOOL OSVersionIsAtLeastiOS7() {
  return (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1);
}


#pragma mark - mactive

#define T(a)    NSLocalizedString((a), nil)

#define INT(a)      [NSNumber numberWithInt:(a)]
#define FLOAT(a)    [NSNumber numberWithFloat:(a)]
#define NUM_BOOL(a) [NSNumber numberWithBool:(a)]
#define C_SYMBOL @"-"

#define STR(a)  [NSString stringWithFormat:@"%@", (a)]
#define STR_INT(a)  [NSString stringWithFormat:@"%d", (a)]
#define STR_LONG(a)  [NSString stringWithFormat:@"%ld", (a)]
#define STR_NUM2(a)  [NSString stringWithFormat:@"%.2f", (a)]
#define STR_NUM0(a)  [NSString stringWithFormat:@"%.0f", (a)]

#define NUMBER_OR_NIL(a)	\
(((a) && [(a) isKindOfClass:[NSNumber class]]) ? (a) : nil)

#define STRING_OR_NIL(a)	\
(((a) && [(a) isKindOfClass:[NSString class]]) ? (a) : nil)

#define STRING_OR_EMPTY(a)	\
(((a) && [(a) isKindOfClass:[NSString class]]) ? (a) : @"")


#endif /* AppDef_h */
