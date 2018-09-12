//
// Created by lothing on 2017/12/8.
// Copyright (c) 2017 wodedata. All rights reserved.
//

#import "PPDJSBUtils.h"


@implementation PPDJSBUtils

+ (UIViewController *)topViewController {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    UIViewController *target = nil;
    if (rootViewController) {
        if ([rootViewController isKindOfClass:[UITabBarController class]]) {
            UIViewController *selectedObject = ((UITabBarController *)rootViewController).selectedViewController;
            if ([selectedObject isKindOfClass:[UINavigationController class]]) {
                target = ((UINavigationController *)selectedObject).topViewController;
            } else {
                target = selectedObject;
            }
        } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
            target = ((UINavigationController *)rootViewController).topViewController;
        } else {
            target = rootViewController;
        }
    }
    return target;
}
@end