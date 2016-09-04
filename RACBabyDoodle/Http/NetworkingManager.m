//
//  NetworkingManager.m
//  RACBabyDoodle
//
//  Created by Qian Meng on 31/5/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "NetworkingManager.h"
#import <AFNetworkActivityLogger/AFNetworkActivityLogger.h>

static NSString * const kBaseURL = @"http://localhost:3000";

@interface NetworkingManager()

@end

@implementation NetworkingManager
+ (instancetype)sharedManager{
    static NetworkingManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *apiURL = [NSURL URLWithString:kBaseURL];
        manager = [[NetworkingManager alloc] initWithBaseURL:apiURL];
        AFJSONResponseSerializer *responseSerialzer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        manager.responseSerializer = responseSerialzer;
        
#ifdef DEBUG
        [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
        [[AFNetworkActivityLogger sharedLogger] startLogging];
#endif
    });
    
    return manager;
}


- (RACSignal *)allDoodlesWithStart:(NSInteger)start end:(NSInteger)end
{
    NSDictionary *parameters = @{@"start": STR_INT(start), @"end":STR_INT(end)};
    RACSignal *sig = [[self rac_GET:@"/doodles" parameters:parameters] reduceEach:^id
        (AFHTTPRequestOperation *op, NSString *response){
            return response;
        }];
    return [sig deliverOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]];
}


- (RACSignal *)allDoodleTags
{
    RACSignal *sig = [[self rac_GET:@"/doodleTags" parameters:nil] reduceEach:^id
                      (AFHTTPRequestOperation *op, NSString *response){
                          return response;
                      }];
    return [sig deliverOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]];
}



- (RACSignal *)detailsWithIdentity:(NSString *)identity{
    NSDictionary *parameters = @{@"id": STR(identity)};
    RACSignal *sig = [[self rac_GET:@"/details" parameters:parameters] reduceEach:^id
                      (AFHTTPRequestOperation *op, NSString *response){
                          return response;
                      }];
    return [sig deliverOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]];
}

- (RACSignal *)searchDoodlesWithKeyword:(NSString *)keyword
{
    NSDictionary *parameters = @{@"keyword": STR(keyword)};
    RACSignal *sig = [[self rac_GET:@"/search" parameters:parameters] reduceEach:^id
                      (AFHTTPRequestOperation *op, NSString *response){
                          return response;
                      }];
    return [sig deliverOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]];
}




@end
