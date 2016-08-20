//
//  TopicCommentModel.h
//  BS
//
//  Created by lanou on 16/8/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicUserModel.h"
@interface TopicCommentModel : NSObject
@property (nonatomic,copy) NSString *content;
@property (nonatomic,strong) TopicUserModel *usermodel;
@property (nonatomic,copy) NSString *like_count;
//@property (nonatomic,strong) NSMutableDictionary *usermodel;
@end
