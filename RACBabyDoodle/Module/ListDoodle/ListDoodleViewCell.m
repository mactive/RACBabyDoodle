//
//  ListDoodleViewCell.m
//  RACBabyDoodle
//
//  Created by Qian Meng on 4/8/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "ListDoodleViewCell.h"
#import "DoodleViewModel.h"

@interface ListDoodleViewCell()
@property(nonatomic, strong)UIView *mainView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *avatarView;
@end

@implementation ListDoodleViewCell
@synthesize viewModel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _mainView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 40, 40)];
        [self addSubview:_mainView];
        [_mainView addSubview:_titleLabel];
        [_mainView addSubview:_avatarView];
        _mainView.backgroundColor = [UIColor greenColor];
        [self makeMaskWithFrame:frame];
    }
    return self;
}

-(void)setViewModel:(DoodleViewModel *)_viewModel
{
    _titleLabel.text = _viewModel.doodleId;
}

-(void)makeMaskWithFrame:(CGRect)frame
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
    _mainView.layer.borderColor = [UIColor blueColor].CGColor;
    // 方向
    // 尝试用去 圆角矩形去实现 一个圆形  borderRadius 而不是 mask了
}




@end
