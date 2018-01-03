//
//  PlayViewController.m
//  MusicNet
//
//  Created by Genaro Codina Reverter on 02/01/2018.
//  Copyright © 2018 Genaro Codina Reverter. All rights reserved.
//

#import "PlayViewController.h"
#import "UIImageView+Connection.h"
#import "NSString+CustomDate.h"

@interface PlayViewController () {
    
    MusicItem* musicItem;
}
@end

@implementation PlayViewController

static NSString* kPreviousKey = @"previous";
static NSString* kNextKey = @"next";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpButtonsLabels];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setUpMedia];
}

- (void)setUpMedia {
    
    musicItem = [self.musicItems objectAtIndex:self.indexPath.row];
    self.songLabel.text = musicItem.trackName;
    self.artistLabel.text = musicItem.artistName;
    self.albumLabel.text = musicItem.collectionName;
    self.dateLabel.text = [musicItem.releaseDate dateInPlainText:musicItem.releaseDate
                                                 formatInputDate:@"yyyy-MM-dd'T'HH:mm:ss'Z'"
                                                formatOutputDate:@"EEE MMM d YYYY"];
    self.genreLabel.text = musicItem.primaryGenreName;
    UIImage* placeholder = [UIImage imageNamed:@"user"];
    NSURL *urlImage = [NSURL URLWithString:musicItem.artworkUrl100];
    [self.artistImageView setImageWithURL:urlImage placeholderImage:placeholder];
    NSURL *urlPreview = [NSURL URLWithString:musicItem.previewUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlPreview];
    [self.artistWebView loadRequest:request];
}

#pragma mark - Actions

- (IBAction)previousButtonPressed:(UIButton *)sender {
    
    if (self.indexPath.row > 0) {
        self.indexPath = [NSIndexPath indexPathForItem:self.indexPath.row - 1 inSection:0];
        [self setUpMedia];
    } else if (self.indexPath.row == 0) {
        self.indexPath = [NSIndexPath indexPathForItem:self.musicItems.count - 1 inSection:0];
        [self setUpMedia];
    }
}

- (IBAction)nextButtonPressed:(UIButton *)sender {
    
    if (self.indexPath.row < self.musicItems.count - 1) {
        self.indexPath = [NSIndexPath indexPathForItem:self.indexPath.row + 1 inSection:0];
        [self setUpMedia];
    } else if (self.indexPath.row == self.musicItems.count - 1) {
        self.indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self setUpMedia];
    }
}

- (IBAction)onWhatsappPressed:(UIButton *)sender {
    
    NSString* whatsUpString = [NSString stringWithFormat:@"whatsapp://send?text=%@", musicItem.trackViewUrl];
    [self sendMessageWithString:whatsUpString];
}

- (IBAction)onLinePressed:(UIButton *)sender {
    
    NSString* lineString = [NSString stringWithFormat:@"line://msg/text/%@", musicItem.trackViewUrl];
    [self sendMessageWithString:lineString];
}

- (IBAction)onMessengerPressed:(UIButton *)sender {
    
    NSString* messengerString = [NSString stringWithFormat:@"fb-messenger://share?link=%@", musicItem.trackViewUrl];
    [self sendMessageWithString:messengerString];
}

- (IBAction)onMessagePressed:(UIButton *)sender {
    
    NSString* messageString = [NSString stringWithFormat:@"sms:&body=%@", musicItem.trackViewUrl];
    [self sendMessageWithString:messageString];
}

#pragma mark - Private methods

- (void)sendMessageWithString:(NSString*)urlString {
    
    NSURL* url = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

- (void)setUpButtonsLabels {
    
    NSString* previousText = [NSString stringWithFormat:@"<< %@", NSLocalizedString(kPreviousKey, "")];
    NSString* nextText = [NSString stringWithFormat:@"%@ >>", NSLocalizedString(kNextKey, "")];
    [self.previousButton setTitle: [NSString stringWithFormat:@"%@", previousText] forState:UIControlStateNormal];
    [self.nextButton setTitle: [NSString stringWithFormat:@"%@", nextText] forState:UIControlStateNormal];
}
@end
