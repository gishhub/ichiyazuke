//
//  QuestionViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/06/29.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import "QuestionViewController.h"
#import "SBJson.h"

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
    
    NSLog(@"QuestionViewController:問題IDは、%@",self.questionId);
    
    NSString *url = @"http://49.212.136.103:8080/ichiyazuke_web/select_question_by_id";
    
    /* GET */
    //NSString *url         = @"http://49.212.136.103:8080/ichiyazuke_web/select_question_by_id?questionId=3";
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    /* POST */
    NSString *keyValue = [@"questionId=" stringByAppendingString:self.questionId];
    NSData *post = [keyValue dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:post];

    NSData *response      = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    SBJsonParser *parser  = [[SBJsonParser alloc] init];
    NSArray *questions    = [parser objectWithData:response];

    //デバッグ用
    SBJsonWriter*	writer = [[SBJsonWriter alloc] init];
    writer.humanReadable   = YES;
    writer.sortKeys        = YES;
    NSLog(@"%@", [writer stringWithObject:questions]);

    for (NSDictionary *question in questions)
    {
        //NSLog(@"%@",[question objectForKey:@"title"]);
        //NSLog(@"%@ \n %@", [[tweet objectForKey:@"user"] objectForKey:@"screen_name"],[tweet objectForKey:@"text"]);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
