//
//  NSString+CustomDate.h
//  MusicNet
//
//  Created by Genaro Codina Reverter on 02/01/2018.
//  Copyright © 2018 Genaro Codina Reverter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CustomDate)

- (NSString*)dateInPlainText:(NSString*)dateIn
             formatInputDate:(NSString*)formatDateIn
            formatOutputDate:(NSString*)formatDateOut;

@end
