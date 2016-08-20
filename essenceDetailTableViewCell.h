//
//  essenceDetailTableViewCell.h
//  BS
//
//  Created by lanou on 16/8/5.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "essenceDetailModel.h"

@interface essenceDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *essenceDetailImage;
@property (weak, nonatomic) IBOutlet UILabel *essenceDetailTitle;
@property (weak, nonatomic) IBOutlet UILabel *essenceDetailCount;

- (void)setValueWithData:(essenceDetailModel *)model;


@end
