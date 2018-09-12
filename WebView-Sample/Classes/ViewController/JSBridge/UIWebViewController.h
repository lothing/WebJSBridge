//
//  UIWebViewController.h
//  WebView-Sample
//
//  Created by lothing on 2017/12/8.
//  Copyright © 2017年 wodedata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) PPDBLWebViewJSBridge *bridge;

@end
