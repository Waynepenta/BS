//
//  DetailRecommendTableViewCell.h
//  BS
//
//  Created by lanou on 16/8/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recommendDetail.h"
#import "recommendCategory.h"

@interface DetailRecommendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *detailScreenLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailFansLabel;

- (void)setValueWithModel:(recommendDetail *)model;
@end
