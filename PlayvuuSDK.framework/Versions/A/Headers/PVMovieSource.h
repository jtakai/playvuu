//
//  PVAVPlayerItemSource.h
//  PlayvuuSDK
//
//  Created by Brian Smith on 8/26/13.
//  Copyright (c) 2013 Brian Smith. All rights reserved.
//

#import <PlayvuuSDK/PlayvuuSDK.h>

@class PVMovieSource;


#define PLAYVUUMOVIESOURCE_STATUS_PLAYING 1 << 8
#define PLAYVUUMOVIESOURCE_STATUS_STOPPED 1 << 9

typedef enum
{
    PlayvuuMovieSourceStatusNone = 0,

    PlayvuuMovieSourceStatusPlaying = 1 | PLAYVUUMOVIESOURCE_STATUS_PLAYING,

    PlayvuuMovieSourceStatusReadyToPlay = 1 | PLAYVUUMOVIESOURCE_STATUS_STOPPED,
    PlayvuuMovieSourceStatusPaused = 2 | PLAYVUUMOVIESOURCE_STATUS_STOPPED,
    PlayvuuMovieSourceStatusAtEnd = 3 | PLAYVUUMOVIESOURCE_STATUS_STOPPED,
    
    PlayvuuMovieSourceStatusError = 9999
    
} PlayvuuMovieSourceStatus;

@protocol PVMovieSourceDelegate

- (void) pvMovieSource:(PVMovieSource *)source statusChanged:(PlayvuuMovieSourceStatus)status;
- (void) pvMovieSource:(PVMovieSource *)source timeChanged:(CMTime)time;

@end


@interface PVMovieSource : PVSource

@property (nonatomic,weak) id<PVMovieSourceDelegate> movieDelegate;
@property (nonatomic,strong,readonly) NSURL * url;

@property (nonatomic,readonly) PlayvuuMovieSourceStatus movieStatus;
@property (nonatomic,readonly) CMTime currentMovieTime;
@property (nonatomic,readonly) CMTime movieDuration;
@property (nonatomic,readonly) CGAffineTransform transformation;

- (id) initWithURL:(NSURL *)url;

- (void) play;
- (void) pause;
- (void) seekToTime:(CMTime)time;

@end
