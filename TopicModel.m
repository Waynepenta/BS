//
//  TopicModel.m
//  BS
//
//  Created by lanou on 16/8/9.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicModel.h"
#import "pictureView.h"

@interface TopicModel ()


@end



@implementation TopicModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
//        NSLog(@"%ld", value);
        self.ID = value;
    }

}


- (CGFloat)cellHeight
{
    
    if(!_cellHeight){
       
        //cell顶部的高度
        CGFloat textY = 70;
        
        //cell所占屏幕的狂宽度
        CGSize maxsize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
        
        //计算文字内容的高度
        CGFloat textH = [self.text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        //cell顶部的高度加上label的高度加上底部的高度
        _cellHeight = textY + textH + 44 + 10 + 10 + 10 + 20;

    
        if (self.type == 10) {
            
            
            CGFloat picW = maxsize.width;
            CGFloat picH = picW * self.height / self.width;
            
            //如果图品的高度超过一千 就让图片的高度变为250;
            if (picH > 1000) {
                picH = 250;
                self.isBigPic = YES;
            }
          
            CGFloat picX = 10;
            CGFloat picY = textY + textH + 10;
            
            self.pictureF = CGRectMake(picX, picY, picW, picH);
            
            _cellHeight += picH;
            
            
            NSDictionary *dic = [self.top_cmt firstObject];
            
            if (dic) {
                
                NSString *str = [NSString stringWithFormat:@"%@ : %@",dic[@"user"][@"username"],dic[@"content"]];
                
                CGFloat contextH = [str boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
                
                _cellHeight += 44 + contextH + 10 + 10;
                
                
            }
       
        }else if (self.type == 31){

            CGFloat voiceX = 10;
            CGFloat voiceY = textY + textH + 10;
            CGFloat voiceW = maxsize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            
            self.voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
          
            _cellHeight += voiceH;
        
         
        }else if (self.type == 41){
        
            CGFloat vedioX = 10;
            CGFloat vedioY = textY + textH + 10;
            CGFloat vedioW = maxsize.width;
            CGFloat vedioH = vedioW * self.height / self.width;
           
            self.vedioF = CGRectMake(vedioX, vedioY, vedioW, vedioH);
          
           _cellHeight += vedioH;
       
        }
         
        
        _cellHeight += 10;
        
   
    }

    return _cellHeight;
}
@end
