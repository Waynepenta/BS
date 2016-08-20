//
//  RecommendCategoryTableViewCell.m
//  BS
//
//  Created by lanou on 16/8/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RecommendCategoryTableViewCell.h"

@interface RecommendCategoryTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *selectBg;



@end


@implementation RecommendCategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2*self.textLabel.y;
    


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectBg.hidden = !selected;
    self.textLabel.textColor = selected ? [UIColor colorWithRed:219/255.0 green:21/255.0 blue:26/255.0 alpha:1.0] : [UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1.0];
    
   
    
}

@end
