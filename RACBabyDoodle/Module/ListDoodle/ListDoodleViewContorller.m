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
#import "NetworkingManager.h"
#import "DoodleViewModel.h"
#import "PlayDoodleViewController.h"
#import "PingTransition.h"

@interface ListDoodleViewContorller()<UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate>

@property(nonatomic, strong)UICollectionView *theCollectionView;
@property(nonatomic, strong)NSMutableArray *dataSource;
@property(nonatomic, assign)CGRect startFrame;
@property(nonatomic, assign)CGPoint startCenter;



@end

@implementation ListDoodleViewContorller
@synthesize theCollectionView;
@synthesize dataSource;

- (id)init{
    if(self = [super init]){
        //
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    dataSource = [[NSMutableArray alloc]init];

    [[[NetworkingManager sharedManager] allDoodlesWithStart:0 end:20] subscribeNext:^(NSArray *doodles) {
        NSLog(@"%@",doodles);
        for (NSDictionary* dict in doodles) {
            DoodleViewModel *viewModel = [[DoodleViewModel alloc] initWithDict:dict];
            [dataSource addObject:viewModel];
        }
        
        ListDoodleFlowLayout *flowLayout =[[ListDoodleFlowLayout alloc]init];
        flowLayout.columnCount = 2;
        flowLayout.count  = [dataSource count];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [theCollectionView.collectionViewLayout invalidateLayout];
            [theCollectionView setCollectionViewLayout:flowLayout animated:YES];
            [theCollectionView reloadData];
        });      
    }];
    
    UICollectionViewLayout *flowLayout =[[UICollectionViewLayout alloc]init];

    theCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    
    theCollectionView.delegate = self;
    theCollectionView.dataSource = self;
    
    [theCollectionView registerClass:[ListDoodleViewCell class] forCellWithReuseIdentifier:@"MyCell"];
    
    theCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:theCollectionView];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListDoodleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[ListDoodleViewCell alloc] init];
    }
    
    cell.viewModel = [self.dataSource objectAtIndex:indexPath.row];
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath %ld",indexPath.row);

    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    
    self.startFrame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y - collectionView.contentOffset.y, attributes.frame.size.width, attributes.frame.size.height);
//    attributes.frame;
    self.startCenter = CGPointMake(attributes.center.x, attributes.center.y-collectionView.contentOffset.y);
    
    CGFloat origin_x = self.startCenter.x - self.startFrame.size.width / 2;
    CGFloat origin_y = self.startCenter.y - self.startFrame.size.height / 2;
    self.startFrame = CGRectMake(origin_x, origin_y, self.startFrame.size.width, self.startFrame.size.height);
    
    
    
    DoodleViewModel *viewModel = [self.dataSource objectAtIndex:indexPath.row];
    PlayDoodleViewController *playVC = [[PlayDoodleViewController alloc]init];
    playVC.viewModel = viewModel;
    
    playVC.transitioningDelegate = self;
    
    [self presentViewController:playVC animated:YES completion:^{
        //
    }];

}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    PingTransition *ping = [PingTransition new];
    ping.startCenter = self.startCenter;
    ping.startFrame = self.startFrame;


    
    return ping;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return nil;
}



@end
