//
//  CustomVoiceView.h
//  BS
//
//  Created by lanou on 16/8/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"

@interface CustomVoiceView : UIView
+(instancetype)voiceView;

@property (nonatomic,strong) TopicModel *model;

@end
