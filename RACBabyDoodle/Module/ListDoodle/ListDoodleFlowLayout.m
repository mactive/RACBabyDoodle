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
    
    
//    flowLayout.itemSize = CGSizeMake(100, 100);
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    [flowLayout setMinimumInteritemSpacing:1.0f];
//    [flowLayout setMinimumLineSpacing:2.0f];
    // 计算布局属性
    [self computeAttributesWithItemWidth:itemWidth];
}

- (void)computeAttributesWithItemWidth:(CGFloat)itemWidth
{
    NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:self.count];

    for (int index =0; index<self.count; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGFloat column = 0;
        // X值
        CGFloat itemX = (itemWidth + self.minimumInteritemSpacing) * column + self.sectionInset.left;
        // Y值
        CGFloat itemY = 100 * index;
        
        attributes.frame = CGRectMake(itemX, itemY, itemWidth, 70);
        [attributesArray addObject:attributes];
    }
    
    self.layoutAttributesArray = [attributesArray copy];


}

//用来在一开始给出一套UICollectionViewLayoutAttributes
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    // 直接返回计算好的布局属性数组
    return self.layoutAttributesArray;
}

//通过所在的indexPath确定位置。
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
