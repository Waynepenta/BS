//
//  customRegistBtn.m
//  BS
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "customRegistBtn.h"

@implementation customRegistBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{

    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    

    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
  
}



@end
