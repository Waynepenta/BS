//
//  sentMessageViewController.m
//  BS
//
//  Created by lanou on 16/8/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "sentMessageViewController.h"
#import "SentTextView.h"

@interface sentMessageViewController ()

@end

@implementation sentMessageViewController

- (void)setupNav
{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded];

}

- (void)setupTextview
{
    SentTextView *textview = [[SentTextView alloc] init];
    textview.frame = self.view.bounds;
    textview.placeholder = @"1122352094i59023u05823084902323423423423084902323423423084902323423423084902323423423084902323423423084902323423423084902323423423084902323423423084902323423423084902323423423";
  
    [self.view addSubview:textview];


}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    [self setupTextview];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)back
{

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)done
{


    NSLog(@" 发表");

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
