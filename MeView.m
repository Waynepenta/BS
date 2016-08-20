//
//  MeView.m
//  BS
//
//  Created by lanou on 16/8/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MeView.h"
#import <AFHTTPSessionManager.h>
#import "MeModel.h"
#import <UIButton+WebCache.h>
#import "MeWebViewController.h"
#import "MeButton.h"
#import "meViewController.h"


@interface MeView()

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation MeView

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }

    return _dataArray;
}




- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        NSMutableDictionary *parmer = [NSMutableDictionary dictionary];
        parmer[@"a"] = @"square";
        parmer[@"c"] = @"topic";
    
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parmer progress:^(NSProgress * _Nonnull downloadProgress) {
           
        } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
          NSArray *array = responseObject[@"square_list"];
            
       
            
            for (NSDictionary *dic in array) {
                
                MeModel *model = [[MeModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.dataArray addObject:model];
            }
         
            [self square:self.dataArray];
   
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        }];
        
    }



    return self;
}

- (void)square:(NSMutableArray *)dataArray;
{
    
    int maxCols = 4;
    
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / maxCols;
    CGFloat btnH =  btnW;
    
    
    for (int i = 0; i < dataArray.count; i++) {
//        MeModel *model = dataArray[i];
        
        MeButton *btn =[MeButton buttonWithType:UIButtonTypeCustom];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.model = dataArray[i];
        
        [self addSubview:btn];
        
        
        int col = i % maxCols;
        int row = i / maxCols;
        
        btn.x = col * btnW;
        btn.y = row * btnH;
        btn.width = btnW;
        btn.height = btnH;
        
        self.height = CGRectGetMaxY(btn.frame);
    }
    [self setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

//    self.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 600);
    

}



- (void)btnClick:(MeButton *)btn
{
    MeWebViewController *view1 = [[MeWebViewController alloc] init];
    
    view1.url = btn.model.url;
    view1.navigationItem.title = btn.model.name;
    
    UITabBarController *tabbar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
 UINavigationController *view2 = (UINavigationController *)tabbar.selectedViewController;
 
    [view2 pushViewController:view1 animated:YES];
    
}


 
 
 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
    
    
}




@end
