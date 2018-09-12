//
//  WKWebViewController.h
//  WebView-Sample
//
//  Created by lothing on 2017/12/8.
//  Copyright © 2017年 wodedata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WKWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (nonatomic, strong) PPDBLWebViewJSBridge *bridge;

@end
