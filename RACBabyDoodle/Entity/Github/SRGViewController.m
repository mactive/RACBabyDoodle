//
//  SRGViewController.m
//  RACBabyDoodle
//
//  Created by mengqian on 17/4/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "SRGViewController.h"
#import "SRGViewModel.h"
#import "SRGTableViewCell.h"

@interface SRGViewController ()
@property(nonatomic) SRGViewModel *viewModel;

@end

@implementation SRGViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  @weakify(self)
  self.viewModel = [[SRGViewModel alloc]init];
  
  [[RACObserve(self, viewModel.users) ignore:nil] subscribeNext:^(id x) {
    NSLog(@"x: %@",x);
    
    @strongify(self);

    [self.tableView reloadData];
  }];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return 60;
  
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.viewModel.users.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cell_identifier = @"cell_identifier";

  SRGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier];
  if (nil == cell) {
    cell = [[SRGTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
  }
  
  cell.viewModel.userModel = self.viewModel.users[indexPath.row];
  
  return cell;
}


@end
