//
//  PlayDoodleViewController.m
//  RACBabyDoodle
//
//  Created by mengqian on 18/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "PlayDoodleViewController.h"

@interface PlayDoodleViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation PlayDoodleViewController
@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = viewModel.color;
    [self initUI];
}

- (void)initUI{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"back" forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(20, 20, 100, 50)];
    [self.view addSubview:backButton];
    backButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return [RACSignal empty];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
