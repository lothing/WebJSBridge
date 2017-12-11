//
//  WKWebViewController.m
//  WebView-Sample
//
//  Created by Luo Wei on 2017/12/8.
//  Copyright © 2017年 wodedata. All rights reserved.
//

#import "WKWebViewController.h"

@interface WKWebViewController ()<WKNavigationDelegate, WKUIDelegate>

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.webView.UIDelegate = self;cp
    self.webView.navigationDelegate = self;


    [PPDBLWebViewJSBridge enableLogging];
    _bridge = [PPDBLWebViewJSBridge bridge:self.webView];
    [_bridge setWebViewDelegate:self];

    //    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.ppdai.com"]]];
    [self loadExamplePage];
}

- (void)loadExamplePage {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self.webView loadHTMLString:appHtml baseURL:baseURL];
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:webView.title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
