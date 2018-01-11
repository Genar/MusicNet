//
//  MusicItem.h
//  MusicNet
//
//  Created by Genaro Codina Reverter on 29/12/2017.
//  Copyright © 2017 Genaro Codina Reverter. All rights reserved.
//


#import "JSONModel.h"

@interface MusicItem : JSONModel

@property (nonatomic, strong) NSString* wrapperType;
@property (nonatomic, strong) NSString* kind;
@property (nonatomic, assign) int artistId;
@property (nonatomic, assign) int collectionId;
@property (nonatomic, assign) int trackId;
@property (nonatomic, strong) NSString* artistName;
@property (nonatomic, strong) NSString* collectionName;
@property (nonatomic, strong) NSString* trackName;
@property (nonatomic, strong) NSString* collectionCensoredName;
@property (nonatomic, strong) NSString* trackCensoredName;
@property (nonatomic, strong) NSString* collectionArtistName;
@property (nonatomic, strong) NSString* artistViewUrl;
@property (nonatomic, strong) NSString* collectionViewUrl;
@property (nonatomic, strong) NSString* trackViewUrl;
@property (nonatomic, strong) NSString* previewUrl;
@property (nonatomic, strong) NSString* artworkUrl30;
@property (nonatomic, strong) NSString* artworkUrl60;
@property (nonatomic, strong) NSString* artworkUrl100;
@property (nonatomic, strong) NSDecimalNumber* collectionPrice;
@property (nonatomic, strong) NSDecimalNumber* trackPrice;
@property (nonatomic, strong) NSDecimalNumber* trackRentalPrice;
@property (nonatomic, strong) NSDecimalNumber* collectionHdPrice;
@property (nonatomic, strong) NSDecimalNumber* trackHdPrice;
@property (nonatomic, strong) NSDecimalNumber* trackHdRentalPrice;
@property (nonatomic, strong) NSString* releaseDate;
@property (nonatomic, strong) NSString* collectionExplicitness;
@property (nonatomic, strong) NSString* trackExplicitness;
@property (nonatomic, assign) int discCount;
@property (nonatomic, assign) int discNumber;
@property (nonatomic, assign) int trackCount;
@property (nonatomic, assign) int trackNumber;
@property (nonatomic, assign) int trackTimeMillis;
@property (nonatomic, strong) NSString* country;
@property (nonatomic, strong) NSString* primaryGenreName;
@property (nonatomic, strong) NSString* currency;
@property (nonatomic, strong) NSString* contentAdvisoryRating;
@property (nonatomic, assign) bool isStreamable;
@property (nonatomic, assign) bool hasITunesExtras;
@property (nonatomic, strong) NSString* longDescription;
@property (nonatomic, strong) NSString* collectionArtistViewUrl;
@property (nonatomic, assign) int collectionArtistId;
@property (nonatomic, strong) NSString* shortDescription;
@property (nonatomic, strong) NSString* artistType;
@property (nonatomic, strong) NSString* artistLinkUrl;
@property (nonatomic, assign) int amgArtistId;
@property (nonatomic, assign) int primaryGenreId;
@property (nonatomic, strong) NSString* feedUrl;
@property (nonatomic, strong) NSString* artworkUrl600;
@property (nonatomic, strong) NSArray* genreIds;
@property (nonatomic, strong) NSArray* genres;
@property (nonatomic, strong) NSString* copyright;

@end

