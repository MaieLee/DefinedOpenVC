//
//  MYLPageJumpHepler.m
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/21.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import "MYLPageJumpHepler.h"
#import "MYLCommonMethodHelper.h"
#import <objc/runtime.h>
#import "MJExtension.h"
#import "BaseWebViewController.h"

@interface MYLPageJumpHepler ()

@property (nonatomic, strong) MYLCommonMethodHelper *methodHandle;
@property (nonatomic, weak) ViewController *currentParentVc;
@end

@implementation MYLPageJumpHepler

- (id)initWithParent:(ViewController *)parentVc
{
    self = [super init];
    if (self) {
        _currentParentVc = parentVc;
        _methodHandle = [[MYLCommonMethodHelper alloc] initWithParent:parentVc];
    }
    
    return self;
}

#pragma mark ------ 监听预留事件
- (void)clientDefineAction:(NSDictionary *)dict
{
    NSInteger type = [[dict objectForKey:@"type"] integerValue];
    NSString *controllName = [dict objectForKey:@"controll"];
    NSDictionary *params = [dict objectForKey:@"params"];
    
    if (type == 0) {
        //调方法
        SEL methodsel = NSSelectorFromString([NSString stringWithFormat:@"%@:",controllName]);
        if ([self.methodHandle respondsToSelector:methodsel]) {
            SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(
                                                   [self.methodHandle performSelector:methodsel withObject:params];
                                                   );
        }
    }else{
        //调页面
        NSString *class = [controllName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([class isEqualToString:@"tab1"]) {
            //跳tab1
            return;
        }
        
        if ([class isEqualToString:@"tab2"]) {
            //跳tab2
            return;
        }
        
        if ([class isEqualToString:@"tab3"]) {
            //跳tab3
            return;
        }
        
        if ([class isEqualToString:@"tab4"]) {
            //跳tab4
            return;
        }
        
        if ([class isEqualToString:@"ViewController"]) {
            return;
        }
        
        [self findRightRoutedWithClass:class Params:params];
    }
}

- (void)findRightRoutedWithClass:(NSString *)class Params:(NSDictionary *)params
{
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass){
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    
    WS(weakSelf);
    if (params) {
        // 对该对象赋值属性
        NSDictionary * propertys = params;
        [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([key isEqualToString:@"entity"]) {
                //对象类型属性
                NSDictionary *entitys = [propertys objectForKey:key];
                [entitys enumerateKeysAndObjectsUsingBlock:^(NSString *ckey, id entityObj, BOOL *s) {
                    NSArray *entityParamArray = [ckey componentsSeparatedByString:@"_"];
                    
                    if (entityParamArray.count > 0) {
                        const char *className = [entityParamArray[0] cStringUsingEncoding:NSASCIIStringEncoding];
                        Class entity = objc_getClass(className);
                        // 创建对象
                        id entiy_instance = [entity objectWithKeyValues:entityObj];//使用MJExtension解析对象
                        if ([weakSelf checkIsExistPropertyWithInstance:instance verifyPropertyName:entityParamArray[1]]) {
                            // 利用kvc赋值
                            [instance setValue:entiy_instance forKey:entityParamArray[1]];
                        }
                    }
                }];
            }else{
                //普通类型属性
                if ([weakSelf checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
                    // 利用kvc赋值
                    [instance setValue:obj forKey:key];
                }
            }
        }];
    }
    
    [self.currentParentVc.navigationController pushViewController:instance animated:YES];
}

- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount,i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    
    outCount = 0;
    if ([instance isKindOfClass:[BaseWebViewController class]]) {
        properties = class_copyPropertyList([BaseWebViewController class], &outCount);
        
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            //  属性名转成字符串
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            if ([propertyName isEqualToString:verifyPropertyName]) {
                free(properties);
                return YES;
            }
        }
    }
    
    free(properties);
    
    //这里处理UIViewController特定属性
    if ([verifyPropertyName isEqualToString:@"title"]) {
        return YES;
    }
    
    return NO;
}

- (void)clearNotift
{
    [_methodHandle clearNotift];
    _methodHandle = nil;
}

@end
