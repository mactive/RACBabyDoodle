//
//  DataTrans.m
//  RACBabyDoodle
//
//  Created by mengqian on 17/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "DataTrans.h"

@implementation DataTrans

/////////////////////////////////////////////////////////
#pragma mark - no null
/////////////////////////////////////////////////////////

+(NSString *)noNullStringObj:(id)jsonData byName:(id)name
{
    id obj = [jsonData valueForKey:name];
    if (obj == nil) return @"";
    
    return [self convertNumberToStringIfNumber:obj];
}


+ (NSString *)noNullStringObj:(id)jsonData
{
    if (jsonData == nil){
        return @"";
    }else{
        return jsonData;
    }
}

+ (NSData *)noNullDataObj:(id)jsonData
{
    if (jsonData == nil){
        return [NSData data];
    }else{
        return jsonData;
    }
}

+ (NSNumber *)noNullBoolObj:(id)jsonData
{
    if ([jsonData boolValue] == NO){
        return [NSNumber numberWithBool:NO];
    }else{
        return [NSNumber numberWithBool:YES];
    }
}
+ (NSNumber *)noNullIntegerObj:(id)jsonData
{
    if (jsonData == nil){
        return [NSNumber numberWithInteger:0];
    }else{
        return jsonData;
    }
}

+ (NSDate *)noNullDateObj:(id)jsonData
{
    if (jsonData == nil){
        return [NSDate dateWithTimeIntervalSince1970:0];
    }else{
        return jsonData;
    }
}

+ (NSString *)convertNumberToStringIfNumber:(id)obj
{
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj stringValue];
    }
    return obj;
}


/////////////////////////////////////////////////////////
#pragma mark - NSDate
/////////////////////////////////////////////////////////

+ (NSDate *)dateFromNSDatetimeStr:(NSString *)dateStr
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:DATETIME_FORMATE];
    });
    
    return [dateFormatter dateFromString:dateStr];
}
+ (NSDate *)dateFromNSDateStr:(NSString *)dateStr
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:DATE_FORMATE];
    });
    
    return [dateFormatter dateFromString:dateStr];
}

+ (NSDate *)dateFromUnixTimeStr:(NSString *)unixTimeStr
{
    NSDate *result = [[NSDate alloc]init];
    long long unixTime = [unixTimeStr longLongValue];
    result = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)unixTime];
    return  result;
}

+ (NSString *)dateStringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMATE];
    if (date != nil) {
        if ([date isEqualToDate:[NSDate dateWithTimeIntervalSince1970:0]]) {
            return @"";
        }else{
            return [formatter stringFromDate:date];
        }
    }else{
        return @"";
    }
}

+ (NSString *)dateStringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    if (date != nil) {
        if ([date isEqualToDate:[NSDate dateWithTimeIntervalSince1970:0]]) {
            return @"";
        }else{
            return [formatter stringFromDate:date];
        }
    }else{
        return @"";
    }}


+ (NSNumber *)dateNumberFromNSDate:(NSDate *)date
{
    if (date != nil) {
        NSTimeInterval result = [date timeIntervalSince1970];
        return [NSNumber numberWithDouble:result];
    }else{
        return [NSNumber numberWithInteger:0];
    }
}

+ (NSString *)dateTimeStringFromDate:(NSDate *)dateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATETIME_FORMATE];
    return [formatter stringFromDate:dateTime];
}

/////////////////////////////////////////////////////////
#pragma mark - ISO8601 <-> NSDate
// 1994-11-05T08:15:30.333-05:00 corresponds to November 5, 1994, 8:15:30 am, US Eastern Standard Time.

// 1994-11-05T13:15:30Z corresponds to the same instant.
/////////////////////////////////////////////////////////


+ (NSString *) strFromISO8601:(NSDate *) date {
    NSDateFormatter* sISO8601 = [[NSDateFormatter alloc] init];
    if ([date isEqualToDate:[NSDate dateWithTimeIntervalSince1970:0]]) {
        return @"";
    }
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    int offset = [timeZone secondsFromGMT];
    
    NSMutableString *strFormat = [NSMutableString stringWithString:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    offset /= 60; //bring down to minutes
    if (offset == 0)
        [strFormat appendString:ISO_TIMEZONE_UTC_FORMAT];
    else
        [strFormat appendFormat:ISO_TIMEZONE_OFFSET_FORMAT, offset / 60, offset % 60];
    
    [sISO8601 setTimeStyle:NSDateFormatterFullStyle];
    [sISO8601 setDateFormat:strFormat];
    
    return [sISO8601 stringFromDate:date];
}

+ (NSDate *) dateFromISO8601:(NSString *) str {
    NSDateFormatter* sISO8601 = [[NSDateFormatter alloc] init];
    if (!StringHasValue(str)) {
        return [NSDate dateWithTimeIntervalSince1970:0];
    }
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    int offset = [timeZone secondsFromGMT];
    
    NSMutableString *strFormat = [NSMutableString stringWithString:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    offset /= 60; //bring down to minutes
    if (offset == 0){
        [strFormat appendString:ISO_TIMEZONE_UTC_FORMAT];
    }else{
        if ([str hasSuffix:@"Z"]) {
            strFormat = [NSMutableString stringWithString:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        }else{
            [strFormat appendFormat:ISO_TIMEZONE_OFFSET_FORMAT, offset / 60, offset % 60];
        }
    }
    
    [sISO8601 setTimeStyle:NSDateFormatterFullStyle];
    [sISO8601 setDateFormat:strFormat];
    
    NSDate *d = [sISO8601 dateFromString:str];
    return d;
    
}


@end
