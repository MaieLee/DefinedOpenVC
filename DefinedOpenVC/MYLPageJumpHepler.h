//
//  MYLPageJumpHepler.h
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/21.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

//去掉警告
#define SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(code)   \
_Pragma("clang diagnostic push")                  \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")    \
code;                                                           \
_Pragma("clang diagnostic pop")

#define WS(weakSelf)  __weak __typeof(&*self) weakSelf = self;

@interface MYLPageJumpHepler : NSObject
- (id)initWithParent:(ViewController *)parentVc;
- (void)clientDefineAction:(NSDictionary *)dict;
- (void)clearNotift;
@end
