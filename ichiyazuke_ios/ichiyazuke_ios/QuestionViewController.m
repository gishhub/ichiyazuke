//
//  QuestionViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/06/29.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

@synthesize questionId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)configureView
{
    NSString *url = @"http://49.212.136.103:8080/ichiyazuke_web/select_question_by_id";
    //NSString *url = @"http://localhost:8080/ichiyazuke_web/select_question_by_id";
    
    /* POST */
    NSString *keyValue           = [@"questionId=" stringByAppendingString:self.questionId];
    NSData *post                 = [keyValue dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:post];

    // デバッグ
    NSLog(@"questionID:%@", self.questionId);

    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    webView      = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,frame.size.width, frame.size.height)];
    NSLog(@"初期値です");
    NSLog(@"幅：%f",frame.size.width);
    NSLog(@"高さ：%f",frame.size.height);
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];

    [webView loadRequest:request];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait
            || interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight
            || interfaceOrientation == UIInterfaceOrientationMaskPortraitUpsideDown);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    toInterfaceOrientation = self.interfaceOrientation;
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationMaskPortraitUpsideDown) {
        CGRect frame = [[UIScreen mainScreen] applicationFrame];
        webView.frame  = CGRectMake(0,0,frame.size.width, frame.size.height);
        NSLog(@"縦です");
        NSLog(@"幅：%f",frame.size.width);
        NSLog(@"高さ：%f",frame.size.height);
    } else {
        CGRect frame = [[UIScreen mainScreen] applicationFrame];
        webView.frame  = CGRectMake(0,0,frame.size.width, frame.size.height);
        NSLog(@"横です");
        NSLog(@"幅：%f",frame.size.width);
        NSLog(@"高さ：%f",frame.size.height);
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
