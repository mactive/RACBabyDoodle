//
//  ListDoodleViewCell.m
//  RACBabyDoodle
//
//  Created by Qian Meng on 4/8/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "ListDoodleViewCell.h"
#import "DoodleViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface ListDoodleViewCell()
@property(nonatomic, strong)UIView *mainView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *avatarView;
@property(nonatomic, assign)CGRect frame;
@end

@implementation ListDoodleViewCell
@synthesize viewModel;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        // rand 0.5 - 1
        CGFloat scale = [self randomBetweenSmall:0.7 big:0.9];
        CGFloat startX = frame.size.width * (1 - scale) / 2;
        CGFloat width = frame.size.width * scale;

        CGRect mainViewFrame = CGRectMake(startX, startX, width, width);
        self.frame = mainViewFrame;

        _mainView  = [[UIView alloc]initWithFrame:mainViewFrame];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, width-40, width , 40)];
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [self addSubview:_mainView];
        [_mainView addSubview:_avatarView];
        [_mainView addSubview:_titleLabel];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FONT_14;
        _mainView.layer.cornerRadius = width / 2;
        _mainView.layer.masksToBounds = YES;

    }
    return self;
}

// 大小随机数发生器
-(CGFloat)randomBetweenSmall:(CGFloat)smallNumber big:(CGFloat)bigNumber
{
    float diff = bigNumber - smallNumber;
    return (((float) rand() / RAND_MAX) * diff) + smallNumber;
}

-(void)setViewModel:(DoodleViewModel *)_viewModel
{
    _titleLabel.text = _viewModel.name;
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:_viewModel.cover] placeholderImage:nil];
    _mainView.backgroundColor = _viewModel.color;
    _titleLabel.backgroundColor = _viewModel.color;
    _titleLabel.textColor = WHITECOLOR;

    [self makeMaskWithFrame:self.frame withViewModel:_viewModel];

}

-(void)makeMaskWithFrame:(CGRect)frame withViewModel:(DoodleViewModel *)_viewModel
{
    // Create a mask layer and the frame to determine what will be visible in the view.
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
//    CGContextFillEllipseInRect();
    CGRect maskRect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    // Create a path with the rectangle in it.
    CGPathRef path = CGPathCreateWithEllipseInRect(maskRect, NULL);
    
    // Set the path to the mask layer.
    maskLayer.path = path;
    
    // Release the path since it's not covered by ARC.
    CGPathRelease(path);
    
    // Set the mask of the view.
    _mainView.layer.mask = maskLayer;
    _mainView.layer.borderWidth = 2.0f;
    _mainView.layer.borderColor = _viewModel.color.CGColor;
    // 方向
    // 尝试用去 圆角矩形去实现 一个圆形  borderRadius 而不是 mask了
}




@end
