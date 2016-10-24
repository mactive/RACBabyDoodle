//
//  DoodleViewModel.h
//  RACBabyDoodle
//
//  Created by mengqian on 4/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface DoodleViewModel : NSObject

- (instancetype) initWithDict:(NSDictionary *)dict;

@property(nonatomic, readonly) RACCommand *loadDoodleCommand;


@property(nonatomic, readonly) NSString *guid;
@property(nonatomic, readonly) NSString *doodleId;
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSString *zhName;
@property(nonatomic, readonly) NSArray *tags;
@property(nonatomic, readonly) NSString *packageZip;
@property(nonatomic, readonly) NSString *cover;
@property(nonatomic, readonly) UIColor *color;

@property(nonatomic, readonly) NSDate *createAt;
@property(nonatomic, readonly) NSDate *updateAt;

@property(nonatomic, readonly) NSString *testString;
@property(nonatomic, readonly) CGRect viewFrame;


//"guid": "b6fd8811-575f-4c0c-8bee-bf4391d31757",
//"updateAt": "2015-08-17 04:51:30",
//"createAt": "2014-11-27 00:36:37",
//"tag": "laugh",
//"packageZip": "http://babydoodle.io/Idaho/Norvelt_6180.zip",
//"cover": "http://placehold.it/256x256",
//"name": "Key",
//"zhName": "Garrison",
//"doodleId": "570858f9c14954e756ef4570"

@end
