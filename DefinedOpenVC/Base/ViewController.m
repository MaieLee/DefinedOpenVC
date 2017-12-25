//
//  ViewController.m
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/21.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UIBarButtonItem *)defaultBackItem{
    //push vc model
    NSString *title = self.parentViewController.title;
    NSInteger count = self.navigationController.viewControllers.count;
    if (count > 1) {
        title = self.navigationController.viewControllers[count-2].title;
    }
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] init];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
    [btn setTitle:[NSString stringWithFormat:@"  %@",title] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navBack:) forControlEvents:UIControlEventTouchUpInside];

    leftItem.customView = btn;
    
    return leftItem;
}

- (void)navBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
