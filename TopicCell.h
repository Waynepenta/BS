//
//  TopicCell.h
//  BS
//
//  Created by lanou on 16/8/9.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
#import "TopicCommentModel.h"

@interface TopicCell : UITableViewCell
@property (nonatomic,strong)TopicModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *creatTime;
@property (weak, nonatomic) IBOutlet UIButton *dingbtn;
@property (weak, nonatomic) IBOutlet UIButton *caibtn;

@property (weak, nonatomic) IBOutlet UIButton *respotbtn;

@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIImageView *sina_V;
@property (weak, nonatomic) IBOutlet UILabel *topcontext;

- (void)setupVauleWithModel:(TopicModel *)model commentModel:(TopicCommentModel *)comModel;

+ (instancetype)cell;






@end
