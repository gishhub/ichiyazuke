//
//  AnswerViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/09/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AnswerViewController.h"
#import "PanelViewController.h"
#import "QuestionViewController.h"

@interface AnswerViewController ()

@end

@implementation AnswerViewController

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
    
    // 戻るボタン隠す
    self.navigationItem.hidesBackButton = YES;

    //ひとつ前のViewControllerを取得するために配列を使う
    NSArray *naviArray = [self.navigationController viewControllers];
    NSInteger nowIndex = [naviArray count];
    QuestionViewController *questionViewController = (QuestionViewController *)[naviArray objectAtIndex:nowIndex-2];
    NSString *answer      = questionViewController.answer;
    NSString *explanation = questionViewController.explanation;
    NSInteger *result     = (NSInteger *)[questionViewController.correct integerValue];

    CGRect frame            = [[UIScreen mainScreen] applicationFrame];
    CGRect rect             = CGRectMake(0,0,frame.size.width, frame.size.height);
    UIWebView *webView      = [[UIWebView alloc] initWithFrame:rect];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];

    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html><body>"];

    if(result == 1) {
        NSLog(@"%@",@"正解");
        [html appendString:@"<h1>正解</h1>"];
    } else {
        NSLog(@"%@",@"不正解");
        [html appendString:@"<h1>不正解</h1>"];
    }

    [html appendString:@"<h2>答え</h2>"];
    [html appendString:answer];
    [html appendString:@"<h2>解説</h2>"];
    [html appendString:explanation];
    [html appendString:@"</body></html>"];

    NSLog(@"%@",html);
    NSData *bodyData = [html dataUsingEncoding:NSUTF8StringEncoding];

    [webView loadData:bodyData MIMEType:@"text/html"textEncodingName:@"utf-8"baseURL:nil];

    // PanelViewControllerに戻るボタン
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(50, 200, 200, 30);
    [backBtn setTitle:@"パネル画面へ戻る" forState:UIControlStateNormal];
    [backBtn addTarget:self
                action:@selector(returnPanelView:)
      forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:backBtn];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)returnPanelView:(UIButton *)sender
{
    // PanelViewController取得
    NSArray *naviArray = [self.navigationController viewControllers];
    NSInteger nowIndex = [naviArray count];
    PanelViewController    *panelViewController    = (PanelViewController *)[naviArray objectAtIndex:nowIndex-3];
    QuestionViewController *questionViewController = (QuestionViewController *)[naviArray objectAtIndex:nowIndex-2];

    NSString *result = questionViewController.correct;
    
    // 正解か不正解かの情報を送信する
    NSString *url                = @"http://49.212.136.103:8080/ichiyazuke_web/update_infomation";
    NSString *keyValue           = [NSString stringWithFormat:@"personalId=%@&questionId=%@&result=%@", panelViewController.personalId, questionViewController.questionId, result];
    NSData *post                 = [keyValue dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:post];
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    // PanelViewControllerに戻る
    [self.navigationController popToViewController:panelViewController animated:YES];
}

@end
