//
//  ConnectionManager.h
//  MusicNet
//
//  Created by Genaro Codina Reverter on 02/01/2018.
//  Copyright © 2018 Genaro Codina Reverter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - Section for Notification identifiers
#define kConnectionManagerMusicListNotification @"ConnectionManagerMusicListNotification"

#pragma mark - Section for Notification Keys identifiers
#define kConnectionManagerMusicListNotificationKey @"ConnectionManagerMusicListNotificationKey"

@interface ConnectionManager : NSObject

@property(nonatomic, strong) NSMutableArray* musicItems;
@property(nonatomic, strong) NSURLSession* imageSession;
@property(nonatomic, strong) NSOperationQueue* netOperationQueue;

+ (id)sharedInstance;

- (void)searchWithString:(NSString*)toSearch withLimit:(unsigned long)limit;

- (NSURLSessionTask *)imageWithURL:(NSURL *)url
                           success:(void (^)(UIImage* image))success
                           failure:(void (^)(NSError* error))failure;

@end

