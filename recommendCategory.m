//
//  recommendCategory.m
//  BS
//
//  Created by lanou on 16/8/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "recommendCategory.h"

@implementation recommendCategory
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{


    

}

- (NSMutableArray *)details{
    if (!_details) {
        _details = [[NSMutableArray alloc] init];
    }

    return _details;



}



@end
