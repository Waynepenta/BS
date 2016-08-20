//
//  TopicCell.m
//  BS
//
//  Created by lanou on 16/8/9.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicCell.h"
#import <UIImageView+WebCache.h>
#import "pictureView.h"
#import "TopicUserModel.h"
#import "TopicCommentModel.h"
#import "CustomVoiceView.h"
#import "CustomVedio.h"


@interface TopicCell ()
@property (nonatomic,weak) pictureView *pictureV;
@property (weak, nonatomic) IBOutlet UILabel *context;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (nonatomic,weak) CustomVoiceView *voiceView;
@property (nonatomic,weak) CustomVedio *vedioView;
@end



@implementation TopicCell

- (pictureView *)pictureV
{
    if (!_pictureV) {
       pictureView *pictureV = [pictureView pictureV];
        [self.contentView addSubview:pictureV];
        _pictureV = pictureV;
    }
    


    return _pictureV;
}

- (CustomVoiceView *)voiceView
{
    if (!_voiceView) {
      CustomVoiceView *voice = [CustomVoiceView voiceView];
        [self.contentView addSubview:voice];
        _voiceView = voice;
    }
    return _voiceView;
}

- (CustomVedio *)vedioView
{
    if (!_vedioView) {
        CustomVedio *vedioview = [CustomVedio vedioView];
//        vedioview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 40,400);
        [self.contentView addSubview:vedioview];
        _vedioView = vedioview;
    }
    return _vedioView;

}



- (void)setupVauleWithModel:(TopicModel *)model commentModel:(TopicCommentModel *)comModel
{
    self.model = model;

    [self.userImg sd_setImageWithURL:[NSURL URLWithString:model.profile_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.userImg.image = [image circleImage];
    }];
    self.userName.text = model.name;
    
    
    self.sina_V.hidden = !model.isSina_v;
    
    self.topcontext.text = model.text;
   
    //处理时间戳
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *creat = [fmt dateFromString:
                     model.create_time];
    
    if (creat.isThisYear) {
        
        if (creat.isToday) {
            
            NSDateComponents *cmps = [[NSDate date] deltaFrom:creat];
            
            if (cmps.hour >= 1) {
                self.creatTime.text = [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            }else if (cmps.minute >= 1){
            
                self.creatTime.text = [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            
            }else{
            
                self.creatTime.text = @"刚刚";
            }
          
      }else if (creat.isYesterday) {
        
            fmt.dateFormat = @"昨天 HH:mm:ss";
            
            self.creatTime.text = [fmt stringFromDate:creat];
        
        
        }else{
        
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            self.creatTime.text = [fmt stringFromDate:creat];
      
        }
        
    
    }else{
    
    
         self.creatTime.text = model.create_time;
    
    }
   
    
    
    if (model.ding > 10000) {
       [self.dingbtn setTitle:[NSString stringWithFormat:@"%ld万",model.ding / 10000] forState:UIControlStateNormal];
        
    }else{
    
        [self.dingbtn setTitle:[NSString stringWithFormat:@"%ld",model.ding] forState:UIControlStateNormal];
    
    }
    
    if (model.cai > 10000) {
        
         [self.caibtn setTitle:[NSString stringWithFormat:@"%ld万",model.cai / 10000] forState:UIControlStateNormal];
    }else{
    
         [self.caibtn setTitle:[NSString stringWithFormat:@"%ld",model.cai] forState:UIControlStateNormal];
    }
    
    
    if (model.repost > 10000){
    [self.respotbtn setTitle:[NSString stringWithFormat:@"%ld万",model.repost / 10000] forState:UIControlStateNormal];
    
    }else{
    
    
        [self.respotbtn setTitle:[NSString stringWithFormat:@"%ld",model.repost] forState:UIControlStateNormal];
    }
    
    if (model.comment > 10000){
        
        [self.comment setTitle:[NSString stringWithFormat:@"%ld万",model.comment / 10000] forState:UIControlStateNormal];
    
    
    }else{
    
        [self.comment setTitle:[NSString stringWithFormat:@"%ld",model.comment] forState:UIControlStateNormal];
    
    }
    
    if (model.type == 10) {
        [self.pictureV removeFromSuperview];
        self.pictureV = nil;
        
//       pictureView *pictureV1 = [pictureView pictureV];
//        [self.contentView addSubview:pictureV1];
        self.pictureV.topic = model;
        self.pictureV.frame = model.pictureF;
      
        self.pictureV.hidden = NO;
        
        self.vedioView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }else if (model.type == 31){
        [self.voiceView removeFromSuperview];
        self.voiceView = nil;
        self.voiceView.model = model;
        self.voiceView.frame = model.voiceF;
        self.voiceView.hidden = NO;
        self.pictureV.hidden = YES;
        self.vedioView.hidden = YES;
   
    }else if (model.type == 41){
    
        [self.vedioView removeFromSuperview];
        self.vedioView = nil;
        self.vedioView.model = model;
        self.vedioView.frame = model.vedioF;
        self.vedioView.hidden = NO;
        
        self.voiceView.hidden = YES;
        self.pictureV.hidden = YES;
    }else{
        
        self.voiceView.hidden = YES;
        self.vedioView.hidden = YES;
        self.pictureV.hidden = YES;
  
    }
    
    
  
    NSDictionary *dic = [model.top_cmt firstObject];
      self.commentView.hidden = YES;

    
    if (dic == nil) {

        return;
        
    }else{
        
        
            self.commentView.hidden = NO;
        
            self.context.text = [NSString stringWithFormat:@"%@ : %@",dic[@"user"][@"username"],dic[@"content"]];

    
        }

    }


- (void)awakeFromNib {
    [super awakeFromNib];
    
//    UIImageView *view1 = [[UIImageView alloc] init];
//    
//    UIImage *img =  [UIImage imageNamed:@"mainCellBackground"];
//    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    view1.image = img;
//    
//    self.backgroundView = view1;
    
    
    // Initialization code
}

- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height = self.model.cellHeight - margin;
//    frame.size.height  -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];

}


+ (instancetype)cell
{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
