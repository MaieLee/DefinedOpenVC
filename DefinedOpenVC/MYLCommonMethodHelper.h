//
//  MYLCommonMethodHelper.h
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/21.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface MYLCommonMethodHelper : NSObject
- (id)initWithParent:(ViewController *)parentVc;
//分享到QQ
- (void)shareToQQ:(id)param;
//分享到微信群、个人
- (void)shareToFriend:(id)param;
//分享到朋友圈
- (void)shareToTimeLine:(id)param;
//加入购物车
- (void)addShopCar:(id)param;

- (void)clearNotift;
@end
