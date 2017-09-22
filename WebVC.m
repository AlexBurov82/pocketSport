//
//  WebVC.m
//  pocketSport
//
//  Created by Александр on 13.02.17.
//
//

#import "WebVC.h"

@interface WebVC ()

@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.stringURL) {
        [self loadWebView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebView {
    
    NSURLRequest *request;
    
    if([[self.stringURL lowercaseString] hasPrefix:[@"http://" lowercaseString]]) {
        
        NSString *urlString = self.stringURL;
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        request = [NSURLRequest requestWithURL:url];
        
    } else {
        
        NSString *urlString = [NSString stringWithFormat:@"http://%@", self.stringURL];
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        request = [NSURLRequest requestWithURL:url];
    }
    
    [self.webView loadRequest:request];
    
    self.webView.scalesPageToFit = YES;
}

@end
