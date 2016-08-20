//
//  recommendCategory.h
//  BS
//
//  Created by lanou on 16/8/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface recommendCategory : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *id;

@property (nonatomic,copy) NSString *screen_name;
@property (nonatomic,assign) NSInteger fans_count;
@property (nonatomic,copy)NSString *header;

@property (nonatomic,strong) NSMutableArray *details;

@property (nonatomic,assign) NSInteger total;

@property (nonatomic,assign) NSInteger currtpage;






@end
