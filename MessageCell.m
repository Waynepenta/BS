//
//  MessageCell.m
//  BS
//
//  Created by lanou on 16/8/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MessageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MessageCell

- (void)setValueWithModel:(TopicCommentModel *)model
{
    
 
    self.userContext.text = model.content;
    
    self.likeCount.text = model.like_count;
  
    if (model.usermodel == nil) {
        return;
    }else{
      
        [self.profile_img sd_setImageWithURL:[NSURL URLWithString:model.usermodel.profile_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            self.profile_img.image = [image circleImage];
        }];
        
        
        if ([model.usermodel.sex isEqualToString:@"m"]) {
            //
            self.sexImg.image = [UIImage imageNamed:@"Profile_manIcon"];
        }else{
            
            self.sexImg.image = [UIImage imageNamed:@"Profile_womanIcon"];
        }
        
        self.nameLabel.text = model.usermodel.username;
    
    }
 
}




- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *view1 = [[UIImageView alloc] init];
    UIImage *img =  [UIImage imageNamed:@"mainCellBackground"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    view1.image = img;
    self.backgroundView = view1;
   
}

//显示自定义按钮 复制 拷贝等

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    return NO;
}


- (BOOL)canBecomeFirstResponder
{

    return  YES;
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
