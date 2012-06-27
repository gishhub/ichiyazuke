//
//  PanelViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/06/28.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import "PanelViewController.h"
#import "SBJson.h"

@interface PanelViewController ()

@end

@implementation PanelViewController

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
    
    NSURL    *imageUrl01     = [NSURL URLWithString:@"http://profile.ak.fbcdn.net/hprofile-ak-snc4/275863_100000532671032_2306307_n.jpg"];
    UIImage  *image01        = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl01]];
    //CGRect imageRect        = CGRectMake(30,30,image.size.width,image.size.height);
    UIImageView *imageview01 = [[UIImageView alloc] initWithFrame:CGRectMake(40,40,80,80)];
    imageview01.image        = image01;
    [self.view addSubview:imageview01];

    NSURL    *imageUrl02     = [NSURL URLWithString:@"http://profile.ak.fbcdn.net/hprofile-ak-ash2/368785_100000588696676_2051595305_n.jpg"];
    UIImage  *image02        = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl02]];
    UIImageView *imageview02 = [[UIImageView alloc] initWithFrame:CGRectMake(120,40,80,80)];
    imageview02.image        = image02;
    [self.view addSubview:imageview02];

    NSURL    *imageUrl03     = [NSURL URLWithString:@"http://profile.ak.fbcdn.net/hprofile-ak-snc4/174487_1745895585_1020116261_n.jpg"];
    UIImage  *image03        = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl03]];
    UIImageView *imageview03 = [[UIImageView alloc] initWithFrame:CGRectMake(200,40,80,80)];
    imageview03.image        = image03;
    [self.view addSubview:imageview03];

    NSURL    *imageUrl04     = [NSURL URLWithString:@"http://profile.ak.fbcdn.net/hprofile-ak-snc4/371398_100003356432640_1993756483_n.jpg"];
    UIImage  *image04        = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl04]];
    UIImageView *imageview04 = [[UIImageView alloc] initWithFrame:CGRectMake(40,120,80,80)];
    imageview04.image        = image04;
    [self.view addSubview:imageview04];

    NSURL    *imageUrl05     = [NSURL URLWithString:@"http://profile.ak.fbcdn.net/hprofile-ak-snc4/369731_1414474837_1204974515_n.jpg"];
    UIImage  *image05        = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl05]];
    UIImageView *imageview05 = [[UIImageView alloc] initWithFrame:CGRectMake(120,120,80,80)];
    imageview05.image        = image05;
    [self.view addSubview:imageview05];
    
    NSURL    *imageUrl06     = [NSURL URLWithString:@"http://profile.ak.fbcdn.net/hprofile-ak-snc4/369731_1414474837_1204974515_n.jpg"];
    UIImage  *image06        = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl06]];
    UIImageView *imageview06 = [[UIImageView alloc] initWithFrame:CGRectMake(200,120,80,80)];
    imageview06.image        = image06;
    [self.view addSubview:imageview06];
    
    NSURL    *imageUrl07     = [NSURL URLWithString:@"http://profile.ak.fbcdn.net/hprofile-ak-snc4/369731_1414474837_1204974515_n.jpg"];
    UIImage  *image07        = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl07]];
    UIImageView *imageview07 = [[UIImageView alloc] initWithFrame:CGRectMake(40,200,80,80)];
    imageview07.image        = image07;
    [self.view addSubview:imageview07];
    
    NSURL    *imageUrl08     = [NSURL URLWithString:@"http://profile.ak.fbcdn.net/hprofile-ak-snc4/369731_1414474837_1204974515_n.jpg"];
    UIImage  *image08        = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl08]];
    UIImageView *imageview08 = [[UIImageView alloc] initWithFrame:CGRectMake(120,200,80,80)];
    imageview08.image        = image08;
    [self.view addSubview:imageview08];
    
    NSURL    *imageUrl09     = [NSURL URLWithString:@"http://profile.ak.fbcdn.net/hprofile-ak-snc4/369731_1414474837_1204974515_n.jpg"];
    UIImage  *image09        = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl09]];
    UIImageView *imageview09 = [[UIImageView alloc] initWithFrame:CGRectMake(200,200,80,80)];
    imageview09.image        = image09;
    [self.view addSubview:imageview09];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)tweetButton:(id)sender {
    
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
        NSString *tweettext  = [tweet objectForKey:@"text"];
        self.tweetLabel.text = tweettext;
        
        NSLog(@"%@ \n %@", [[tweet objectForKey:@"user"] objectForKey:@"screen_name"],[tweet objectForKey:@"text"]);
    }
}

@end
