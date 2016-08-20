//
//  FriendRecommendViewController.m
//  BS
//
//  Created by lanou on 16/8/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "FriendRecommendViewController.h"
#import <AFNetworking.h>
#import "SVProgressHUD.h"
#import "RecommendCategoryTableViewCell.h"
#import "recommendCategory.h"
#import "DetailRecommendTableViewCell.h"
#import "recommendDetail.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#define rowIndex self.dataArray[[self.tableV indexPathForSelectedRow].row]


@interface FriendRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (weak, nonatomic) IBOutlet UITableView *DetailTableV;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *dataDetailArray;

@property (nonatomic,strong) NSMutableDictionary *parmars;

@property (nonatomic,strong) AFHTTPSessionManager *manager;



@end

@implementation FriendRecommendViewController

- (AFHTTPSessionManager *)manager{
    
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }


    return  _manager;
}



- (NSMutableArray *)dataArray{

    if (!_dataArray ) {
        _dataArray = [[NSMutableArray alloc] init];
    }

    return _dataArray;


}

- (NSMutableArray *)dataDetailArray{

    if (!_dataDetailArray) {
        _dataDetailArray = [[NSMutableArray alloc] init];
    }
    return  _dataDetailArray;

}



- (void)analyData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
      [SVProgressHUD show];
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"成功");
      
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       [SVProgressHUD dismiss];
        
        
        NSArray *array = responseObject[@"list"];
        
        
        
        for (NSDictionary *dic in array) {
            
            recommendCategory *model = [[recommendCategory alloc] init];
            
            
            [model setValuesForKeysWithDictionary:dic];
            
             [self.dataArray addObject:model];
        }
        
        
        [self.tableV reloadData];
        
        [self.tableV selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
       
        [self.DetailTableV.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
          [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
    


}



- (void)CreatTableView{
    
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
//    self.tableV.backgroundColor = [UIColor redColor];
    [self.tableV registerNib:[UINib nibWithNibName:@"RecommendCategoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableV.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    self.DetailTableV.delegate = self;
    self.DetailTableV.dataSource = self;
    
    [self.DetailTableV registerNib:[UINib nibWithNibName:@"DetailRecommendTableViewCell" bundle:nil] forCellReuseIdentifier:@"user"];
    self.DetailTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.DetailTableV.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.DetailTableV.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    

}

- (void)setupRefresh{
    
    
    self.DetailTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    
    
    self.DetailTableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    self.DetailTableV.mj_footer.hidden = YES;


}

- (void)loadNewData{
    
    
    recommendCategory *model1 = rowIndex;
    
    model1.currtpage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = model1.id;
    params[@"page"] = @(model1.currtpage);
    self.parmars = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parmars != params) {
            return ;
        }
      
        
        
        model1.total = [responseObject[@"total"] integerValue];
        
        NSArray *array = responseObject[@"list"];
       
        for (NSDictionary *dict in array) {
            
            recommendDetail *model = [[recommendDetail alloc] init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [model1.details addObject:model];
            
        }
        
        
        [self.DetailTableV reloadData];
        
        [self.DetailTableV.mj_header endRefreshing];
        
        
        if (model1.details.count == model1.total) {
            [self.DetailTableV.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.DetailTableV.mj_footer endRefreshing];
        
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parmars != params) {
            return ;
        }
        
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
//        [self.DetailTableV.mj_header endRefreshing];
        NSLog(@"解析错误");
        
    }];

    
    
    
    




}


- (void)loadData{
    
    recommendCategory *model1 = rowIndex;

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @[[rowIndex id]];
    
    params[@"page"] = @(model1.currtpage++);
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"解析成功");
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *array = responseObject[@"list"];
       
        
        
       
        
        for (NSDictionary *dict in array) {
            
            recommendDetail *model = [[recommendDetail alloc] init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [model1.details addObject:model];
            
        }
        
        
      
        
        [self.DetailTableV reloadData];
        
        
        if (model1.details.count == model1.total) {
            
//    MJRefreshFooter *foot  = self.DetailTableV.mj_footer;
            [self.DetailTableV.mj_footer endRefreshingWithNoMoreData];
       
        }else{
        
            
            [self.DetailTableV.mj_footer endRefreshing];
        
        }
       
        [self.DetailTableV.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parmars != params) {
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        
        NSLog(@"解析错误");
        
    }];





}




- (void)viewDidLoad {
    
    
    
    
    
    [super viewDidLoad];
    self.title = @"推荐关注";
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    [self analyData];
    [self CreatTableView];
    
    [self setupRefresh];
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    
    if (tableView == self.tableV) {
        return self.dataArray.count;
        
    }else{
        
        if (self.dataArray.count == 0) {
            return 0;
        }
        
//   recommendCategory *model = self.dataArray[[self.tableV indexPathForSelectedRow].row];
        
        recommendCategory *model = rowIndex;
        
        NSInteger count = [rowIndex details].count;
        
        if (model.details.count == model.total) {
            
            [self.DetailTableV.mj_footer endRefreshing
             ];
        
        }
        
        
        
        self.DetailTableV.mj_footer.hidden = ([rowIndex details].count == 0);
        
        return count;
        
    
    }
    
    


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableV) {
        RecommendCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[RecommendCategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        recommendCategory *model = self.dataArray[indexPath.row];
        cell.textLabel.text = model.name;
        cell.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        
        DetailRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user" forIndexPath:indexPath];
        if (!cell) {
            cell = [[DetailRecommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"user"];
        }
        
//        recommendDetail *model = self.dataDetailArray[indexPath.row];
        
//        [cell setValueWithModel:model];
         cell.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        
        recommendCategory *model1 = self.dataArray[[self.tableV indexPathForSelectedRow].row];
       
      recommendDetail *model2 = model1.details[indexPath.row];
    
        
        cell.detailScreenLabel.text = model2.screen_name;
        cell.detailFansLabel.text = [NSString stringWithFormat:@"%ld人关注",model2.fans_count];
        [cell.detailImage sd_setImageWithURL:[NSURL URLWithString:model2.header]];


        return  cell;
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 75;
    


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    recommendCategory *model1 = self.dataArray[indexPath.row];
    model1.currtpage = 1;
    
    if (model1.details.count) {
        
        [self.DetailTableV reloadData];
        
        
    }else{
        
        [self.DetailTableV reloadData];
        
        [self.DetailTableV.mj_header beginRefreshing];
    
    }
    


}

// 页面退出的时候结束网络刷新任务
- (void)dealloc{

    [self.manager.operationQueue cancelAllOperations];

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
