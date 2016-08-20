//
//  ShowBtnViewController.m
//  BS
//
//  Created by lanou on 16/8/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ShowBtnViewController.h"
#import "customRegistBtn.h"
#import "sentMessageViewController.h"
#import "customNavigationController.h"
#import "POP.h"

@interface ShowBtnViewController ()

@end

@implementation ShowBtnViewController
- (IBAction)back:(id)sender {
   
    [self completeBlock:nil];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = NO;
   
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
   CGFloat centerX = screenW * 0.5;
    CGFloat y = screenH * 0.2;
    CGFloat width = 202;
    CGFloat height = 20;
    CGFloat x = centerX - (width * 0.5);
  
    NSArray *imageArr = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titleArr = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    
    NSInteger maxcols = 3;
    
    CGFloat buttonW = 72;
    
    CGFloat buttonH = buttonW + 30;
    
    CGFloat buttonStartY = (screenH - 2*buttonH)*0.5;
    CGFloat buttonStartX = 20;
    CGFloat margin = (screenW - 2 *buttonStartX - maxcols * buttonW) / (maxcols - 1);
    
    UIImageView *view1 = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
   
    view1.image = [UIImage imageNamed:@"app_slogan"];
    
    [self.view addSubview:view1];
    
    view1.hidden = YES;
   
    for (NSInteger i = 0; i < imageArr.count; i++) {
       customRegistBtn *btn = [[customRegistBtn alloc] init];
       
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = 100 + i;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.width = buttonW;
        btn.height = buttonH;
        
        NSInteger row = i / maxcols;
        NSInteger col = i % maxcols;
        
        btn.x = buttonStartX + col*(margin + buttonW);
        btn.y  = buttonStartY + row*buttonH;
      
//        btn.frame = CGRectMake(btn.x, -102, buttonW, buttonH);
        [self.view addSubview:btn];
        CGFloat buttonStartY = btn.y - [UIScreen mainScreen].bounds.size.height;
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(btn.x, buttonStartY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(btn.x, btn.y, buttonW, buttonH)];
        anim.springSpeed = 12;
        anim.springBounciness = 12;
        anim.beginTime = CACurrentMediaTime() + 0.05 * i;
        if (i != imageArr.count - 1) {
           
        }
        
        [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
            view1.hidden = NO;
            
        }];
        [btn pop_addAnimation:anim forKey:nil];
        
    }
  
    POPSpringAnimation  *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat pointx = [UIScreen mainScreen].bounds.size.width * 0.5;
    CGFloat pointStartY = y - [UIScreen mainScreen].bounds.size.height;
    
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(pointx, pointStartY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(pointx, y)];
    anim.springSpeed = 5;
    anim.springBounciness = 5;
    anim.beginTime = CACurrentMediaTime() + 0.6;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
       
        self.view.userInteractionEnabled = YES;
 
    }];
    
    [view1 pop_addAnimation:anim forKey:nil];
   
  // Do any additional setup after loading the view from its nib.
}

- (void)click:(customRegistBtn *)btn
{

        [self completeBlock:^{
           
            if (btn.tag == 102) {
            
                sentMessageViewController *view1 = [[sentMessageViewController alloc] init];
                customNavigationController *nav = [[customNavigationController alloc] initWithRootViewController:view1];
                //            [self.navigationController pushViewController:view1 animated:YES];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            }
            
            
        }];
    
}

- (void)completeBlock:(void(^)())completeblock
{
    
    for (int i = 1; i < self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat btnCurrent = subview.centerX;
        CGFloat btnEndY = subview.y + [UIScreen mainScreen].bounds.size.height;
        
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(btnCurrent, subview.y)];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(btnCurrent, btnEndY)];
        anim.beginTime = CACurrentMediaTime() + i * 0.1;
        [subview pop_addAnimation:anim forKey:nil];
        
        if (i == self.view.subviews.count - 1) {
            
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
             
                [self dismissViewControllerAnimated:NO completion:nil];
                
                if (completeblock == nil) {
                    return;
                }
            
                completeblock();
                
            }];
            
        }
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
