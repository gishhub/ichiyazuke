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

@synthesize myWebView;
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

    CGRect frame = [[UIScreen mainScreen] bounds];
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
    self.myWebView.scalesPageToFit = YES;
    self.myWebView.delegate = self;
    [self.view addSubview:self.myWebView];

    [self.myWebView loadRequest:request];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

// ios5.1用の記述
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

// ios6.0用の記述
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration
{
	UIInterfaceOrientation toInterfaceOrientation = self.interfaceOrientation;
	if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        CGRect frame = [[UIScreen mainScreen] bounds];
        self.myWebView.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
	} else {
        CGRect frame = [[UIScreen mainScreen] bounds];
        self.myWebView.frame = CGRectMake(0,0,frame.size.height,frame.size.width);
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
