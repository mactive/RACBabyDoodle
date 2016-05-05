//
//  VaultNavigationController.m
//  RACBabyDoodle
//
//  Created by Qian Meng on 5/5/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "VaultNavigationController.h"
#import "VaultShapeView.h"
#import "UIColorUtil.h"

@interface VaultNavigationController (){
  VaultShapeView *_bgView;
  VaultShapeView *_bgViewShadow;
  UIView *customBGView;
  UIColor *_shadowColor;
}

@end

#define DEFAULT_NAVBG_COLOR [UIColor colorWithRed:111/255.0 green:192/255.0 blue:246/255.0 alpha:1]


@implementation VaultNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [self initCustomNavigationView];
}

/// 初始化
- (void)initCustomNavigationView
{
  /* 顶部颜色和Title字体颜色大小 */
  self.navigationBar.barTintColor = DEFAULT_NAVBG_COLOR;
  self.navigationBar.titleTextAttributes =
  @{
    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0],
    NSForegroundColorAttributeName: WHITECOLOR
    };
  self.navigationBar.barStyle = UIStatusBarStyleLightContent;
  
  /* title 向下移动10dp */
  CGFloat verticalOffset = 12.0f;
  [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:verticalOffset forBarMetrics:UIBarMetricsDefault];
  
  CGRect frame = self.navigationBar.frame;
  _shadowColor = [UIColorUtil darkerColorForColor:DEFAULT_NAVBG_COLOR];

  customBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 100)];
  


  _bgViewShadow = [VaultShapeView new];
  [customBGView addSubview:_bgViewShadow];
  
  _bgView = [VaultShapeView new];
  [customBGView addSubview:_bgView];

  [self.navigationBar addSubview:customBGView];
  [self updateCustomNavigationView];
}


/// 更新
- (void)updateCustomNavigationView
{
  CGRect frame = self.navigationBar.frame;

  _bgView.drawColor = DEFAULT_NAVBG_COLOR;
  _bgViewShadow.drawColor = _shadowColor;
  
  [_bgView setFrame:CGRectMake(0, 0, frame.size.width, 100)];
  [_bgViewShadow setFrame:CGRectMake(0, 5, frame.size.width, 100)];
}


// 如果有颜色设置,也更新
- (void)setBackgroundColor:(UIColor *)backgroundColor
{
  if(backgroundColor){
    _backgroundColor = backgroundColor;
  }else{
    _backgroundColor = DEFAULT_NAVBG_COLOR;
  }
  
  _shadowColor = [UIColorUtil darkerColorForColor:_backgroundColor];
  
  [self updateCustomNavigationView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
