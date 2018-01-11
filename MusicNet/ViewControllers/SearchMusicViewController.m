//
//  SearchMusicViewController.m
//  MusicNet
//
//  Created by Genaro Codina Reverter on 02/01/2018.
//  Copyright © 2018 Genaro Codina Reverter. All rights reserved.
//

#import "SearchMusicViewController.h"
#import "ConnectionManager.h"
#import "MusicItem.h"
#import "MusicItemTableViewCell.h"
#import "PlayViewController.h"

@interface SearchMusicViewController()
{
    NSIndexPath* selectedIndexPath;
}
@end

@implementation SearchMusicViewController

static NSString* kPlayMusicSegue = @"playMusicSegue";
static NSString* kMusicItemCellIdentifier = @"MusicItemCellId";

static NSString* kDurationKey= @"duration";
static NSString* kGenreKey= @"genre";
static NSString* kPriceKey= @"price";
static NSString* kSearchPlaceholder = @"search_placeholder";

static NSString* kTrackTimeMillis = @"trackTimeMillis";
static NSString* kPrimaryGenreName = @"primaryGenreName";
static NSString* kTrackPrice = @"trackPrice";

static unsigned long kNumberOfSongs = 200;

@synthesize foundItemsTableView;
@synthesize searchBar;
@synthesize musicItems;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupControls];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self registerNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self unregisterNotifications];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kPlayMusicSegue]) {
        PlayViewController* playViewController = (PlayViewController*)segue.destinationViewController;
        playViewController.delegatePassDataBack = self;
        playViewController.musicItems = self.musicItems;
        playViewController.indexPath = selectedIndexPath;
    }
}

#pragma mark - Notifications

- (void)registerNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recordingManagerNotification:)
                                                 name:kConnectionManagerMusicListNotification
                                               object:nil];
}

- (void)unregisterNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kConnectionManagerMusicListNotification
                                                  object:nil];
}

- (void)sortItems {
    
    if (self.searchBar.selectedScopeButtonIndex == 0) {
        NSSortDescriptor *valueDescriptor = [NSSortDescriptor sortDescriptorWithKey:kTrackTimeMillis ascending:YES];
        musicItems = [musicItems sortedArrayUsingDescriptors:@[valueDescriptor]];
    } else if (self.searchBar.selectedScopeButtonIndex == 1) {
        NSSortDescriptor *valueDescriptor = [NSSortDescriptor sortDescriptorWithKey:kPrimaryGenreName ascending:YES];
        musicItems = [musicItems sortedArrayUsingDescriptors:@[valueDescriptor]];
    } else if (self.searchBar.selectedScopeButtonIndex == 2) {
        NSSortDescriptor *valueDescriptor = [NSSortDescriptor sortDescriptorWithKey:kTrackPrice ascending:YES];
        musicItems = [musicItems sortedArrayUsingDescriptors:@[valueDescriptor]];
    }
}

#pragma mark - Notification Handles

-(void)recordingManagerNotification:(NSNotification *)notification {
    
    musicItems = notification.userInfo[kConnectionManagerMusicListNotificationKey];
    [musicItems enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        MusicItem* musicItem = (MusicItem*)object;
        NSLog(@"Collection Censored Name:%@", musicItem.trackCensoredName);
    }];
    [self sortItems];
    [foundItemsTableView reloadData];
}


#pragma mark - Table View delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [musicItems count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MusicItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMusicItemCellIdentifier];
    
    if (cell == nil) {
        cell = [[MusicItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMusicItemCellIdentifier];
    }
    
    MusicItem* musicItem = (MusicItem*)[musicItems objectAtIndex:indexPath.row];
    [cell render:musicItem];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:kPlayMusicSegue sender:self];
}

#pragma mark - SearchBar delegates

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText length] == 0) {
        [self.view endEditing:YES];
        self.musicItems = [NSArray new];
        [self.foundItemsTableView reloadData];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSMutableString* inputText = [searchBar.text mutableCopy];
    bool isTextEmpty = ([inputText length] == 0);
    bool isTextAllWhiteSpaces = (![[inputText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]);
    if ( !isTextEmpty || !isTextAllWhiteSpaces) {
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"  +" options:NSRegularExpressionCaseInsensitive error:&error];
        
        NSString* trimmedString = [regex stringByReplacingMatchesInString:inputText options:0 range:NSMakeRange(0, [inputText length]) withTemplate:@" "];
        NSString* stringWithPlus = [trimmedString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        [self.view endEditing:YES];
        [[ConnectionManager sharedInstance] searchWithString:stringWithPlus withLimit:kNumberOfSongs];
    }
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self.view endEditing:YES];
}

- (void) searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    
    [self sortItems];
    [self.foundItemsTableView reloadData];
}

#pragma mark - SendDataBack delegates
- (void)sendIndex:(NSIndexPath*) indexPath {
    
    selectedIndexPath = indexPath;
    [self.foundItemsTableView selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - Private methods
- (void)setupControls {
    
    NSString* duration = NSLocalizedString(kDurationKey, "");
    NSString* genre = NSLocalizedString(kGenreKey, "");
    NSString* price = NSLocalizedString(kPriceKey, "");
    NSString* searchTextPlaceholder = NSLocalizedString(kSearchPlaceholder, "");
    self.searchBar.scopeButtonTitles = @[duration, genre, price];
    self.searchBar.placeholder = searchTextPlaceholder;
}

@end
