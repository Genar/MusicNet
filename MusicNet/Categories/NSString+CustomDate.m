//
//  NSString+CustomDate.m
//  MusicNet
//
//  Created by Genaro Codina Reverter on 02/01/2018.
//  Copyright © 2018 Genaro Codina Reverter. All rights reserved.
//

#import "NSString+CustomDate.h"

@implementation NSString (CustomDate)

- (NSString*)dateInPlainText:(NSString*)dateIn
             formatInputDate:(NSString*)formatDateIn
            formatOutputDate:(NSString*)formatDateOut {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    [dateFormatter setDateFormat:formatDateIn];
    NSDate *date  = [dateFormatter dateFromString:dateIn];
    //[dateFormatter setDateFormat:@"EEE MMM d YYYY"];
    [dateFormatter setDateFormat:formatDateOut];
    NSString *newDate = [dateFormatter stringFromDate:date];
    
    return newDate;
}

@end
