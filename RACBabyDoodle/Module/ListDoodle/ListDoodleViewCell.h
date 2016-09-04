//
//  ListDoodleViewCell.h
//  RACBabyDoodle
//
//  Created by Qian Meng on 4/8/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DoodleViewModel;

@interface ListDoodleViewCell : UICollectionViewCell
@property(nonatomic, strong) DoodleViewModel *viewModel;

@end
