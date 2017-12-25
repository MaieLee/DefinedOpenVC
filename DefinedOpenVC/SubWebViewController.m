//
//  SubWebViewController.m
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/21.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import "SubWebViewController.h"

@interface SubWebViewController ()

@end

@implementation SubWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //这里注册该h5需要交互事件
    [self registerHandlerByActions:[NSArray arrayWithObjects:@"subAction",nil]];
}

//实现交互事件
- (void)subAction:(id)param
{
    NSLog(@"%@",param);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
