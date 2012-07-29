//
//  PanelViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/06/28.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import "PanelViewController.h"
#import "PanelImageView.h"
#import "LoginTableViewController.h"
#import "QuestionViewController.h"

@interface PanelViewController ()

@end

@implementation PanelViewController

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
    
    // NSUserDefaultsに初期値を登録する
    NSUserDefaults *defaults     = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *initial = [NSMutableDictionary dictionary];
    [initial setObject:@"高校１年生"    forKey:@"selectedGrade"];
    [initial setObject:@"方程式と不等式" forKey:@"selectedCategory"];
    [initial setObject:@"レベル1"      forKey:@"selectedLevel"];
    [initial setObject:[NSNumber numberWithBool:NO] forKey:@"login"];
    [defaults registerDefaults:initial];

    //ログインしてなかったら、設定画面へGO
    BOOL login = [defaults boolForKey:@"login"];
    if (login == NO){
        [self goLogin];
    }

    //パネル9枚を設置
    for(int i = 1; i <= 9; i++){
        NSURL *imageUrl = [NSURL URLWithString:@"http://profile.ak.fbcdn.net/hprofile-ak-snc4/275863_100000532671032_2306307_n.jpg"];
        UIImage *image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        CGRect rect;

        if (i%3 == 1){
            rect = CGRectMake( 40,(i-1)/3*80+40,80,80);
        }else if (i%3 == 2){
            rect = CGRectMake(120,(i-1)/3*80+40,80,80);
        }else{
            rect = CGRectMake(200,(i-1)/3*80+40,80,80);
        }
        PanelImageView *imageview = [[PanelImageView alloc] initWithFrame:rect];
        imageview.image           = image;
        imageview.questionId      = [NSString stringWithFormat:@"%d",i];
        [self.view addSubview:imageview];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    UIView *touchView = touch.view;
    
    //タッチされたのがPanelImageViewならば、問題画面へGO
    if ([touchView isMemberOfClass:[PanelImageView class]]){
        PanelImageView *touchView = (PanelImageView *)touch.view;
        
        [self goQuestion:touchView.questionId];
    }
}

- (void)goLogin
{    
    LoginTableViewController *loginTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginTableViewController"];
    [self.navigationController pushViewController:loginTableViewController animated:YES];
}

- (void)goQuestion:(NSString *)questionId
{    
    QuestionViewController *questionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"questionViewController"];
    questionViewController.title = @"問題";
    questionViewController.questionId = questionId;
    [self.navigationController pushViewController:questionViewController animated:YES];
}

@end
