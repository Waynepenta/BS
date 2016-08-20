//
//  pictureView.m
//  BS
//
//  Created by lanou on 16/8/10.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "pictureView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ShowPicViewController.h"
#import "DALabeledCircularProgressView.h"
#import "BSTabBarController.h"
#import "essenceViewController.h"



@interface pictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *GifImg;

@property (weak, nonatomic) IBOutlet UIButton *seeBtn;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (nonatomic,strong) DALabeledCircularProgressView *progressView1;



@end


@implementation pictureView



+ (instancetype)pictureV
{

    return [[[NSBundle mainBundle] loadNibNamed:@"pictureView" owner:nil options:nil] lastObject];

}

- (void)awakeFromNib
{
    
    self.autoresizingMask = UIViewAutoresizingNone;
//    self.imageV.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sent)];
//    [self.imageV addGestureRecognizer:tap];
//    
    

}

//- (void)sent
//{
//  
//    
//
//}


- (void)setTopic:(TopicModel *)topic
{
    _topic = topic;
    
  
   
    
    if (topic.isBigPic) {
        self.seeBtn.hidden = NO;
       
//        self.progressView.hidden = YES;
        self.progressView.hidden = YES;
        
        self.imageV.contentMode = UIViewContentModeScaleAspectFit;
        
        
        
        
    }else{
        
        self.seeBtn.hidden = YES;
        self.imageV.contentMode = UIViewContentModeScaleToFill;
        
      
        
    }
    
    
    NSString *str = topic.image0.pathExtension;
   
  
    self.GifImg.hidden = ![str.lowercaseString isEqualToString:@"gif"];
    
    [self.progressView setProgress:topic.progressVaule animated:NO];
    
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        
        topic.progressVaule = 1.0 * receivedSize / expectedSize;
        
        
        
        [self.progressView setProgress:topic.progressVaule animated:NO];
        
        self.progressView.roundedCorners = 2;
        
        //        self.progressView.progressLabel.text = @"1111";
        //        self.progressView.progressLabel.textColor = [UIColor whiteColor];
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        
        
        self.progressView.hidden = YES;
        self.bgImg.hidden = NO;
        
    }];


}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
