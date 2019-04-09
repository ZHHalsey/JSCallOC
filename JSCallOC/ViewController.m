//
//  ViewController.m
//  JSCallOC
//
//  Created by ZH on 2019/4/9.
//  Copyright © 2019 张豪. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKScriptMessageHandler>
@property (nonatomic, strong)WKWebView *wkWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    // 创建WKWebView视图(想JS回调OC的话, 别忘了后面加上那个config)
    self.wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(20, 60, self.view.bounds.size.width - 40, 500) configuration:config];
    self.wkWebView.backgroundColor = [UIColor redColor];
    // 本地html
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"aaaaaa" withExtension:@"html"]; // 这一行和下面两行效果一样
    NSString *path = [[NSBundle mainBundle] pathForResource:@"aaaaaa" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.wkWebView];
     // JS和OC产生联系的地方就是下面这行代码, 可以添加多个回调
    [config.userContentController addScriptMessageHandler:self name:@"call_back"];
    [config.userContentController addScriptMessageHandler:self name:@"call_back2"];
}
#pragma mark - WKScriptMessageHandler代理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    // 点击html里面的按钮, 来到这里有打印, 就说明成功来到了原生方法
    NSLog(@"约定的name--%@", message.name);// 这个name不是方法的name, 是跟后台约定的name
    NSLog(@"参数--%@", message.body);// js传过来的参数
    
}


@end
