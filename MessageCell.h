//
//  MessageCell.h
//  BS
//
//  Created by lanou on 16/8/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicCommentModel.h"
#import "TopicUserModel.h"

@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *userContext;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profile_img;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;


- (void)setValueWithModel:(TopicCommentModel *)model;
@end
