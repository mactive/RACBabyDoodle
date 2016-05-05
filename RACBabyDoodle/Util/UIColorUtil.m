//
//  UIColorUtil.m
//  RACBabyDoodle
//
//  Created by Qian Meng on 5/5/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "UIColorUtil.h"

@implementation UIColorUtil

#pragma mark -- utils

+ (UIColor *)lighterColorForColor:(UIColor *)c
{
  CGFloat r, g, b, a;
  if ([c getRed:&r green:&g blue:&b alpha:&a])
    return [UIColor colorWithRed:MIN(r + 0.08, 1.0)
                           green:MIN(g + 0.08, 1.0)
                            blue:MIN(b + 0.08, 1.0)
                           alpha:a];
  return nil;
}

+ (UIColor *)darkerColorForColor:(UIColor *)c
{
  CGFloat r, g, b, a;
  if ([c getRed:&r green:&g blue:&b alpha:&a])
    return [UIColor colorWithRed:MAX(r - 0.08, 0.0)
                           green:MAX(g - 0.08, 0.0)
                            blue:MAX(b - 0.08, 0.0)
                           alpha:a];
  return nil;
}

@end
