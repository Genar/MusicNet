//
//  UIImageView+Connection.h
//  MusicNet
//
//  Created by Genaro Codina Reverter on 02/01/2018.
//  Copyright © 2018 Genaro Codina Reverter. All rights reserved.
//

#import <UIKit/UIKit.h>

static char const * const taskKey = "UIImageViewTaskKey";

@interface UIImageView (Connection)

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)cancelDownload;

@end
