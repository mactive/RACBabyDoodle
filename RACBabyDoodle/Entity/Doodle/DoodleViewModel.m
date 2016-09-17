//
//  DoodleViewModel.m
//  RACBabyDoodle
//
//  Created by mengqian on 4/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "DoodleViewModel.h"
#import "NetworkingManager.h"
#import <UIColor_Hex/UIColor+Hex.h>

@interface DoodleViewModel()
@property(nonatomic, strong)RACCommand *loadDoodleCommand;
@property(nonatomic, copy)NSDictionary *theDict;
@property(nonatomic, strong) NSString *doodleId;
@property(nonatomic, strong) NSString *guid;
@property(nonatomic, strong) UIColor *color;

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *zhName;
@property(nonatomic, strong) NSArray *tags;
@property(nonatomic, strong) NSString *packageZip;
@property(nonatomic, strong) UIImage *cover;

@property(nonatomic, strong) NSDate *createAt;
@property(nonatomic, strong) NSDate *updateAt;

@end

@implementation DoodleViewModel

- (instancetype) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    // 非空判断
    self.doodleId = dict[@"doodleId"];
    
    // 一个观察 看时候触发RACCommand
    @weakify(self);
    [[RACObserve(self, doodleId) filter:^BOOL(NSDictionary* doodleId) {
        return doodleId != nil;
    }] subscribeNext:^(id x) {
        @strongify(self);
        [[self.loadDoodleCommand execute:dict] subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }];
    return self;
}

- (RACCommand *)loadDoodleCommand
{
    if(_loadDoodleCommand)
        return _loadDoodleCommand;
    
    @weakify(self);
    _loadDoodleCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        RACSignal *sig = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            /* 具体的数值转换 */
            self.doodleId = input[@"doodleId"];
            self.guid = input[@"guid"];
            self.color = [UIColor colorWithCSS:input[@"color"]];

            [subscriber sendNext:@(YES)];
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"_loadDoodleCommand dispose");
            }];
        }];
        return sig;
    }];
    return _loadDoodleCommand;
}


@end
