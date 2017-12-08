//
//  PPDLoginViewController.m
//  PPDBLWebViewJSBridge
//
//  Created by wanyakun on 2017/5/16.
//  Copyright © 2017年 wanyakun. All rights reserved.
//

#import "PPDLoginViewController.h"

@interface PPDLoginViewController ()

@property (nonatomic, strong) UIButton *loginButton;

@end
PPDBLURLMapping(page.ppd/userlogin, PPDLoginViewController, "[]");
@implementation PPDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginButton];
    self.loginButton.frame = CGRectMake(100, 100, 50, 100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loginButtonDidTouchUpInside {
    //登录成功，发送异步回调
    [PPDBLBaseJSBMessageHandler sendMsgWithHandlerName:@"userLogin" data:@{@"name":@"xiaoli"}];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonDidTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

@end
