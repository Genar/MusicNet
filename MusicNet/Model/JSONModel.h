//
//  JSONModel.h
//  MusicNet
//
//  Created by Genaro Codina Reverter on 29/12/2017.
//  Copyright © 2017 Genaro Codina Reverter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONModel : NSObject <NSCoding, NSCopying, NSMutableCopying> {
    
}

- (instancetype) initWithDictionary:(NSMutableDictionary*) jsonObject;

@end

