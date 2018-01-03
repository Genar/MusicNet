//
//  ConnectionManager.m
//  MusicNet
//
//  Created by Genaro Codina Reverter on 02/01/2018.
//  Copyright © 2018 Genaro Codina Reverter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionManager.h"
#import "MusicItem.h"

#define kBasePathURL @"https://itunes.apple.com/"
#define kBasePathSearchURL kBasePathURL @"search?term=%@&limit=%ld"
#define kBackgroundQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#pragma mark - iVars section
@interface ConnectionManager()
{
    NSMutableArray* _musicItems;
    NSURLSession* _imageSession;
    NSOperationQueue* _netOperationQueue;
}
@end

@implementation ConnectionManager

@synthesize musicItems = _musicItems;
@synthesize imageSession = _imageSession;
@synthesize netOperationQueue = _netOperationQueue;

#pragma mark - Init method
+ (id)sharedInstance {
    
    static ConnectionManager *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - Private section
- (id)init {
    
    self = [super init];
    if (self) {
        
        _musicItems = [NSMutableArray array];
        
        _netOperationQueue = [[NSOperationQueue alloc] init];
        _netOperationQueue.maxConcurrentOperationCount = 3;
        _netOperationQueue.name = @"Network Operations Queue";
        
        NSURLSessionConfiguration *sessionImageConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionImageConfiguration.timeoutIntervalForResource = 6;
        sessionImageConfiguration.HTTPMaximumConnectionsPerHost = 2;
        sessionImageConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
        
        _imageSession = [NSURLSession sessionWithConfiguration:sessionImageConfiguration delegate:nil delegateQueue:_netOperationQueue];
    }
    
    return self;
}

- (void)logDictionary:(NSDictionary*) dictionary {
    
    NSDictionary *values = dictionary;
    [values enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent
                                    usingBlock:^(id key, id object, BOOL *stop){
                                        NSLog(@"%@ = %@", key, object);
                                    }];
}

#pragma mark - Public Section

- (void)searchWithString:(NSString*)toSearch withLimit:(unsigned long)limit {
    
    dispatch_async(kBackgroundQueue, ^{
        NSString* fullUrlString = [NSString stringWithFormat:kBasePathSearchURL, toSearch, limit];
        NSURL* fullUrl = [NSURL URLWithString:fullUrlString];
        NSData* data = [NSData dataWithContentsOfURL:fullUrl];
        if (data != nil) {
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary* userInfo = @{kConnectionManagerMusicListNotificationKey: self.musicItems};
                [[NSNotificationCenter defaultCenter] postNotificationName:kConnectionManagerMusicListNotification object:nil userInfo:userInfo];
            });
        }
    });
}

- (void)fetchedData:(NSData*)responseData {
    
    self.musicItems = [NSMutableArray new];
    NSError* error;
    id json = [NSJSONSerialization
               JSONObjectWithData:responseData
               options:kNilOptions
               error:&error];
    bool isJsonObj = [NSJSONSerialization isValidJSONObject:(id)json];
    //NSLog(@"Is JSON object:%d", isJsonObj);
    
    if (isJsonObj) {
        if ([json isKindOfClass:[NSArray class]]) {
            //NSLog(@"Is NSArray class");
        } else if ([json isKindOfClass:[NSDictionary class]]) {
            //[self logDictionary:(NSDictionary*)json];
            NSMutableArray* results = json[@"results"];
            [results enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
                MusicItem* musicItem = [[MusicItem alloc] initWithDictionary:object];
                [self.musicItems addObject:musicItem];
                //NSLog(@"Music Item:%@", musicItem.collectionCensoredName);
            }];
        }
    }
}

- (NSURLSessionTask*)imageWithURL:(NSURL*)url
                           success:(void (^)(UIImage* image))success
                           failure:(void (^)(NSError* error))failure {
    
    NSURLSessionTask* task = [_imageSession dataTaskWithURL:url completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (error)
            return failure(error);
        if (response)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *image = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (image) {
                        success(image);
                    }
                });
            });
    }];
    
    [task resume];
    return task;
}

@end
