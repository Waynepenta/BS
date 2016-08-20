//
//  MeWebViewController.m
//  BS
//
//  Created by lanou on 16/8/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MeWebViewController.h"
#import "NJKWebViewProgress.h"

@interface MeWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForward;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *webRefresh;
@property (nonatomic,strong) NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation MeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.WebView.backgroundColor = [UIColor whiteColor];
    [self.WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.progress = [[NJKWebViewProgress alloc] init];
    
    self.WebView.delegate = self.progress;
    
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress){
    
        weakSelf.progressView.progress = progress;
    };
    self.progress.webViewProxyDelegate = self;
  
    self.tabBarController.view.backgroundColor = [UIColor whiteColor];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)webRefresh:(id)sender {
    
    [self.WebView reload];
}
- (IBAction)goBack:(id)sender {
    
    [self.WebView goBack];
    
}
- (IBAction)goForward:(id)sender {
    [self.WebView goForward];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (![self.url hasPrefix:@"http"]) {
        return;
    }
    
//    self.progressView.hidden = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.progressView.hidden = YES;
    });

    
    
    self.goBack.enabled = [webView canGoBack];
    self.goForward.enabled = [webView canGoForward];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    self.progressView.progress = 0;

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
