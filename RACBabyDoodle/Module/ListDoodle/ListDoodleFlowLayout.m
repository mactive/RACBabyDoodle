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
    // 定义一个列高数组 记录每一列的总高度
    CGFloat columnHeight[self.columnCount];
    // 定义一个记录每一列的总item个数的数组
    NSInteger columnItemCount[self.columnCount];
    
    // 初始化
    for (int i = 0; i < self.columnCount; i++) {
        columnHeight[i] = self.sectionInset.top;
        // 做出左右初始高度差 为了视觉效果
        if(i % 2 != 0){
            columnHeight[i] = columnHeight[i] + 35;
        }
        columnItemCount[i] = 0;
    }
    
    
    // 遍历 goodsList 数组计算相关的属性
    NSInteger index = 0;
    NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:self.count];

    for (index = 0; index<self.count; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        // 找出最短列号
        NSInteger column = [self shortestColumn:columnHeight];
        // 数据追加在最短列
        columnItemCount[column]++;
        
        // X值
        CGFloat itemX = (itemWidth + self.minimumInteritemSpacing) * column + self.sectionInset.left;
        // Y值
        CGFloat itemY = columnHeight[column];
        
        // 等比例缩放 计算item的高度
        // 这一步目前没有 因为 我们高度是个默认值,但最好也是从数据里拿
//        CGFloat itemH = good.h * itemWidth / good.w;
        // TODO:
        CGFloat itemH = itemWidth;

        attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemH);
        [attributesArray addObject:attributes];
        
        // 累加列高
        columnHeight[column] += itemH + self.minimumLineSpacing;

    }
    
    // 找出最高列列号
    NSInteger column = [self highestColumn:columnHeight];
    // 根据最高列设置itemSize 使用总高度的平均值
    CGFloat itemH = (columnHeight[column] - self.minimumLineSpacing * columnItemCount[column]) / columnItemCount[column];

    self.itemSize = CGSizeMake(itemWidth, itemH);

    self.layoutAttributesArray = [attributesArray copy];

}

//用来在一开始给出一套UICollectionViewLayoutAttributes
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    // 直接返回计算好的布局属性数组
    return self.layoutAttributesArray;
}

/**
 *  找出columnHeight数组中最短列号 追加数据的时候追加在最短列中
 */
- (NSInteger)shortestColumn:(CGFloat *)columnHeight {
    
    CGFloat max = CGFLOAT_MAX;
    NSInteger column = 0;
    for (int i = 0; i < self.columnCount; i++) {
        if (columnHeight[i] < max) {
            max = columnHeight[i];
            column = i;
        }
    }
    return column;
}


/**
 *  找出columnHeight数组中最高列号
 */
- (NSInteger)highestColumn:(CGFloat *)columnHeight {
    CGFloat min = 0;
    NSInteger column = 0;
    for (int i = 0; i < self.columnCount; i++) {
        if (columnHeight[i] > min) {
            min = columnHeight[i];
            column = i;
        }
    }
    return column;
}


//通过所在的indexPath确定位置。
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
