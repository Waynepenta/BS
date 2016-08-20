//
//  MeTableViewCell.m
//  BS
//
//  Created by lanou on 16/8/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MeTableViewCell.h"

@implementation MeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
      self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *view1 = [[UIImageView alloc] init];
      
        view1.image =  [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = view1;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        
        
        
    }



    return  self;
}

- (void)layoutSubviews
{
      [super layoutSubviews];
    
    if (self.imageView.image == nil) {
        return;
    }
    
    self.imageView.width = 30;
    self.imageView.height = 30;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
   
   
}



@end
