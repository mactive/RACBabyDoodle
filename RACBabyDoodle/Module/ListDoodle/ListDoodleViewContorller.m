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

@interface ListDoodleViewContorller()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

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

    ListDoodleFlowLayout *flowLayout =[[ListDoodleFlowLayout alloc]init];
    flowLayout.columnCount = 2;
    flowLayout.count  = 20;

    theCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];

    theCollectionView.delegate = self;
    theCollectionView.dataSource = self;
    
    [theCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyCell"];
    
    theCollectionView.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:theCollectionView];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor greenColor];

    return cell;

}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(50, 50);
//}



@end
