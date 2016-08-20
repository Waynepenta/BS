//
//  UIBarButtonItem+Exstension.m
//  BS
//
//  Created by lanou on 16/8/2.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "UIBarButtonItem+Exstension.h"

@implementation UIBarButtonItem (Exstension)
+ (instancetype)itemWithimage:(NSString *)image lightImage:(NSString *)lightImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:lightImage] forState:UIControlStateSelected];
    btn.size = btn.currentBackgroundImage.size;
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    return  [[self alloc]initWithCustomView:btn];
    
    
    
}
@end
