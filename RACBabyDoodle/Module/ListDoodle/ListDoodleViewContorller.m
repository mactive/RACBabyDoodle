//
//  ListDoodleViewContorller.m
//  RACBabyDoodle
//
//  Created by Qian Meng on 4/8/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "ListDoodleViewContorller.h"
#import "ListDoodleViewCell.h"
#import "ListDoodleFlowLayout.h"

@interface ListDoodleViewContorller()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *theCollectionView;

@end

@implementation ListDoodleViewContorller
@synthesize theCollectionView;

- (id)init{
    if(self = [super init]){
        //
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];

    flowLayout.itemSize = CGSizeMake(100, 100);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumInteritemSpacing:1.0f];
    [flowLayout setMinimumLineSpacing:2.0f];

    

    theCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];

    theCollectionView.delegate = self;
    theCollectionView.dataSource = self;
    theCollectionView.backgroundColor = [UIColor blueColor];
    
    [theCollectionView registerClass:[UICollectionView class]
            forCellWithReuseIdentifier:@"MyCell"];
    
    [self.view addSubview:theCollectionView];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    return cell;

}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat height=100+(arc4random()%100);
//    return  CGSizeMake(100, height);
//}




@end
