//
//  ListDoodleFlowLayout.m
//  RACBabyDoodle
//
//  Created by Qian Meng on 4/8/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "ListDoodleFlowLayout.h"

@interface ListDoodleFlowLayout()
@property (nonatomic, strong) NSArray *layoutAttributesArray;

@end

@implementation ListDoodleFlowLayout

@synthesize layoutAttributesArray;

- (void)prepareLayout {
    // 根据列数 计算item的宽度 宽度是一样的
    CGFloat contentWidth = self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right;
    CGFloat marginX = self.minimumInteritemSpacing;
    CGFloat itemWidth = (contentWidth - marginX * (self.columnCount - 1)) / self.columnCount;
    // 计算布局属性
//    [self computeAttributesWithItemWidth:itemWidth];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    // 直接返回计算好的布局属性数组
    return self.layoutAttributesArray;
}

@end
