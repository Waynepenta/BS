//
//  MusicManage.h
//  BS
//
//  Created by lanou on 16/8/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface MusicManage : NSObject
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,assign) BOOL isPlay;
@property (nonatomic,strong) AVPlayerItem *item;
+ (instancetype)shareMusicPlay;
- (void)play;
- (void)pause;
- (void)loadWithUrlString:(NSString *)urlstring;
- (void)musciPlayAndPause;
@end
