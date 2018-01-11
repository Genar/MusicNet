//
//  SearchMusicViewController.h
//  MusicNet
//
//  Created by Genaro Codina Reverter on 02/01/2018.
//  Copyright © 2018 Genaro Codina Reverter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchMusicViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;
@property (weak, nonatomic) IBOutlet UITableView* foundItemsTableView;

@property(nonatomic, strong) NSArray* musicItems;

@end
