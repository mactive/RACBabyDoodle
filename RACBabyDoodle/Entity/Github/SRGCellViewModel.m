//
//  SRGCellViewModel.m
//  RACBabyDoodle
//
//  Created by mengqian on 15/4/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "SRGCellViewModel.h"
#import "ReactiveCocoa.h"

@implementation SRGCellViewModel

- (instancetype)init{
  self = [super init];
  if(self){
    RAC(self, username) = [RACObserve(self, userModel) map:^id(NSDictionary *value){
      return value[@"login"];
    }];
    
    RAC(self, image) = [[[RACObserve(self, userModel) skip:1] map:^id(NSDictionary *value) {
      return
      [[[NSURLConnection rac_sendAsynchronousRequest:
              [NSURLRequest requestWithURL:
               [NSURL URLWithString:value[@"avatar_url"]]]]
      map:^id(RACTuple *value) {
        return [UIImage imageWithData:value.second scale:[UIScreen mainScreen].scale];
      }] deliverOn:RACScheduler.mainThreadScheduler];
    }] switchToLatest];
  }
  return self;
}




@end
