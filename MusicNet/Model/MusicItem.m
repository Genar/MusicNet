//
//  MusicItem.m
//  MusicNet
//
//  Created by Genaro Codina Reverter on 29/12/2017.
//  Copyright © 2017 Genaro Codina Reverter. All rights reserved.
//

#import "MusicItem.h"

@implementation MusicItem

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        // MusicItem must not have a field named "id",
        // in order to avoid clashing the field "id" which comes
        // from NSObject.
        // In case the JSON string contains a field named "id"
        // then setup an item from MusicItem, whose name
        // must be different from "id", to a suitable value.
        // For example, we can create in MusicItem a field called "itemId"
        // and then in this section of the code we can set up:
        // self.itemId = value;
    }
    if([key isEqualToString:@"description"]) {
        // MusicItem must not have a field named "description",
        // in order to avoid clashing the field "description" which comes
        // from NSObject.
        // In case the JSON string contains a field named "description"
        // then setup an item from MusicItem, whose name
        // must be different from "description", to a suitable value.
        // For example, we can create in MusicItem a field called "itemDescription"
        // and then in this section of the code we can set up:
        // self.itemDescription = value;
    } else {
        // Comment the following two lines of code
        // in a production environment. The following
        // two lines of code are useful in case we want
        // the app to crash in order to detect "key/value"
        // pairs in the JSON which have not declared as a
        // property in MusicItem.h
//        NSLog(@"-----------KEY:%@", key);
//        [super setValue:value forKey:key];
    }
}

@end
