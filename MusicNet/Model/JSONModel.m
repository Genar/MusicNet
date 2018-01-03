//
//  JSONModel.m
//  MusicNet
//
//  Created by Genaro Codina Reverter on 29/12/2017.
//  Copyright © 2017 Genaro Codina Reverter. All rights reserved.
//

#import "JSONModel.h"

@implementation JSONModel

- (instancetype) initWithDictionary:(NSMutableDictionary*) jsonObject
{
    if((self = [super init]))
    {
        [self setValuesForKeysWithDictionary:jsonObject];
    }
    return self;
}

- (BOOL) allowsKeyedCoding
{
    return YES;
}

- (instancetype) initWithCoder:(NSCoder *)decoder
{
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    // Do nothing.
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone
{
    // Subclass implementation should do a deep mutable copy
    // this class doesn't have any ivars so this is ok
    JSONModel *newModel = [[JSONModel allocWithZone:zone] init];
    return newModel;
}

- (instancetype) copyWithZone:(NSZone *)zone
{
    // Subclass implementation should do a deep mutable copy
    // this class doesn't have any ivars so this is ok
    JSONModel *newModel = [[JSONModel allocWithZone:zone] init];
    return newModel;
}

- (instancetype)valueForUndefinedKey:(NSString *)key
{
    // Subclass implementation should provide correct key value mappings for custom keys
    NSLog(@"Undefined Key: %@", key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // Subclass implementation should set the correct key value mappings for custom keys
    NSLog(@"Undefined Key: %@", key);
}

@end
