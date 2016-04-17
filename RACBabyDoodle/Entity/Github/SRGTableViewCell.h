//
//  SRGTableViewCell.h
//  RACBabyDoodle
//
//  Created by mengqian on 17/4/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRGCellViewModel.h"

@interface SRGTableViewCell : UITableViewCell

@property(nonatomic,readonly)SRGCellViewModel *viewModel;

@end
