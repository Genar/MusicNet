//
//  UIImageView+Connection.m
//  MusicNet
//
//  Created by Genaro Codina Reverter on 02/01/2018.
//  Copyright © 2018 Genaro Codina Reverter. All rights reserved.
//

#import "UIImageView+Connection.h"
#import "ConnectionManager.h"
#import <objc/runtime.h>

@interface UIImageView (ConnectionProperty)

@property(nonatomic, strong) NSURLSessionTask *task;

@end

@implementation UIImageView (NBNet)

- (NSURLSessionTask *)task {
    
    return objc_getAssociatedObject(self, &taskKey);
}

- (void)setTask:(NSURLSessionTask *)newTask {
    
    objc_setAssociatedObject(self,
                             &taskKey,
                             newTask,
                             OBJC_ASSOCIATION_COPY);
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    
    self.image = placeholder;
    ConnectionManager *connectionSharedInstance = [ConnectionManager sharedInstance];
    NSURLSessionTask *dTask = [connectionSharedInstance imageWithURL:url success:^(UIImage *image) {
        self.image = image;
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    self.task = dTask;
}

- (void)cancelDownload {
    
    [self.task cancel];
}

@end
