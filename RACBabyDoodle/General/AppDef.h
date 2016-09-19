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


// data time format
#define ISO_TIMEZONE_UTC_FORMAT     @"Z"
#define ISO_TIMEZONE_OFFSET_FORMAT  @"+%02d:%02d"

#define DATETIME_FORMATE    @"yyyy-MM-dd HH:mm:ss "  //@"yyyy-MM-dd hh:mm:ss"
#define DATE_FORMATE        @"yyyy-MM"
#define DATE_YMD_FORMATE    @"yyyy-MM-dd"

NS_INLINE BOOL StringHasValue(id str) {
    return (str != nil) && (str != [NSNull null]) && (![str isEqualToString:@""] && (![str isEqualToString:@"(null)"]));
}

NS_INLINE BOOL NumberHasRealValue(id str) {
    return (str != nil) && (str != [NSNull null]) && (![str isEqualToNumber:[NSNumber numberWithInt:0]]);
}

NS_INLINE BOOL NumberHasValue(id str) {
    return (str != nil) && (str != [NSNull null]);
}

NS_INLINE BOOL BoolHasValue(id str) {
    return (str != nil) && (str != [NSNull null]);
}


#define FONT_10 [UIFont systemFontOfSize:10.0f]
#define FONT_11 [UIFont systemFontOfSize:11.0f]
#define FONT_12 [UIFont systemFontOfSize:12.0f]
#define FONT_13 [UIFont systemFontOfSize:13.0f]
#define FONT_15 [UIFont systemFontOfSize:15.0f]
#define FONT_14 [UIFont systemFontOfSize:14.0f]
#define FONT_16 [UIFont systemFontOfSize:16.0f]
#define FONT_20 [UIFont systemFontOfSize:20.0f]
#define FONT_24 [UIFont systemFontOfSize:24.0f]

#endif /* AppDef_h */
