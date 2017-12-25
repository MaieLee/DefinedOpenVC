//
//  BaseWebViewController.h
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/21.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import "ViewController.h"

@interface BaseWebViewController : ViewController
@property (nonatomic, strong) UIWebView *webView;
/**
 *  需要加载的Url
 */
@property (nonatomic, copy) NSString *webUrl;

/**
 *  注册js响应事件，需要跟h5约定，不调用此方法时，跟js的交互走shouldStartLoadWithRequest实现
 *
 *  @param actions 方法事件
 */
- (void)registerHandlerByActions:(NSArray *)actions;

//---UIWebView delegate----//
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType;

- (void)webViewDidStartLoad:(UIWebView *)webView;

- (void)webViewDidFinishLoad:(UIWebView *)webView;

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end
