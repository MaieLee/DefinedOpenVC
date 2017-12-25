//
//  BaseWebViewController.m
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/21.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import "BaseWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "MYLPageJumpHepler.h"

@interface BaseWebViewController ()<UIWebViewDelegate>
@property WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) MYLPageJumpHepler *pageHandle;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.defaultBackItem;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    
    NSURL *url = [NSURL URLWithString:_webUrl];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self registerHandlerByActions:[NSArray arrayWithObjects:@"clientDefineAction",nil]];
    _pageHandle = [[MYLPageJumpHepler alloc] initWithParent:self];
}

- (void)navBack:(id)sender
{
    if ([_webView canGoBack]) {
        [_webView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------ 注册交互事件
- (void)registerHandlerByActions:(NSArray *)actions
{
    //    [WebViewJavascriptBridge enableLogging];
    if (_bridge == nil) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
        [_bridge setWebViewDelegate:self];
    }
    WS(weakSelf);
    for (NSString *actionStr in actions) {
        [_bridge registerHandler:actionStr handler:^(id data, WVJBResponseCallback responseCallback) {
            NSDictionary *dataDict = (NSDictionary *)data;
            SEL methodsel = NSSelectorFromString([NSString stringWithFormat:@"%@:",actionStr]);
            if ([weakSelf respondsToSelector:methodsel]) {
                SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(
                                                       [weakSelf performSelector:methodsel withObject:dataDict];
                                                       );
            }
        }];
    }
}

#pragma mark ------ 监听预留事件
- (void)clientDefineAction:(NSDictionary *)dict
{
    [self.pageHandle clientDefineAction:dict];
}

#pragma mark ------ webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"requestURL:%@",webView.request.URL.absoluteString);
    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title.length > 0) {
        self.title = title;
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    static BOOL isRequest = YES;
    
    if (isRequest) {
        NSHTTPURLResponse *response = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        if (response.statusCode == 404) {
            return NO;
        } else if (response.statusCode == 403) {
            return NO;
        }
        [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[request URL]];
        //网络出问题
        if (response == nil || response.statusCode == 404 || response.statusCode == 502 || response.statusCode == NSURLErrorTimedOut || response.statusCode == NSURLErrorNetworkConnectionLost || response.statusCode == NSURLErrorNotConnectedToInternet){
            isRequest = YES;
        }else
        {
            isRequest = NO;
        }
        
        return NO;
    }
    
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error.code == 404 || error.code == 502 || error.code == NSURLErrorTimedOut || error.code == NSURLErrorNetworkConnectionLost || error.code == NSURLErrorNotConnectedToInternet){
        self.title = @"加载出错";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (_bridge) {
        _bridge = nil;
    }
    _webView.delegate = nil;
    _webView = nil;
    
    if (_pageHandle) {
        [_pageHandle clearNotift];
        _pageHandle = nil;
    }
}

@end
