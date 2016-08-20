//
//  SentTextView.m
//  BS
//
//  Created by lanou on 16/8/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "SentTextView.h"

@implementation SentTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        self.font = [UIFont systemFontOfSize:15];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change) name:UITextViewTextDidChangeNotification object:nil];
      
    }
   
    return self;

}

- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)change
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
   
    if (self.text.length) {
        return;
    }
   
    rect.origin.x = 4;
    rect.origin.y = 7;
    rect.size.width = rect.size.width - 2*rect.origin.x;
    NSMutableDictionary *item = [NSMutableDictionary dictionary];
    item[NSFontAttributeName] = self.font;
    item[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    [self.placeholder drawInRect:rect withAttributes:item];
   
}



- (void)_firstBaselineOffsetFromTop
{

}
- (void)_baselineOffsetFromBottom
{

}


@end
