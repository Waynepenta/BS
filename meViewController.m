//
//  meViewController.m
//  BS
//
//  Created by lanou on 16/8/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "meViewController.h"
#import "MeView.h"
#import "MeTableViewCell.h"
static NSString * const Identifier = @"cell";
@interface meViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableV;


@end

@implementation meViewController


- (void)creatTabelView

{
    self.tableV = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    
    [self.view addSubview:_tableV];
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.sectionHeaderHeight = 0;
    self.tableV.sectionFooterHeight = 10;
    
    self.tableV.contentInset = UIEdgeInsetsMake(-10, 0, -100, 0);
    self.tableV.contentSize = CGSizeMake(0, CGRectGetMaxY(self.tableV.frame));
    
    self.tableV.tableFooterView  = [[MeView alloc] init];
    self.tableV.tableFooterView.backgroundColor = [UIColor clearColor];

    [self.tableV registerClass:[MeTableViewCell class] forCellReuseIdentifier:Identifier];
    

}





- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTabelView];
    self.view.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 /255.0 blue:244/255.0 alpha:1];
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithimage:@"mine-setting-icon" lightImage:@"mine-setting-icon-click.png" target:self action:@selector(settingItemAction)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithimage:@"mine-moon-icon" lightImage:@"mine-sun-icon-click" target:self action:@selector(moonItemAction)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
    // Do any additional setup after loading the view.
}


- (void)settingItemAction{



}

- (void)moonItemAction{




}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"header_cry_icon"];
    }else if(indexPath.section == 1){
    
        cell.textLabel.text = @"离线下载";
    }
    
  
    

    return cell;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//
//    return 10;
//
//
//}











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
