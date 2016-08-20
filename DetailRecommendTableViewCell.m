//
//  DetailRecommendTableViewCell.m
//  BS
//
//  Created by lanou on 16/8/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DetailRecommendTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation DetailRecommendTableViewCell

- (void)setValueWithModel:(recommendDetail *)model
{
    self.detailScreenLabel.text = model.screen_name;
    
    self.detailFansLabel.text = [NSString stringWithFormat:@"%ld人关注",model.fans_count];
    
    [self.detailImage sd_setImageWithURL:[NSURL URLWithString:model.header] placeholderImage:nil];


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
