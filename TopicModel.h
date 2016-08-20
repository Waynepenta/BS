//
//  TopicModel.h
//  BS
//
//  Created by lanou on 16/8/9.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicModel : NSObject
@property (nonatomic,copy) NSString *profile_image;
@property (nonatomic,assign) NSInteger cai;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) NSInteger repost;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger ding;
@property (nonatomic,copy) NSString *create_time;
@property (nonatomic,assign) NSInteger comment;
@property (nonatomic,assign,getter=isSina_v) BOOL sina_v;

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,copy) NSString *image0;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGRect pictureF;

@property (nonatomic,assign) BOOL isBigPic;

@property (nonatomic,assign) CGFloat progressVaule;

@property (nonatomic,assign) CGRect voiceF;
@property (nonatomic,assign) NSInteger playcount;
@property (nonatomic,assign) NSInteger voicetime;
@property (nonatomic,copy) NSString *voiceuri;
@property (nonatomic,copy) NSString *videouri;
@property (nonatomic,assign) NSInteger videotime;
@property (nonatomic,assign) CGRect vedioF;

//最热评论的数组
@property (nonatomic,strong) NSMutableArray *top_cmt;

@property (nonatomic,copy) NSString *ID;


@end
