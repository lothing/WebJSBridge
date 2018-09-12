//
// Created by lothing on 2017/12/8.
// Copyright (c) 2017 wodedata. All rights reserved.
//

#import "LWMesageHandler.h"
#import "PPDJSBUtils.h"


PPDBLJSBHandler(test, PPDTestHandler);
@implementation PPDTestHandler

- (void)handlerWithData:(id)data responseCallback:(PPDJSBResponseCallback)responseCallback {
    [super handlerWithData:data responseCallback:responseCallback];

    [self responseWithStatus:PPDJSBResponseStatusSUCCESS data:@{@"name":@"xiaoli"}];

}

-(void)callback:(id)data {

}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end



PPDBLJSBHandler(getUserInfo, PPDGetUserInfoHandler);
@implementation PPDGetUserInfoHandler

- (void)handlerWithData:(id)data responseCallback:(PPDJSBResponseCallback)responseCallback {
    [super handlerWithData:data responseCallback:responseCallback];

    [self responseWithStatus:PPDJSBResponseStatusSUCCESS data:@"xiaoli"];

}

-(void)callback:(id)data {

}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end



PPDBLJSBHandler(openWin, PPDOpenWinHandler);
@implementation PPDOpenWinHandler

- (void)handlerWithData:(id)data responseCallback:(PPDJSBResponseCallback)responseCallback {
    [super handlerWithData:data responseCallback:responseCallback];

    NSString *url = [data objectForKey:@"url"];
    NSDictionary *params = [data objectForKey:@"params"];

    [[PPDBLURLNavigatorAdapter sharedInstance] openUrl:[NSURL URLWithString:url] withTarget:[PPDJSBUtils topViewController] params:params];
}

- (void)callback:(id)data {

}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end


PPDBLJSBHandler(closeWin, PPDPopWinHandler);
@implementation PPDPopWinHandler

- (void)handlerWithData:(id)data responseCallback:(PPDJSBResponseCallback)responseCallback {
    [super handlerWithData:data responseCallback:responseCallback];

    UIViewController *topViewController = [PPDJSBUtils topViewController];
    if (topViewController.navigationController) {
        [topViewController.navigationController popViewControllerAnimated:YES];
    } else {
        [topViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end




PPDBLJSBHandler(titleBar, PPDNavigationBarHandler);
@implementation PPDNavigationBarHandler

- (void)handlerWithData:(id)data responseCallback:(PPDJSBResponseCallback)responseCallback {
    [super handlerWithData:data responseCallback:responseCallback];

    NSString *title = [data objectForKey:@"title"];
    if (title) {
        self.targetController.title = title;
    }
}

- (void)callback:(id)data {

}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end




PPDBLJSBHandler(userLogin, PPDUserLoginHandler);
@implementation PPDUserLoginHandler

- (void)handlerWithData:(id)data responseCallback:(PPDJSBResponseCallback)responseCallback {
    [super handlerWithData:data responseCallback:responseCallback];

    [[PPDBLURLNavigatorAdapter sharedInstance] openUrl:[NSURL URLWithString:@"wodedata://page.ppd/userlogin"] withTarget:[PPDJSBUtils topViewController] params:nil];
}

- (void)callback:(id)data {
    self.targetController.title = [NSString stringWithFormat:@"已登录，用户名：%@", [data objectForKey:@"name"]];
    [self responseWithStatus:PPDJSBResponseStatusSUCCESS data:data];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end