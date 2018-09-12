//
// Created by Luo Wei on 2017/12/8.
// Copyright (c) 2017 wodedata. All rights reserved.
//

#import "LWUIWebController.h"


@implementation LWUIWebController {

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.delegate = self;

    //    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.wodedata.com"]]];
    [self loadExamplePage];
}


- (void)loadExamplePage {
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"LWTest" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self.webView loadHTMLString:appHtml baseURL:baseURL];
}


#pragma mark - UIWebViewDelegate

//拦截URL
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    if ([[url scheme].lowercaseString isEqualToString:@"jscall"]) {

        [self handleCustomAction:url];

        NSArray *params = [url.query componentsSeparatedByString:@"&"];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        for (NSString *paramStr in params) {
            NSArray *dicArray = [paramStr componentsSeparatedByString:@"="];
            if (dicArray.count > 1) {
                NSString *decodeValue = [dicArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                tempDic[dicArray[0]] = decodeValue;
            }
        }
        NSLog(@"tempDic:%@", tempDic);
        return NO;
    }

    return YES;
}

//处理JSContext
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法, share就是调用的share方法名
    context[@"share"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");

        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JSCore方式" message:@"这是OC原生的弹出窗" delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
            [alertView show];
        });

        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal.toString);
        }

        NSLog(@"-------End Log-------");
    };
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
    [self.webView stringByEvaluatingJavaScriptFromString:jsStr];
}


@end