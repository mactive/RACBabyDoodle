//
//  ViewController.m
//  RACBabyDoodle
//
//  Created by Qian Meng on 26/3/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()
@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  
  // 绑定第一个
//  [self.nameField.rac_textSignal subscribeNext:^(id x) {
//    NSLog(@"%@",x);
//  }];
  
  // 可以绑定两个
  [self.nameField.rac_textSignal subscribeNext:^(id x) {
    NSLog(@"2-%@",x);
  } error:^(NSError *error) {
    NSLog(@"2-%@",error);
  } completed:^{
    NSLog(@"2-Complete");
  }];
  
  
  [self racAction];
  
  
  
  // Do any additional setup after loading the view, typically from a nib.
}

-(void)racAction{
  
  RACSignal * validEmailSignal = [self.nameField.rac_textSignal map:^id(id value) {
    return @([value rangeOfString:@"@"].location != NSNotFound);
  }];
  
  RAC(self.button, enabled) = validEmailSignal;
  
  
  RAC(self.nameField, textColor) = [validEmailSignal map:^id(id value) {
    if([value boolValue]){
      return [UIColor greenColor];
    }else{
      return [UIColor blueColor];
    }
  }];
  
  
  
}



- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
