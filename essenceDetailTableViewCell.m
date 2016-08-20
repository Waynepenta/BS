//
//  essenceDetailTableViewCell.m
//  BS
//
//  Created by lanou on 16/8/5.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "essenceDetailTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation essenceDetailTableViewCell

- (void)setValueWithData:(essenceDetailModel *)model
{
   
    
    self.essenceDetailTitle.text = model.theme_name;
//    self.essenceDetailCount.text = [NSString stringWithFormat:@"%ld",model.sub_number];
    [self.essenceDetailImage sd_setImageWithURL:[NSURL URLWithString:model.image_list]];

    NSString *str = nil;
    
    if (model.sub_number < 10000) {
        
        str = [NSString stringWithFormat:@"%ld人订阅",model.sub_number];
    }else{
    
    
        str = [NSString stringWithFormat:@"%.1f万人订阅",model.sub_number / 10000.0];
    }
    
    self.essenceDetailCount.text = str;
    
    
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
