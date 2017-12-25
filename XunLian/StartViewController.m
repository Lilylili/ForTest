//
//  StartViewController.m
//  XunLian
//
//  Created by 李莉 on 28/11/2017.
//  Copyright © 2017 李莉. All rights reserved.
//

#import "StartViewController.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@interface StartViewController ()<WKUIDelegate, WKNavigationDelegate>
{
    MBProgressHUD *hud;
    BOOL shouldReLoad;
    
}

@property (strong, nonatomic) IBOutlet WKWebView *wkWeb;
@property (nonatomic, strong) UIImageView *splashImage;
@property (nonatomic, strong) NSTimer *splashTimer;
@property (nonatomic, strong) UILabel *notifiLab;
@property (nonatomic) Reachability *internetReachability;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    _wkWeb.UIDelegate = self;
    _wkWeb.navigationDelegate = self;
    shouldReLoad = NO;

     [_wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.infchain.com/com.inf.mall.inf-mall/d-app/API/login.html"]]];

   //network connect
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkChange:) name:kReachabilityChangedNotification object:nil];
    
    NetworkStatus status = [_internetReachability currentReachabilityStatus];
    if (status == 0) {
        shouldReLoad = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络不可用，请检查网络连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    _splashImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view bringSubviewToFront:_splashImage];
    [self.view addSubview:_splashImage];
    

    _splashTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(hideSplash) userInfo:nil repeats:NO];
    
    if (IS_IPHONE_5 ) {
        _splashImage.image = [UIImage imageNamed:@"IP5.jpg"];
        NSLog(@"5");
    }else if (IS_IPHONE_6) {
        _splashImage.image = [UIImage imageNamed:@"IP678.jpg"];
        NSLog(@"6");
        
    }else if (IS_IPHONE_6P) {
        _splashImage.image = [UIImage imageNamed:@"IPPlus.jpg"];
        NSLog(@"6+");
        
    }else if (IS_IPHONE_X) {
        _splashImage.image = [UIImage imageNamed:@"IPX.jpg"];
        NSLog(@"X");
        
    }else {
        _splashImage.image = [UIImage imageNamed:@"iPad.jpg"];
        NSInteger heigh = SCREEN_MAX_LENGTH;
        NSLog(@"--------%ld",(long)heigh);
    }
    hud = [[MBProgressHUD alloc] init];
    [self.view addSubview:hud];
    [hud showAnimated:YES];
//    hud.mode = MBProgressHUDModeDeterminate;
    hud.tintColor = [UIColor redColor];
    
}

-(void)hideSplash {
    
}

-(void)networkChange: (NSNotification *)notification {
    NetworkStatus status = [_internetReachability currentReachabilityStatus];
    if (status == 0) {
        //unreachable
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络不可用，请检查网络连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else {
        if (shouldReLoad == YES) {
            [_wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.infchain.com/com.inf.mall.inf-mall/d-app/API/login.html"]]];
            shouldReLoad = NO;
        }
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [UIView animateWithDuration:2 animations:^{
        _splashImage.alpha = 0;
        [_splashImage removeFromSuperview];
    }];
    [hud hideAnimated:YES];
}

/**
 *  加载失败时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 *  @param error      错误
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//internet connect
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络不可用，请检查网络连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
    
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
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
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
