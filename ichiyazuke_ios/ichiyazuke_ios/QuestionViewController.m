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
    
    NSLog(@"問題画面でーす。問題IDは、%@",questionId);
    
    NSString *url         = @"http://twitter.com/statuses/public_timeline.json";
    
    /* GET */
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    /* POST */
    //NSString *keyValue = @"key1=val1&key2=val2";
    //NSData *post = [keyValue dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:url]];
    //[request setHTTPMethod:@"POST"];
    //[request setHTTPBody:post];
    
    NSData *response      = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    SBJsonParser *parser  = [[SBJsonParser alloc] init];
    NSArray *tweets       = [parser objectWithData: response];

    for (NSDictionary *tweet in tweets)
    {
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
