//
//  customRegistTextField.m
//  BS
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "customRegistTextField.h"

@implementation customRegistTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib
{
//    
//    UILabel *t =  [self valueForKeyPath:@"_placeholderLabel"];
//    t.textColor = [UIColor redColor];
//    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderColorKeyPath"];
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    self.tintColor = self.textColor;


}


- (BOOL)becomeFirstResponder
{
    
    
//[self setValue:self.textColor forKeyPath:@"_placeholderColorKeyPath"];
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];


}

- (BOOL)resignFirstResponder
{
    
    
   [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    return [super resignFirstResponder];


}














@end
