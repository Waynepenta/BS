//
//  essenceViewController.m
//  BS
//
//  Created by lanou on 16/8/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "essenceViewController.h"
#import "essenceDetailViewController.h"
#import "AllViewController.h"
#import "MediaViewController.h"
#import "VoiceViewController.h"
#import "PictureViewController.h"
#import "GameViewController.h"
#import "ShowPicViewController.h"
#import "pictureView.h"
#import "NewVoiceViewController.h"
#import "MusicManage.h"

@interface essenceViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIView *view2;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,strong) UIScrollView *scrollview1;
@end

@implementation essenceViewController

- (void)setup
{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width , 40)];
    view1.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    CGFloat height = view1.height;
    CGFloat width = view1.width / 5;
    self.view2 = [[UIView alloc] init];
    self.view2.backgroundColor = [UIColor redColor];
    self.view2.height = 2;
    self.view2.y = view1.height - self.view2.height;
    [view1 addSubview:_view2];
    NSArray *array = @[@"全 部",@"视 频",@"声 音",@"图 片",@"段 子"];
    for (NSInteger i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*width , 0, width, height);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn layoutIfNeeded];// 强制布局
         btn.tag = i+100;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
       if (i == 0) {
            [self btnClick1:btn];
        }
       [view1 addSubview:btn];
    }
     [self.view addSubview:view1];
}

- (void)btnClick1:(UIButton *)btn
{
    self.selectBtn.enabled = YES;
    btn.enabled = NO;
    self.selectBtn = btn;
    [UIView animateWithDuration:0.25 animations:^{
        self.view2.width = btn.titleLabel.width;
        self.view2.centerX = btn.centerX;
    }];
  if (btn.tag == 100) {
        self.scrollview1.contentOffset = CGPointMake(0, 0);
  }else if(btn.tag == 101){
    self.scrollview1.contentOffset = CGPointMake(self.scrollview1.width, 0);
    [self scrollViewDidEndScrollingAnimation:self.scrollview1];
   }else if(btn.tag == 102){
    self.scrollview1.contentOffset = CGPointMake(self.scrollview1.width*2, 0);
        [self scrollViewDidEndScrollingAnimation:self.scrollview1];
    }else if(btn.tag == 103){
       self.scrollview1.contentOffset = CGPointMake(self.scrollview1.width *3, 0);
        [self scrollViewDidEndScrollingAnimation:self.scrollview1];
    }else if(btn.tag == 104){
        self.scrollview1.contentOffset = CGPointMake(self.scrollview1.width *4, 0);
        [self scrollViewDidEndScrollingAnimation:self.scrollview1];
    }
 
}

- (void)setupScroll
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollview1 = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
   self.scrollview1.contentSize = CGSizeMake(self.scrollview1.width * self.childViewControllers.count, 0);
    self.scrollview1.delegate = self;
    self.scrollview1.pagingEnabled = YES;
    self.scrollview1.bounces = YES;
    [self.view addSubview:_scrollview1];
    [self.view insertSubview:_scrollview1 atIndex:0];
    [self scrollViewDidEndScrollingAnimation:self.scrollview1];
  
}
- (void)setupChildVC
{
    AllViewController *all = [[AllViewController alloc] init];
   [self addChildViewController:all];
    MediaViewController *media = [[MediaViewController alloc] init];
    [self addChildViewController:media];
    VoiceViewController *voice = [[VoiceViewController alloc] init];
    [self addChildViewController:voice];
    PictureViewController *pic = [[PictureViewController alloc] init];
    [self addChildViewController:pic];
    GameViewController *game = [[GameViewController alloc] init];
    [self addChildViewController:game];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
   [self setupChildVC];
   [self setupScroll];
   [self setup];
   self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"MainTagSubIcon.png" lightImage:@"MainTagSubIconClick.png" target:self action:@selector(btnClick)];
   
}

- (void)change
{
    ShowPicViewController *view1 = [[ShowPicViewController alloc] init];
   [self.navigationController presentViewController:view1 animated:YES completion:nil];
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [[MusicManage shareMusicPlay] pause];
    [self scrollViewDidEndScrollingAnimation:self.scrollview1];

}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//  [[MusicManage shareMusicPlay] pause];
    NSInteger index = self.scrollview1.contentOffset.x / self.scrollview1.width;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = self.scrollview1.contentOffset.x;
    [self.scrollview1 addSubview:vc.view];
    if (index == 0) {
        UIButton *btn = [self.view viewWithTag:100];
        self.selectBtn.enabled = YES;
        btn.enabled = NO;
        self.selectBtn = btn;
        [UIView animateWithDuration:0.25 animations:^{
            self.view2.width = btn.titleLabel.width;
            self.view2.centerX = btn.centerX;
            }];
    }else if (index == 1) {
        UIButton *btn = [self.view viewWithTag:101];
        self.selectBtn.enabled = YES;
        btn.enabled = NO;
        self.selectBtn = btn;
        [UIView animateWithDuration:0.25 animations:^{
           self.view2.width = btn.titleLabel.width;
            self.view2.centerX = btn.centerX;
       }];
        
    }else if(index == 2){
        UIButton *btn = [self.view viewWithTag:102];
        self.selectBtn.enabled = YES;
        btn.enabled = NO;
        self.selectBtn = btn;
       [UIView animateWithDuration:0.25 animations:^{
            self.view2.width = btn.titleLabel.width;
            self.view2.centerX = btn.centerX;
        }];
    }else if (index == 3){
        UIButton *btn = [self.view viewWithTag:103];
        self.selectBtn.enabled = YES;
        btn.enabled = NO;
        self.selectBtn = btn;
        [UIView animateWithDuration:0.25 animations:^{
            self.view2.width = btn.titleLabel.width;
            self.view2.centerX = btn.centerX;
         }];
    }else if (index == 4){
       UIButton *btn = [self.view viewWithTag:104];
        self.selectBtn.enabled = YES;
        btn.enabled = NO;
        self.selectBtn = btn;
        [UIView animateWithDuration:0.25 animations:^{
            self.view2.width = btn.titleLabel.width;
            self.view2.centerX = btn.centerX;
        }];
    }
}

- (void)btnClick{
   essenceDetailViewController *view1 = [[essenceDetailViewController alloc] init];
   [self.navigationController pushViewController:view1 animated:YES];
}

@end
