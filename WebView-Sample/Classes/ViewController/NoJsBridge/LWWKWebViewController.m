//
// Created by Luo Wei on 2017/12/8.
// Copyright (c) 2017 wodedata. All rights reserved.
//

#import "LWWKWebViewController.h"


@implementation LWWKWebViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;

    WKWebViewConfiguration *configuration = self.webView.configuration;
    //注册js方法
    [configuration.userContentController addScriptMessageHandler:self name:@"webViewApp"];

    [self loadExamplePage];
}

- (void)loadExamplePage {
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"LWTest" ofType:@"html"];
//    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
//    [self.webView loadHTMLString:appHtml baseURL:baseURL];

    NSURL *fileURL = [NSURL fileURLWithPath:htmlPath];
    [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
}


#pragma mark - WKNavigationDelegate

//拦截URL
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme.lowercaseString isEqualToString:@"jscall"]) {
        [self handleCustomAction:URL];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark - WKScriptMessageHandler

//处理js调用消息
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"======message.name:%@",message.name);
    NSLog(@"======message.body:%@",message.body);

    NSString *msgText = [NSString stringWithFormat:@"这是OC原生的弹出窗\n message.name:%@ \n message.body:%@",message.name,message.body];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"WKScriptMessageHandler方式" message:msgText delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
    [alertView show];
}



#pragma mark - private method

- (void)handleCustomAction:(NSURL *)URL {

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"URL Scheme方式" message:@"这是OC原生的弹出窗" delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
    [alertView show];

    NSString *host = [URL host];
    if ([host isEqualToString:@"getLocation"]) {
        [self getLocation];
    }
}

- (void)getLocation {
    //todo:获取位置信息

    //将结果返回给js
    NSString *jsStr = [NSString stringWithFormat:@"setLocation('%@')", @"上海市浦东新区丹桂路XXX号"];
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError *_Nullable error) {
        NSLog(@"%@----%@", result, error);
    }];
}


@end