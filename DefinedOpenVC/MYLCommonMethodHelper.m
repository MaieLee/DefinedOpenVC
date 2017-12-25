//
//  MYLCommonMethodHelper.m
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/21.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import "MYLCommonMethodHelper.h"

@interface MYLCommonMethodHelper ()
@property (nonatomic, weak) ViewController *currentParentVc;
@end

@implementation MYLCommonMethodHelper

- (id)initWithParent:(ViewController *)parentVc
{
    self = [super init];
    if (self) {
        _currentParentVc = parentVc;
    }
    
    return self;
}

//分享到QQ
- (void)shareToQQ:(id)param
{
    NSLog(@"调用分享到QQ方法");
}
//分享到微信群、个人
- (void)shareToFriend:(id)param
{
    NSLog(@"调用分享到微信群、个人方法");
}
//分享到朋友圈
- (void)shareToTimeLine:(id)param
{
    NSLog(@"调用分享到朋友圈方法");
}
//加入购物车
- (void)addShopCar:(id)param
{
    NSLog(@"调用加入购物车方法");
}

- (void)clearNotift
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
