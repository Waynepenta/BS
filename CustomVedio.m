//
//  CustomVedio.m
//  BS
//
//  Created by lanou on 16/8/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CustomVedio.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>

@interface CustomVedio ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *vedioTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageBg;

@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerItem *item;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic,assign) BOOL isClick;


@end


@implementation CustomVedio
+ (instancetype)vedioView
{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}
- (void)awakeFromNib
{
    
    self.autoresizingMask = UIAccessibilityTraitNone;
    
}


- (void)setModel:(TopicModel *)model
{
    _model = model;
    
    [self.imageBg sd_setImageWithURL:[NSURL URLWithString:model.image0]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%ld",model.playcount];
    NSInteger min = model.videotime / 60;
    NSInteger sec = model.videotime % 60;
    self.vedioTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:model.videouri]];
    
    self.player = [[AVPlayer alloc] init];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame = CGRectMake(0, -model.vedioF.origin.y, [UIScreen mainScreen].bounds.size.width - 40, model.cellHeight);
    
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.imageBg.layer addSublayer:layer];
 
}


- (IBAction)playClick:(id)sender {
    
    UIButton *btn = sender;
    
    if (self.isClick == NO) {
        
        [self.player play];
        
        [btn setImage:nil forState:UIControlStateNormal];
        
    }else{
   
        [self.player pause];
        [btn setImage:[UIImage imageNamed:@"video-play.png"] forState:UIControlStateNormal];
    }
  
    self.isClick = !self.isClick;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
