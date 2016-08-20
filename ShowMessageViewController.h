//
//  ShowMessageViewController.h
//  BS
//
//  Created by lanou on 16/8/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"

@interface ShowMessageViewController : UIViewController
@property (nonatomic,strong) TopicModel *topicmodel;
@property (nonatomic,copy) NSString *ID;
@end
