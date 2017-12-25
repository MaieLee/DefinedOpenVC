//
//  TestViewController.m
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/21.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import "TestViewController.h"
#import "UserEntity.h"

@interface TestViewController ()<UIAlertViewDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"TestViewController";
    self.navigationItem.leftBarButtonItem = self.defaultBackItem;
    NSString *msg = [NSString stringWithFormat:@"type:%@;userInfo->birthday:%@,name:%@",self.type,self.userInfo.birthday,self.userInfo.name];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"接收的参数" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
