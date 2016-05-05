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


NS_INLINE BOOL OSVersionIsAtLeastiOS7() {
  return (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1);
}

#endif /* AppDef_h */
