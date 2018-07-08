//
//  NSDate+Server.m
//  Cheryz-iOS
//
//  Created by Viktor Todorov on 12/21/16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "NSDate+Server.h"

@implementation NSDate (Server)
-(double)serverDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *dateString = [dateFormatter stringFromDate:[self dateWithZeroSeconds:self]];
    NSDate* newDate = [dateFormatter dateFromString:dateString];
    
    return [newDate timeIntervalSince1970]*1000;
}
+(double)getOffset {
    NSDate* currentDate = [NSDate date];
//    double serverDateDouble = [[NSDate date] serverDate];
//    double currentDateDouble = [[NSDate date] timeIntervalSince1970]*1000;
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSTimeZone *destinationTimeZone = [NSTimeZone defaultTimeZone];
    
    NSInteger sourceSeconds = [timeZone secondsFromGMTForDate:currentDate];
    NSInteger destinationSeconds = [destinationTimeZone secondsFromGMTForDate:currentDate];
    NSTimeInterval interval = destinationSeconds - sourceSeconds;
    
    return interval*1000;
}
+(NSDate*)dateFromServerFormat:(double)date {
    if(date==0) return nil;
    NSDate* aDate = [NSDate dateWithTimeIntervalSince1970:date/1000.];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *dateString = [dateFormatter stringFromDate:aDate];
    NSDate* newDate = [dateFormatter dateFromString:dateString];
    
    return newDate;

}
- (NSDate *)dateWithZeroSeconds:(NSDate *)date
{
    NSTimeInterval time = floor([date timeIntervalSinceReferenceDate] / 60.0) * 60.0;
    return  [NSDate dateWithTimeIntervalSinceReferenceDate:time];
}
-(double)serverDateMorning {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *morningStart = [calendar dateFromComponents:components];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:morningStart];
    NSDate* newDate = [dateFormatter dateFromString:dateString];
    
    return [newDate timeIntervalSince1970]*1000;
}
-(double)serverDateNight {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    NSDate *nightEnd = [calendar dateFromComponents:components];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSString *dateString = [dateFormatter stringFromDate:nightEnd];
    NSDate* newDate = [dateFormatter dateFromString:dateString];
    
    return [newDate timeIntervalSince1970]*1000+999;
}
-(NSDate*)endOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    NSDate *nightEnd = [calendar dateFromComponents:components];

    return nightEnd;
}
+(NSString*)stringFromDate:(NSDate*)aDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:aDate];
    return dateString;
}
+(NSString*)stringFromDateWithTime:(NSDate*)aDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:aDate];
    return dateString;
}
+(NSString*)stringForCreditCardFromDate:(NSDate*)aDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateFormat:@"MM-yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:aDate];
    return dateString;
}
-(NSInteger)getMonthFromDate {

    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self]; // Get necessary date components
    
    return [components month];
    
}
-(NSInteger)getYearFromDate {

    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self]; // Get necessary date components
    
    return [components year];
    
}
@end
