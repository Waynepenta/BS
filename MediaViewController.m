//
//  MediaViewController.m
//  BS
//
//  Created by lanou on 16/8/8.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MediaViewController.h"
#import "AFHTTPSessionManager.h"
#import "SVProgressHUD.h"
#import <MJRefresh/MJRefresh.h>
#import "TopicModel.h"
#import "TopicCell.h"

@interface MediaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,copy) NSString *maxtime;
@property (nonatomic,strong) NSMutableDictionary *parmers;
@property (nonatomic,assign) NSInteger lastSelectIndex;

@end

@implementation MediaViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    
    return  _dataArray;
    
    
}




- (void)analyData


{
    
    [self.tableV.mj_footer endRefreshing];
    
    
    NSMutableDictionary *parmer = [NSMutableDictionary dictionary];
    parmer[@"a"] = @"list";
    parmer[@"type"] = @"41";
    parmer[@"c"] = @"data";
    self.parmers = parmer;
    self.page = 0;
    
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parmer progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if (self.parmers != parmer) {
            
            return;
        }
       
        NSString *str = responseObject[@"info"][@"maxtime"];
       
        NSArray *array = responseObject[@"list"];
       
        for (NSDictionary *dic in array) {
            TopicModel *model = [[TopicModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.dataArray addObject:model];
            
        }
        
        self.maxtime = str;
        
        [self.tableV.mj_header endRefreshing];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableV reloadData];
        });
        
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"网络出错");
       
        [self.tableV.mj_header endRefreshing];
        
    }];
    
}

- (void)setupRefresh
{
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerCilick)];
    
    self.tableV.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableV.mj_header beginRefreshing];
    
    self.tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
   
}

- (void)headerCilick
{
    
    [self analyData];
    
}

- (void)loadMoreData
{
    self.page++;
    
    [self.tableV.mj_header endRefreshing];
    
    NSMutableDictionary *parmer = [NSMutableDictionary dictionary];
    parmer[@"a"] = @"list";
    parmer[@"type"] = @"41";
    parmer[@"c"] = @"data";
    parmer[@"page"] = @(self.page);
    parmer[@"maxtime"] = self.maxtime;
    
    self.parmers = parmer;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parmer progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if (self.parmers != parmer) {
            return;
        }
       NSString *str = responseObject[@"info"][@"maxtime"];
       
        NSArray *array = responseObject[@"list"];
       
        for (NSDictionary *dic in array) {
            
            TopicModel *model = [[TopicModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.dataArray addObject:model];
           
        }
        
        self.maxtime = str;
       [self.tableV.mj_footer endRefreshing];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableV reloadData];
           
        });
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"网络出错");
        
        [self.tableV.mj_footer endRefreshing];
       self.page--;
        
    }];
  
}



- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tableV = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    CGFloat bottom = self.tabBarController.tabBar.height;
    
    CGFloat top = 40+64;
    
    self.tableV.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.backgroundColor = [UIColor clearColor];
    [self.tableV registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [self.view addSubview:_tableV];
    
    [self setupRefresh];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changTarbar) name:@"changeTarbar" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)changTarbar
{
    if (self.lastSelectIndex == self.tabBarController.selectedIndex) {
        [self.tableV.mj_header beginRefreshing];
    }
    
    self.lastSelectIndex = self.tabBarController.selectedIndex;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    
    if ( cell == nil) {
        cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    TopicModel *model = self.dataArray[indexPath.row];
    
    [cell setupVauleWithModel:model commentModel:nil];
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicModel *model = self.dataArray[indexPath.row];
   
    return  model.cellHeight;
    
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
