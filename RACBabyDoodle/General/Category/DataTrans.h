//
//  DataTrans.h
//  RACBabyDoodle
//
//  Created by mengqian on 17/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTrans : NSObject

// 各种验证
+ (BOOL)isValidateEmail:(NSString *)email;
+ (BOOL)isValidateMobile:(NSString *)mobileString;
+ (BOOL)isValidateLicenseNumber:(NSString*)licenseNumber;
+ (BOOL)isValidatePassword:(NSString*)password;


// 时间日期格式转换
+ (NSDate *)dateFromNSDatetimeStr:(NSString *)dateStr;
+ (NSDate *)dateFromNSDateStr:(NSString *)dateStr;
+ (NSDate *)dateFromUnixTimeStr:(NSString *)unixTimeStr;
+ (NSString *)dateStringFromDate:(NSDate *)date;
+ (NSString *)dateStringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat;
+ (NSNumber *)dateNumberFromNSDate:(NSDate *)date;
+ (NSString *)dateTimeStringFromDate:(NSDate *)dateTime;

// ISO8601格式的时间转换
+ (NSString *)strFromISO8601:(NSDate *) date;
+ (NSDate *)dateFromISO8601:(NSString *) str;


// 非空类型
+ (NSString *)noNullStringObj:(id)jsonData byName:(NSString *)name;
+ (NSString *)noNullStringObj:(id)jsonData;
+ (NSData *)noNullDataObj:(id)jsonData;
+ (NSNumber *)noNullBoolObj:(id)jsonData;
+ (NSNumber *)noNullIntegerObj:(id)jsonData;
+ (NSDate *)noNullDateObj:(id)jsonData;

// 从color 生成image
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
