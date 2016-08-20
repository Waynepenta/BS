//
//  TopicUserModel.m
//  BS
//
//  Created by lanou on 16/8/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicUserModel.h"

@implementation TopicUserModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        self.userID = value;
    }
    

}
@end
