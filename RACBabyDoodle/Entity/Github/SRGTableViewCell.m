//
//  SRGTableViewCell.m
//  RACBabyDoodle
//
//  Created by mengqian on 17/4/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "SRGTableViewCell.h"

@interface SRGTableViewCell()

@property(nonatomic)SRGCellViewModel *viewModel;
@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UIImageView *userpicImageView;

@end

@implementation SRGTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.viewModel = [SRGCellViewModel new];
    [self initView];

    RAC(self,userpicImageView.image) = RACObserve(self, viewModel.image);
    RAC(self, usernameLabel.text) = RACObserve(self, viewModel.username);
  }
  return self;
}

-(void)initView
{
  self.userpicImageView = [[UIImageView alloc]init];
  self.usernameLabel = [[UILabel alloc]init];

  [self addSubview:self.usernameLabel];
  [self addSubview:self.userpicImageView];
  
  UIView *superview = self;
  
  [self.userpicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview.mas_top).with.offset(5);
    make.left.equalTo(superview.mas_left).with.offset(5);
    make.bottom.equalTo(superview.mas_bottom).with.offset(5);
    make.height.equalTo(self.contentView.mas_height).offset(-10);
    make.width.equalTo(self.contentView.mas_height).offset(-10);
  }];
  
  
  [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.userpicImageView.mas_right).with.offset(10);
    make.top.equalTo(superview.mas_top).with.offset(5);
    make.top.equalTo(superview.mas_right).with.offset(10);
    make.height.equalTo(@40);
  }];
  
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
