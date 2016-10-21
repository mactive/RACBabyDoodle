//
//  PingTransition.m
//  KYPingTransition
//
//  Created by Kitten Yang on 1/30/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "PingTransition.h"
#import "ListDoodleViewContorller.h"
#import "PlayDoodleViewController.h"

@interface PingTransition ()
@property (nonatomic,strong)id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation PingTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return  0.7f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    self.transitionContext = transitionContext;

    ListDoodleViewContorller * fromVC = (ListDoodleViewContorller *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PlayDoodleViewController *toVC = (PlayDoodleViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *contView = [transitionContext containerView];

//    UIButton *button = fromVC.button;
    CGRect buttonFrame = CGRectMake(100, 100, 50, 50);
    CGPoint buttonCenter = CGPointMake(100, 100);
    
    UIBezierPath *maskStartBP =  [UIBezierPath bezierPathWithOvalInRect:buttonFrame];
    [contView addSubview:fromVC.view];
    [contView addSubview:toVC.view];

    //创建两个圆形的 UIBezierPath 实例；一个是 button 的 size ，另外一个则拥有足够覆盖屏幕的半径。最终的动画则是在这两个贝塞尔路径之间进行的
    CGPoint finalPoint;
    //判断触发点在那个象限
    if(buttonFrame.origin.x > (toVC.view.bounds.size.width / 2)){
        if (buttonFrame.origin.y < (toVC.view.bounds.size.height / 2)) {
            //第一象限
            finalPoint = CGPointMake(buttonCenter.x - 0, buttonCenter.y - CGRectGetMaxY(toVC.view.bounds)+30);
        }else{
            //第四象限
            finalPoint = CGPointMake(buttonCenter.x - 0, buttonCenter.y - 0);
        }
    }else{
        if (buttonFrame.origin.y < (toVC.view.bounds.size.height / 2)) {
            //第二象限
            finalPoint = CGPointMake(buttonCenter.x - CGRectGetMaxX(toVC.view.bounds), buttonCenter.y - CGRectGetMaxY(toVC.view.bounds)+30);
        }else{
            //第三象限
            finalPoint = CGPointMake(buttonCenter.x - CGRectGetMaxX(toVC.view.bounds), buttonCenter.y - 0);
        }
    }
    
    CGFloat radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y));
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(buttonFrame, -radius, -radius)];
    
    //创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath; //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskFinalBP.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

#pragma mark - CABasicAnimation的Delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    //告诉 iOS 这个 transition 完成
    [self.transitionContext completeTransition:![self. transitionContext transitionWasCancelled]];
    //清除 fromVC 的 mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
