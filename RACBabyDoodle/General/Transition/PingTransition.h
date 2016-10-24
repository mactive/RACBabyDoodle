//
//  PingTransition.h
//  KYPingTransition
//
//  Created by Kitten Yang on 1/30/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <pop/POP.h>

@interface PingTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign)CGRect startFrame;
@property(nonatomic, assign)CGPoint startCenter;


@end
