//
//  MusicItemTableViewCell.m
//  MusicNet
//
//  Created by Genaro Codina Reverter on 02/01/2018.
//  Copyright © 2018 Genaro Codina Reverter. All rights reserved.
//

#import "MusicItemTableViewCell.h"
#import "UIImageView+Connection.h"
#import "NSString+CustomDate.h"

@implementation MusicItemTableViewCell

@synthesize artistImageView;
@synthesize songLabel;
@synthesize artistLabel;
@synthesize releaseDateLabel;
@synthesize genreLabel;
@synthesize albumLabel;
@synthesize durationLabel;
@synthesize priceLabel;

- (void) render:(MusicItem*)musicItem {
    
    self.songLabel.text = musicItem.trackName;
    self.artistLabel.text = musicItem.artistName;
    self.releaseDateLabel.text = [musicItem.releaseDate dateInPlainText:musicItem.releaseDate
                                                        formatInputDate:@"yyyy-MM-dd'T'HH:mm:ss'Z'"
                                                        formatOutputDate:@"EEE MMM d YYYY"];
    self.genreLabel.text = musicItem.primaryGenreName;
    self.albumLabel.text = musicItem.collectionName;
    int durationInSeconds = musicItem.trackTimeMillis / 1000;
    int minutes = durationInSeconds / 60;
    int seconds = durationInSeconds % 60;
    NSString* currency = musicItem.currency;
    self.durationLabel.text = [NSString stringWithFormat:@"%d' %d''", minutes, seconds];
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@", [musicItem.trackPrice stringValue], currency];
    NSString *imageUrlStr = musicItem.artworkUrl100;
    NSURL *url = [NSURL URLWithString:imageUrlStr];
    UIImage* placeholder = [UIImage imageNamed:@"user"];
    [self.artistImageView setImageWithURL:url placeholderImage:placeholder];
}

@end
