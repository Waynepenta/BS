//
//  friendTrendsViewController.m
//  BS
//
//  Created by lanou on 16/8/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "friendTrendsViewController.h"
#import "FriendRecommendViewController.h"
#import "registViewController.h"

@interface friendTrendsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation friendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
        
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click.png"] forState:UIControlStateSelected];
//    btn.size = btn.currentBackgroundImage.size;
//    
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"MainTagSubIcon.png" lightImage:@"MainTagSubIconClick.png" target:self action:@selector(btnClick)];
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"friendsRecommentIcon.png" lightImage:@"friendsRecommentIcon-click.png" target:self action:@selector(btnClick)];
    
    
    // Do any additional setup after loading the view.
}

- (void)btnClick{
    
    FriendRecommendViewController *vc = [[FriendRecommendViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)registerBtn:(id)sender {
    
    registViewController *view1 = [[registViewController alloc] init];
    
    [self presentViewController:view1 animated:YES completion:nil];
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
