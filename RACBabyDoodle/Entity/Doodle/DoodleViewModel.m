//
//  DoodleViewModel.m
//  RACBabyDoodle
//
//  Created by mengqian on 4/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "DoodleViewModel.h"
#import "NetworkingManager.h"

@interface DoodleViewModel()
@property(nonatomic, strong)RACCommand *loadDoodleCommand;
@property(nonatomic, copy)NSDictionary *theDict;
@property(nonatomic, strong) NSString *doodleId;
@property(nonatomic, strong) NSString *guid;
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
            self.doodleId = input[@"doodleId"];
            self.guid = input[@"guid"];

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
