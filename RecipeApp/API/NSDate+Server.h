//
//  NSDate+Server.h
//  Cheryz-iOS
//
//  Created by Viktor Todorov on 12/21/16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Server)
-(double)serverDate;
+(NSDate*)dateFromServerFormat:(double)date;
-(double)serverDateMorning;
-(double)serverDateNight;
+(double)getOffset;
-(NSDate*)endOfDay;
+(NSString*)stringFromDate:(NSDate*)aDate;
+(NSString*)stringFromDateWithTime:(NSDate*)aDate;
-(NSInteger)getMonthFromDate;
-(NSInteger)getYearFromDate;
+(NSString*)stringForCreditCardFromDate:(NSDate*)aDate;
@end
