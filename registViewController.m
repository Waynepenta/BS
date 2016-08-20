//
//  registViewController.m
//  BS
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "registViewController.h"

@interface registViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *registView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMove;
@property (weak, nonatomic) IBOutlet UIView *registerV;

@end

@implementation registViewController
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (IBAction)turn:(UIButton *)sender {
    
   
    
    if (self.loginView.constant == 0) {
        self.loginView.constant = -self.view.width;
        [sender setTitle:@"已有账号?" forState:UIControlStateNormal];
        
    }else{
    
        self.loginView.constant = 0;
        [sender setTitle:@"立即注册" forState:UIControlStateNormal];
        
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
     [self.view endEditing:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self.view insertSubview:self.registView atIndex:0];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{

    return UIStatusBarStyleLightContent;

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
