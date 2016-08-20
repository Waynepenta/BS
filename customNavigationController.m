//
//  customNavigationController.m
//  BS
//
//  Created by lanou on 16/8/2.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "customNavigationController.h"

@interface customNavigationController ()

@end

@implementation customNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *item = [NSMutableDictionary dictionary];
    item[NSForegroundColorAttributeName] = [UIColor blackColor];
    item[NSFontAttributeName] = [UIFont systemFontOfSize:15];
   
    
    UIBarButtonItem *bar = [UIBarButtonItem appearance];
    [bar setTitleTextAttributes:item forState:UIControlStateNormal];
    
      NSMutableDictionary *item1 = [NSMutableDictionary dictionary];
    item1[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [bar setTitleTextAttributes:item1 forState:UIControlStateDisabled];
   
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        btn.size = CGSizeMake(70, 30);
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];



}

- (void)back
{

    [self popViewControllerAnimated:YES];
    
    

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
