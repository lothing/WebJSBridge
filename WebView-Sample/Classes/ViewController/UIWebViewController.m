//
//  UIWebViewController.m
//  WebView-Sample
//
//  Created by Luo Wei on 2017/12/8.
//  Copyright © 2017年 wodedata. All rights reserved.
//

#import "UIWebViewController.h"

@interface UIWebViewController ()

@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.webView.delegate = self;

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

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"Request: %@", request);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


@end
