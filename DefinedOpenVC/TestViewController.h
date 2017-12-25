//
//  TestViewController.h
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/21.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import "ViewController.h"
@class UserEntity;

@interface TestViewController : ViewController
{
    NSString *selfVal;
}

@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) UserEntity *userInfo;

@end
