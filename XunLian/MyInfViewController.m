//
//  MyInfViewController.m
//  XunLian
//
//  Created by 李莉 on 28/11/2017.
//  Copyright © 2017 李莉. All rights reserved.
//

#import "MyInfViewController.h"
#import <WebKit/WebKit.h>

@interface MyInfViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (strong, nonatomic) IBOutlet WKWebView *myNFWeb;

@end

@implementation MyInfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _myNFWeb.UIDelegate = self;
    _myNFWeb.navigationDelegate = self;
    
    [_myNFWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.infchain.com/d-app/API/book/myInf"]]];
}

#pragma mark - WKNavigationDelegate

/**
 *  页面开始加载时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  当内容开始返回时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  页面加载完成之后调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  加载失败时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 *  @param error      错误
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  接收到服务器跳转请求之后调用
 *
 *  @param webView      实现该代理的webview
 *  @param navigation   当前navigation
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    // 如果响应的地址是百度，则允许跳转
    //    if ([navigationResponse.response.URL.host.lowercaseString isEqual:@"www.baidu.com"]) {
    
    // 允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //        return;
    //    }
    //    // 不允许跳转
    //    decisionHandler(WKNavigationResponsePolicyCancel);
}

/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    // 如果请求的是百度地址，则延迟5s以后跳转
    //    if ([navigationAction.request.URL.host.lowercaseString isEqual:@"www.baidu.com"]) {
    
    //        // 延迟5s之后跳转
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //            // 允许跳转
    //            decisionHandler(WKNavigationActionPolicyAllow);
    //        });
    
    // 允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //        return;
    //    }
    //    // 不允许跳转
    //    decisionHandler(WKNavigationActionPolicyCancel);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
