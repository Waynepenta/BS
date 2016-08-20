//
//  MeButton.m
//  BS
//
//  Created by lanou on 16/8/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MeButton.h"
#import <SDWebImage/UIButton+WebCache.h>


@implementation MeButton



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
       
        
    }
    

    return self;

}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.x = 0;
    self.imageView.y = self.height * 0.2;
    self.imageView.width = self.width * 0.3;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX  = self.width * 0.5;
    
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

- (void)setModel:(MeModel *)model
{
    _model = model;
    
    [self setTitle:model.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal];
 
}











/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
