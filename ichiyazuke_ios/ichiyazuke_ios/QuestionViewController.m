//
//  QuestionViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/06/29.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import "QuestionViewController.h"
#import "AnswerViewController.h"
#import "GTMHTTPFetcher.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

@synthesize questionId;
@synthesize questionTitle;
@synthesize contents;
@synthesize choice1;
@synthesize choice2;
@synthesize choice3;
@synthesize choice4;
@synthesize answer;
@synthesize explanation;
@synthesize correct;

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

    self.title = @"問題";

    NSString *url = @"http://49.212.136.103:8080/ichiyazuke_web/select_question_by_id";

    /* POST */
    NSString *keyValue           = [@"questionId=" stringByAppendingString:self.questionId];
    NSData *post                 = [keyValue dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:post];

    NSData  *response  = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *jsonError = nil;
    NSArray *question  = [NSJSONSerialization JSONObjectWithData:response
                                                        options:0
                                                          error:&jsonError];

    // JSONデータのパースエラー
    if (question == nil) {
        NSLog(@"JSON Parser error: %d", jsonError.code);
        return;
    }

    questionTitle = [(NSDictionary *)question objectForKey:@"title"];
    contents      = [(NSDictionary *)question objectForKey:@"contents"];
    choice1       = [(NSDictionary *)question objectForKey:@"choice1"];
    choice2       = [(NSDictionary *)question objectForKey:@"choice2"];
    choice3       = [(NSDictionary *)question objectForKey:@"choice3"];
    choice4       = [(NSDictionary *)question objectForKey:@"choice4"];
    answer        = [(NSDictionary *)question objectForKey:@"answer"];
    explanation   = [(NSDictionary *)question objectForKey:@"explanation"];

    // デバッグ
    NSLog(@"questionTitle:%@", questionTitle);
    NSLog(@"contents:%@", contents);
    NSLog(@"choice1:%@", choice1);
    NSLog(@"choice2:%@", choice2);
    NSLog(@"choice3:%@", choice3);
    NSLog(@"choice4:%@", choice4);
    NSLog(@"answer:%@", answer);
    NSLog(@"explanation:%@", explanation);

    CGRect frame            = [[UIScreen mainScreen] applicationFrame];
    CGRect rect             = CGRectMake(0,0,frame.size.width, frame.size.height);
    UIWebView *webView      = [[UIWebView alloc] initWithFrame:rect];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];

	NSString     *path       = [[NSBundle mainBundle] pathForResource:@"math" ofType:@"html"];
    NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSString     *htmlString = [[NSString alloc] initWithData:[readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];

    [webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:path]];

    // 回答ボタン配置
    UIButton *choiceBtn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    choiceBtn1.frame = CGRectMake(10, 200, 100, 30);
    choiceBtn1.tag = 1;
    [choiceBtn1 setTitle:choice1 forState:UIControlStateNormal];
    [choiceBtn1 addTarget:self
                   action:@selector(goAnswer:)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:choiceBtn1];

    UIButton *choiceBtn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    choiceBtn2.frame = CGRectMake(120, 200, 100, 30);
    choiceBtn2.tag = 2;
    [choiceBtn2 setTitle:choice2 forState:UIControlStateNormal];
    [choiceBtn2 addTarget:self
                   action:@selector(goAnswer:)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:choiceBtn2];

    UIButton *choiceBtn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    choiceBtn3.frame = CGRectMake(10, 240, 100, 30);
    choiceBtn3.tag = 3;
    [choiceBtn3 setTitle:choice3 forState:UIControlStateNormal];
    [choiceBtn3 addTarget:self
                   action:@selector(goAnswer:)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:choiceBtn3];

    UIButton *choiceBtn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    choiceBtn4.frame = CGRectMake(120, 240, 100, 30);
    choiceBtn4.tag = 4;
    [choiceBtn4 setTitle:choice4 forState:UIControlStateNormal];
    [choiceBtn4 addTarget:self
                   action:@selector(goAnswer:)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:choiceBtn4];

    [self webViewDidFinishLoad:webView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%@",@"webViewDidFinishLoad");

    NSMutableString *javascript = [NSMutableString string];
    //[javascript appendString:@"var tex4 = encodeURIComponent('$ \\sin(90^\\circ + \\theta) = \\cos \\theta$');"];
    [javascript appendString:@"document.write('<img src=hoge>');"];

    NSString *output = [webView  stringByEvaluatingJavaScriptFromString: @"document.documentElement.clientHeight;"];
    int contentHeight = [output intValue];
    NSLog(@"contentHeight is %d", contentHeight);
}

- (void)goAnswer:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    NSInteger answerNumber = [answer intValue];

    // 正解判定
    if(tag == answerNumber) {
        NSLog(@"%@",@"正解");
        correct = @"1";
        AnswerViewController *answerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"answerViewController"];
        [self.navigationController pushViewController:answerViewController animated:YES];
    } else {
        NSLog(@"%@",@"不正解");
        correct = @"0";
        AnswerViewController *answerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"answerViewController"];
        [self.navigationController pushViewController:answerViewController animated:YES];
    }
}

@end
