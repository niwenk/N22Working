//
//  MANewsHtmlViewController.m
//  N22Working
//
//  Created by nwk on 2017/5/4.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MANewsHtmlViewController.h"

@interface MANewsHtmlViewController ()

@property (strong, nonatomic) UIWebView *htmlWebView;


@end

@implementation MANewsHtmlViewController


- (UIWebView *)htmlWebView {
    if (!_htmlWebView) {
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _htmlWebView = webView;
    }
    
    return _htmlWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.htmlWebView];
    
    [self.htmlWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.htmlUrl]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
