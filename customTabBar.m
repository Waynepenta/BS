//
//  customTabBar.m
//  BS
//
//  Created by lanou on 16/8/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "customTabBar.h"
#import "ShowBtnViewController.h"


@interface customTabBar ()
@property (nonatomic,weak) UIButton *publishButton;

@end

@implementation customTabBar


- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        
            [self addSubview:btn];
        
        self.publishButton = btn;
       
    }


    return  self;


}

- (void)action
{
    ShowBtnViewController *view1 = [[ShowBtnViewController alloc] init];
 
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:view1 animated:NO completion:nil];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    NSInteger index = 0;
  
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue; {
            
            CGFloat buttonX = buttonW * ((index > 1)?(index + 1): index);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            
            index++;
          
        }
        
    }

}












/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
