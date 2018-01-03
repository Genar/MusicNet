//
//  MusicItemTableViewCell.h
//  MusicNet
//
//  Created by Genaro Codina Reverter on 02/01/2018.
//  Copyright © 2018 Genaro Codina Reverter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicItem.h"

@interface MusicItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *artistImageView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (void) render:(MusicItem*)musicItem;

@end
