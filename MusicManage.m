//
//  MusicManage.m
//  BS
//
//  Created by lanou on 16/8/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MusicManage.h"
static MusicManage *_musicmanage = nil;
@implementation MusicManage

+ (instancetype)shareMusicPlay
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _musicmanage = [[MusicManage alloc] init];
    });

    return _musicmanage;
}

- (instancetype)init
{
    if (self = [super init]) {
        _player = [[AVPlayer alloc] init];
    }

    return self;
}

- (void)play
{
    [_player play];

    _isPlay = YES;
    
}

- (void)pause
{
    [_player pause];

    _isPlay = NO;
}

- (void)loadWithUrlString:(NSString *)urlstring
{
    self.item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlstring]];
    [self.player replaceCurrentItemWithPlayerItem:_item];
    
    [self play];
    
    

}
- (void)musciPlayAndPause
{
    if (_isPlay == YES) {
        [self pause];
    }else{
    
        [self play];
    }

}








@end
