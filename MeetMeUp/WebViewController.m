//
//  WebViewController.m
//  MeetMeUp
//
//  Created by Jonathan Chou on 11/3/14.
//  Copyright (c) 2014 Jonathan Chou. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:self.request];
    // Do any additional setup after loading the view.
}

- (void)loadURL:(NSURLRequest *)request
{
    [self.webView loadRequest: request];
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
