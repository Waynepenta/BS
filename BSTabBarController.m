//
//  BSTabBarController.m
//  BS
//
//  Created by lanou on 16/8/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BSTabBarController.h"
#import "essenceViewController.h"
#import "friendTrendsViewController.h"
#import "NewViewController.h"
#import "meViewController.h"
#import "customTabBar.h"
@interface BSTabBarController ()

@end

@implementation BSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectoAttrs = [NSMutableDictionary dictionary];
    selectoAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectoAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectoAttrs forState:UIControlStateSelected];
  [self setValue:[[customTabBar alloc] init] forKey:@"tabBar"];
    UIViewController *v1 = [[essenceViewController alloc] init];
    v1.tabBarItem.title = @"精华";
    
    v1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    
    UIImage *img = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    v1.tabBarItem.selectedImage = img;
    customNavigationController *nav = [[customNavigationController alloc] initWithRootViewController:v1];
    
    v1.navigationItem.title = @"百思不得姐";
    
    v1.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    [self addChildViewController:nav];
   
    UIViewController *v2 = [[NewViewController alloc] init];
    v2.tabBarItem.title = @"新帖";
    
    v2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    UIImage *img1 = [UIImage imageNamed:@"tabBar_new_click_icon"];

    img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
    v2.tabBarItem.selectedImage = img1;
    customNavigationController *nav1 = [[customNavigationController alloc] initWithRootViewController:v2];
    v2.navigationItem.title = @"新帖";
    v2.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    [self addChildViewController:nav1];
    
    UIViewController *v3 = [[ friendTrendsViewController alloc] init];
    v3.tabBarItem.title = @"关注";
    
    v3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    UIImage *img2 = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    
    img2 = [img2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     customNavigationController *nav2 = [[customNavigationController alloc] initWithRootViewController:v3];
    v3.navigationItem.title = @"关注";
    v3.tabBarItem.selectedImage = img2;
    v3.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    [self addChildViewController:nav2];
   UIViewController *v4 = [[meViewController alloc] init];
    v4.tabBarItem.title = @"我";
    
    v4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    UIImage *img3 = [UIImage imageNamed:@"tabBar_me_click_icon"];
  
    img3 = [img3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    customNavigationController *nav3 = [[customNavigationController alloc] initWithRootViewController:v4];
    v4.navigationItem.title = @"我";
    
    v4.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    v4.tabBarItem.selectedImage = img3;
    [self addChildViewController:nav3];
}

@end
