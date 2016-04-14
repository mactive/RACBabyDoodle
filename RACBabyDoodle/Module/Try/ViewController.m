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
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController
@synthesize nameField;
@synthesize button;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.nameField = [[UITextField alloc] init];
  [self.nameField setBorderStyle:UITextBorderStyleLine];
  self.nameField.translatesAutoresizingMaskIntoConstraints = NO;

  self.button = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.button setFrame:CGRectMake(40, 150, 120, 40)];
  [self.button setBackgroundColor:[UIColor grayColor]];
  
  UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
  
  UIView * superView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 200, 60)];
  [superView setBackgroundColor:[UIColor grayColor]];
  [superView addSubview:self.nameField];

  [self.view addSubview:superView];
  [superView addConstraints:@[
      [NSLayoutConstraint constraintWithItem:self.nameField
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:superView
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1.0
                                    constant:padding.top],
      [NSLayoutConstraint constraintWithItem:self.nameField
                                   attribute:NSLayoutAttributeLeft
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:superView
                                   attribute:NSLayoutAttributeLeft
                                  multiplier:1.0
                                    constant:padding.left],
      [NSLayoutConstraint constraintWithItem:self.nameField
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:superView
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1.0
                                    constant:-padding.bottom],
      [NSLayoutConstraint constraintWithItem:self.nameField
                                   attribute:NSLayoutAttributeRight
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:superView
                                   attribute:NSLayoutAttributeRight
                                  multiplier:1.0
                                    constant:-padding.right],
  ]];
  
  
  [self.view addSubview:self.button];
  
  
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
  [self coldSignal];
  [self testRACLifting];
  
  
  // Do any additional setup after loading the view, typically from a nib.
}

-(void)testRACLifting
{
  // A 暂停了2S
  RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
      [subscriber sendNext:@"A"];
    });
    return nil;
  }];
  
  
  // B 输出了两次信号
  RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    [subscriber sendNext:@"B"];
    [subscriber sendNext:@"Another A"];
    [subscriber sendCompleted];
    return nil;
  }];
  
  //它的意思是当signalA和signalB都至少sendNext过一次，接下来只要其中任意一个signal有了新的内容，doA:withB这个方法就会自动被触发。
  // 所以他会等A 然后 B已经执行了两个了 所以B会是第二个send的内容
  [self rac_liftSelector:@selector(doA:withB:) withSignals:signalA,signalB, nil];
  
}

- (void)doA:(NSString *)A withB:(NSString *)B
{
  NSLog(@"A:%@ and B:%@",A,B);
}

-(void)coldSignal{
  RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    NSLog(@"triggered");
    [subscriber sendNext:@"foobar"];
    [subscriber sendCompleted];
    return nil;
  }];
  
  [signal subscribeCompleted:^{
    NSLog(@"subscription %@",signal.name);
  }];
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
