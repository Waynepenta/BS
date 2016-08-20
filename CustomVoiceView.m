//
//  CustomVoiceView.m
//  BS
//
//  Created by lanou on 16/8/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CustomVoiceView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MusicManage.h"

@interface CustomVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic,assign) BOOL isClick;

@property (weak, nonatomic) IBOutlet UIImageView *imagBg;
@property (nonatomic,copy) NSString *musicUrl;
@end


@implementation CustomVoiceView
+ (instancetype)voiceView
{

    return [[[NSBundle mainBundle] loadNibNamed:@"CustomVoiceView" owner:nil options:nil] lastObject];

}

- (void)awakeFromNib
{
    
    self.autoresizingMask = UIAccessibilityTraitNone;
   
}

- (void)setModel:(TopicModel *)model
{
    
    _model = model;
    
    [self.imagBg sd_setImageWithURL:[NSURL URLWithString:model.image0]];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%ld",model.playcount];
    
    NSInteger min = model.voicetime / 60;
    NSInteger sec = model.voicetime % 60;
    
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
 
}


- (IBAction)playAction:(id)sender {
    
  
    
     [[MusicManage shareMusicPlay] loadWithUrlString:self.model.voiceuri];
    
    if (![self.musicUrl isEqualToString:self.model.voiceuri]) {
      
        [self.playBtn setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];
    }
  
    if (self.isClick == NO) {
       
        [self.playBtn setImage:[UIImage imageNamed:@"play-voice-icon-3"] forState:UIControlStateNormal];
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"playButtonClick"] forState:UIControlStateNormal];
        self.musicUrl = self.model.voiceuri;
     
       
    }else{
        
        [self.playBtn setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];
        [[MusicManage shareMusicPlay] pause];
       
    }
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endPlay) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
   
    
      self.isClick = !self.isClick;
  
}

- (void)endPlay
{
    [self.playBtn setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
