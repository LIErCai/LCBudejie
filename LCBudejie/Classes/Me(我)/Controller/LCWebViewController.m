//
//  LCWebViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCWebViewController.h"
#import <WebKit/WebKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
@interface LCWebViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goOnButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


@property (nonatomic, weak) WKWebView *webView;

@end

@implementation LCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [SVProgressHUD showWithStatus:@"正在加载"];
    [self setupWebview];
    
}

- (void)setupWebview
{
    WKWebView *webView = [[WKWebView alloc] init];
    [self.contentView addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.webView = webView;
    
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
     [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    
//    [SVProgressHUD dismiss];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.backButton.enabled = self.webView.canGoBack;
    self.goOnButton.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    double progress = self.webView.estimatedProgress;
    self.progressView.progress = progress;
    if (progress >= 1)
    {
        self.progressView.hidden = YES;
//        [SVProgressHUD dismiss];
    }
    

    
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.webView.frame = self.contentView.bounds;
}
- (IBAction)back:(UIButton *)sender {
    [self.webView goBack];
}

- (IBAction)on:(UIButton *)sender {
    [self.webView goForward];
}

- (IBAction)refresh:(UIButton *)sender {
    [self.webView reload];
    
}

@end
