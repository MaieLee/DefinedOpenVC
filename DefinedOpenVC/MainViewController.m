//
//  MainViewController.m
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/22.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "PINCache.h"
#import "SubWebViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"加载第一个h5" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(loadWebView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.center = self.view.center;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //外部调起进入首页，进行相对应跳转
    [self gotoOutSiteJumpPage];
}

//外部调起App，在没有运行的状态下，这里做跳转
- (void)gotoOutSiteJumpPage
{
    id extData = [[PINCache sharedCache] objectForKey:@"OutSideJumpExtData"];
    if (extData) {
        NSDictionary *params = (NSDictionary *)extData;
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appdelegate outsiteJump:params];
        
        [[PINCache sharedCache] removeObjectForKey:@"OutSideJumpExtData"];
    }
}

- (void)loadWebView
{
    SubWebViewController *sub = [[SubWebViewController alloc] init];
    sub.webUrl = @"http://www.yuekaihua.com/othersource/h5jump.html";
    [self.navigationController pushViewController:sub animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
