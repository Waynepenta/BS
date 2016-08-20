//
//  essenceDetailViewController.m
//  BS
//
//  Created by lanou on 16/8/5.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "essenceDetailViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "essenceDetailModel.h"
#import "essenceDetailTableViewCell.h"


@interface essenceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation essenceDetailViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray ) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)analyData{

    NSMutableDictionary *parmer = [NSMutableDictionary dictionary];
    parmer[@"a"] = @"tag_recommend";
    parmer[@"action"] = @"sub";
    parmer[@"c"] = @"topic";
    
    [SVProgressHUD show];
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parmer progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
       NSArray *array = responseObject;
      
        for (NSDictionary *dic in array) {
            essenceDetailModel *model = [[essenceDetailModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.dataArray addObject:model];
          
        }
     
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.tableV reloadData];
        });
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"网络出错");
        
    }];
}

- (void)creatTablev{
    self.tableV = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.tableV registerNib:[UINib nibWithNibName:@"essenceDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.tableV.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_tableV];


}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self analyData];
    [self creatTablev];
   
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

  
    return self.dataArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    essenceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    essenceDetailModel *model = self.dataArray[indexPath.row];
    [cell setValueWithData:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;


}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 90;

}


@end
