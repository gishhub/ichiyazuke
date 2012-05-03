//
//  BoardViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/05/03.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BoardViewController.h"
#import "SBJson.h"

@interface BoardViewController ()

@end

@implementation BoardViewController
@synthesize tweetLabel;

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTweetLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)tweetButton:(id)sender {
    NSString *url         = @"http://twitter.com/statuses/public_timeline.json";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *response      = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    SBJsonParser *parser  = [[SBJsonParser alloc] init];
    NSArray *tweets       = [parser objectWithData: response];
    
    for (NSDictionary *tweet in tweets)
    {
        NSString *tweettext      = [tweet objectForKey:@"text"];
        self.tweetLabel.text = tweettext;
        
        NSLog(@"%@ \n %@", [[tweet objectForKey:@"user"] objectForKey:@"screen_name"],[tweet objectForKey:@"text"]);
    }
}
@end
