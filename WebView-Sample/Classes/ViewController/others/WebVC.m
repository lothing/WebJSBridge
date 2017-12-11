//
//  WebVC.m
//  PPDBLWebViewJSBridge
//
//  Created by wanyakun on 2017/5/15.
//  Copyright © 2017年 wanyakun. All rights reserved.
//

#import "WebVC.h"
#import <WebKit/WebKit.h>
//@import PPDBLWebViewJSBridge;

@interface WebVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) PPDBLWebViewJSBridge *bridge;


@end

PPDBLURLMapping(page.ppd/webvc, WebVC, "[]");
//PPDBLURLMapping(page.ppd/webvc, WebVC, "[{\"type\":\"string\", \"attr_name\":\"url\", \"map_key\":\"url\"}]");
@implementation WebVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.webView];
    [PPDBLWebViewJSBridge enableLogging];
    _bridge = [PPDBLWebViewJSBridge bridge:self.webView];
    [_bridge setWebViewDelegate:self];
    
    if (self.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    } else {
        [self loadExamplePage];
    }
//    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
//    [self loadExamplePage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.webView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)loadExamplePage {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ppdtest" ofType:@"html"];
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


#pragma mark - getter
- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.opaque = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
    return _webView;
}
@end
