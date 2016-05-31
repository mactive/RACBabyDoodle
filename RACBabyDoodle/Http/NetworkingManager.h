//
//  NetworkingManager.h
//  RACBabyDoodle
//
//  Created by Qian Meng on 31/5/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@interface NetworkingManager : AFHTTPRequestOperationManager

+(instancetype)sharedManager;

- (RACSignal *) allDoodlesWithStart:(NSInteger)start end:(NSInteger)end;
- (RACSignal *) detailsWithIdentity:(NSString *)identity;
- (RACSignal *) searchDoodlesWithKeyword:(NSString *)keyword;
- (RACSignal *) allDoodleTags;


@end
