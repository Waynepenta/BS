//
//  pushView.m
//  BS
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "pushView.h"

@implementation pushView
+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        pushView *guideView = [pushView guideView];
        
        guideView.frame = window.bounds;
        
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    

    
    
    
    




}

+ (instancetype)guideView{



    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];


}
- (IBAction)Action:(id)sender {
    
    
    [self removeFromSuperview];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
