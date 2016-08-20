//
//  ShowMessageViewController.m
//  BS
//
//  Created by lanou on 16/8/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ShowMessageViewController.h"
#import "TopicCell.h"
#import "TopicModel.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "TopicCommentModel.h"
#import "TopicUserModel.h"
#import "MessageCell.h"


static NSString  *  const cell1 = @"cell123";

@interface ShowMessageViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
//底部工具条的间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBottom;
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (nonatomic,strong) NSMutableArray *commentArr;
@property (nonatomic,strong) NSMutableArray *hotArray;

@property (nonatomic,strong) NSMutableArray *save_top_cmt;

@property (nonatomic,assign) NSInteger page;


@end

@implementation ShowMessageViewController

- (NSMutableArray *)commentArr
{
    if (!_commentArr) {
        _commentArr = [[NSMutableArray alloc] init];
    }
    return _commentArr;
}

- (NSMutableArray *)hotArray
{
    if (!_hotArray) {
    _hotArray = [[NSMutableArray alloc] init];
    }
    return _hotArray;
}

//tableView视图
- (void)creatTabelV
{
    
    UIView *view1 = [[UIView alloc] init];
   
    TopicCell *cell = [TopicCell cell];
  
    if (self.topicmodel.top_cmt.count) {
        
        self.save_top_cmt = self.topicmodel.top_cmt;
        self.topicmodel.top_cmt = nil;
        self.topicmodel.cellHeight = 0;
        
    }
    
    [cell setupVauleWithModel:self.topicmodel commentModel:nil];
    
    cell.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.topicmodel.cellHeight);
    
    [view1 addSubview:cell];
    view1.height = self.topicmodel.cellHeight + 10;
    
    self.tableV.tableHeaderView = view1;
    
    self.tableV.estimatedRowHeight = 60;
    self.tableV.rowHeight = UITableViewAutomaticDimension;
    
    self.tableV.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableV registerNib:[UINib nibWithNibName:NSStringFromClass([MessageCell class]) bundle:nil] forCellReuseIdentifier:cell1];

}


//刷新控件
- (void)setupRefresh
{
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(analyData)];
    [self.tableV.mj_header beginRefreshing];
    
//    self.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    

}
//加载更多数据
- (void)loadMoreData
{
    NSInteger page = self.page + 1 ;
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"a"] = @"dataList";
    parmars[@"c"] = @"comment";
    parmars[@"data_id"] = self.ID;
    parmars[@"page"] =@(page);
    TopicCommentModel *model = [self.commentArr lastObject];
    parmars[@"lastcid"] = model.usermodel.userID;
   
    NSLog(@"那这里的ID呢%@",model.usermodel.userID);
    
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parmars progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        //这里的数据竟然为空！
        NSArray *array = responseObject[@"data"];
       
        for (NSDictionary *dic in array) {
            TopicCommentModel *model = [[TopicCommentModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            TopicUserModel *model1  =  [[TopicUserModel alloc] init];
            
            [model1 setValuesForKeysWithDictionary:dic[@"user"]];
            model.usermodel = model1;
            
            [self.commentArr addObject:model];
            
            
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableV reloadData];
            
        });
        
        [self.tableV.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableV.mj_footer endRefreshing];
        
        self.page--;
        
    }];




}





//请求数据
- (void)analyData
{
   NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"a"] = @"dataList";
    parmars[@"c"] = @"comment";
    parmars[@"data_id"] = self.ID;
    parmars[@"page"] = @(1);
    parmars[@"hot"] = @"1";
    
    [self.commentArr removeAllObjects];
    [self.hotArray removeAllObjects];
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parmars progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableV.mj_header endRefreshing];
            return ;
        }
        
        
      
        self.page = 1;
        
        NSArray *array = responseObject[@"data"];
      
        if (responseObject[@"hot"]) {
            
            NSArray *array1  = responseObject[@"hot"];
           
            for (NSDictionary *dic in array1) {
                TopicCommentModel *model = [[TopicCommentModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                TopicUserModel *model1  =  [[TopicUserModel alloc] init];
                [model1 setValuesForKeysWithDictionary:dic[@"user"]];
                model.usermodel = model1;
                
                [self.hotArray addObject:model];
                
           
            }
           
        }
    for (NSDictionary *dic in array) {
    TopicCommentModel *model = [[TopicCommentModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    TopicUserModel *model1  =  [[TopicUserModel alloc] init];
            
    [model1 setValuesForKeysWithDictionary:dic[@"user"]];
            model.usermodel = model1;
            
    [self.commentArr addObject:model];
            
        
  }
   
    
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            [self.tableV reloadData];
            
        });
        
        if (self.commentArr.count >= [responseObject[@"total"] integerValue]) {
            self.tableV.mj_footer.hidden = YES;
        }
    
       [self.tableV.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableV.mj_header endRefreshing];
        
    }];
    
  
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评论";
  
     [self setupRefresh];
    
    [self analyData];
    [self creatTabelV];
   
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:@"comment_nav_item_share_icon"lightImage:@"comment_nav_item_share_icon_click" target:self action:@selector(action)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)action
{

    


}

//键盘事件
- (void)keyChangeFrame:(NSNotification *)note
{

    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.toolBottom.constant = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        [self.view layoutIfNeeded];
        
    }];
    
}





//销毁
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.save_top_cmt.count) {
        self.topicmodel.top_cmt = self.save_top_cmt;
        [self.topicmodel setValue:@0 forKey:@"cellHeight"];
    }
    
    [[AFHTTPSessionManager manager] invalidateSessionCancelingTasks:YES];
}





- (TopicCommentModel *)commentsInIndexPath:(NSIndexPath *)indexpath
{
    return [self commentsInSection:indexpath.section][indexpath.row];
}




- (NSMutableArray *)commentsInSection:(NSInteger)section
{
    
   
    if (section == 0) {
        return  self.hotArray.count ? self.hotArray : self.commentArr;
    }
    return self.commentArr;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
    return  self.hotArray.count ? self.hotArray.count : self.commentArr.count;
    }
    
    if (section == 1) {
        
        return  self.commentArr.count;
    }
    
    return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    if (self.hotArray.count > 0) {
        return  2;
      }
    if (self.commentArr.count > 0) {
        
             return 1;
       }
    return  0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return self.hotArray.count ? @"热门评论" : @"最新评论";
    }
    
   return @"最新评论";
  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cell1 forIndexPath:indexPath];

    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    TopicCommentModel *model = [self commentsInIndexPath:indexPath];
   
   
    [cell setValueWithModel:model];
    
   
        return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TopicCommentModel *model = [self commentsInIndexPath:indexPath];
    
    CGSize maxsize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 90, MAXFLOAT);
    
    CGFloat textH = [model.content boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    CGFloat cellHeight = 10 + 20 + 5 + textH + 10;


    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = (MessageCell *)[tableView cellForRowAtIndexPath:indexPath];
   UIMenuController *men = [UIMenuController sharedMenuController];

    [cell becomeFirstResponder];
    
    if (men.menuVisible == YES) {
        
        [men setMenuVisible:NO animated:YES];
        
    }else{
        
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(report:)];
        
        men.menuItems = @[ding,replay,report];
        
        CGRect rect = CGRectMake(0, cell.height *0.5 , cell.width, cell.height*0.5);
        
        [men setTargetRect:rect inView:cell];
        
        [men setMenuVisible:YES animated:YES];
    
    }
 
}

- (void)ding:(UIMenuController *)ding
{

    NSLog(@"顶");

}
- (void)replay:(UIMenuController *)replay
{
    
    NSLog(@"回复");

}
- (void)report:(UIMenuController *)report
{


    NSLog(@"转发");


}










- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    [self.view endEditing:NO];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
