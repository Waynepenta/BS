//
//  ShowPicViewController.m
//  BS
//
//  Created by lanou on 16/8/10.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ShowPicViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "GameViewController.h"

@interface ShowPicViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *showScrollview;
@property (nonatomic,strong) UIImageView *imageV;

@end

@implementation ShowPicViewController


- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)save:(id)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.imageV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
   
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    }else{
    
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
        
        dispatch_time_t tim = dispatch_time(DISPATCH_TIME_NOW, (int64_t)1*NSEC_PER_SEC);
        
        dispatch_after(tim, dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
        });
        
    }
    


}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
   
    
    
    self.imageV = [[UIImageView alloc] init];
    
    [self.showScrollview addSubview:_imageV];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat picW = screenW;
    CGFloat picH = picW * self.model.height / self.model.width;
    
    if (picH > screenH) {
        
        self.imageV.frame = CGRectMake(0, 0, picW, picH);
        self.showScrollview.contentSize = CGSizeMake(0, picH);
    
        
    }else{
        self.imageV.size = CGSizeMake(picW, picH);
        self.imageV.centerY = screenH * 0.5;
        
        
    
    }
    
    
    
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString: self.model.image0] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        
    }];
    
    self.imageV.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action)];
    
    [self.imageV addGestureRecognizer:tap];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)action
{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
   
  

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
