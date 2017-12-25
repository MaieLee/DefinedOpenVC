//
//  AppDelegate.h
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/21.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 * 外部调起app跳转到相对应页面
 **/
- (void)outsiteJump:(NSDictionary *)params;

@end

