//
//  SRGViewModel.m
//  RACBabyDoodle
//
//  Created by mengqian on 15/4/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "SRGViewModel.h"

@interface SRGViewModel()
//@property(nonatomic)NSArray *users;

@end

@implementation SRGViewModel

//@synthesize users;

- (instancetype)init
{
  self = [super init];
  if(self){
    
    RACSignal *sig = [NSURLConnection rac_sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.github.com/users"]]];
    
    RACSignal *sigMapped =
    
    [sig map:^id(RACTuple *value) {
      NSData *data = value.second;
      NSError *error = nil;
      NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                       options:0
                                                         error:&error];
      return array;
    }];
    
    RAC(self, users) = [sigMapped deliverOn:RACScheduler.mainThreadScheduler];
    
    
//    RAC(self,users) = [[[NSURLConnection rac_sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.github.com/users"]]] map:^id(RACTuple *value) {
//      
//      NSData *data = value.second;
//      NSError *error = nil;
//      NSArray *array = [NSJSONSerialization JSONObjectWithData:data
//                                                       options:0
//                                                         error:&error];
//      return array;
//    }] deliverOn:RACScheduler.mainThreadScheduler];
  }
  
  return self;
}

@end
