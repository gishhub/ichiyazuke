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

@synthesize grade;
@synthesize category;
@synthesize level;
@synthesize personalId;

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
    // NSUserDefaultsに初期値を登録する
    NSUserDefaults *defaults     = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *initial = [NSMutableDictionary dictionary];
    [initial setObject:@"高校１年生"    forKey:@"selectedGrade"];
    [initial setObject:@"方程式と不等式" forKey:@"selectedCategory"];
    [initial setObject:@"レベル１"      forKey:@"selectedLevel"];
    [initial setObject:[NSNumber numberWithBool:NO] forKey:@"login"];
    [defaults registerDefaults:initial];
    
    //ログインしてなかったら、設定画面へGO
    BOOL login = [defaults boolForKey:@"login"];
    if (login == NO){
        [self goLogin];
    }
    
    //NSUserDefaultsに保存された値を読み込み
    grade      = [defaults stringForKey:@"selectedGrade"];
    category   = [defaults stringForKey:@"selectedCategory"];
    level      = [defaults stringForKey:@"selectedLevel"];
    personalId = @"1";
    
    //API仕様に合わせ、設定情報を数値に変換
    // grade
    if ([self.grade isEqualToString:@"高校１年生"]){
        self.grade = @"4";
    }else if ([self.grade isEqualToString:@"高校２年生"]){
        self.grade = @"5";
    }else if ([self.grade isEqualToString:@"高校３年生"]){
        self.grade = @"6";
    }
    
    // category
    if ([self.category isEqualToString:@"方程式と不等式"]){
        self.category = @"4";
    }else if ([self.category isEqualToString:@"二次関数"]){
        self.category = @"5";
    }else if ([self.category isEqualToString:@"三角比"]){
        self.category = @"6";
    }else if ([self.category isEqualToString:@"式と証明"]){
        self.category = @"7";
    }else if ([self.category isEqualToString:@"三角関数"]){
        self.category = @"8";
    }else if ([self.category isEqualToString:@"指数・対数関数"]){
        self.category = @"9";
    }else if ([self.category isEqualToString:@"微分と積分"]){
        self.category = @"10";
    }else if ([self.category isEqualToString:@"極限"]){
        self.category = @"11";
    }else if ([self.category isEqualToString:@"微分法と積分法"]){
        self.category = @"12";
    }else if ([self.category isEqualToString:@"集合・命題・証明"]){
        self.category = @"13";
    }else if ([self.category isEqualToString:@"場合の数・確率"]){
        self.category = @"14";
    }else if ([self.category isEqualToString:@"数列"]){
        self.category = @"15";
    }else if ([self.category isEqualToString:@"ベクトル"]){
        self.category = @"16";
    }else if ([self.category isEqualToString:@"行列"]){
        self.category = @"17";
    }
    
    // level
    if ([self.level isEqualToString:@"レベル１"]){
        self.level = @"1";
    }else if ([self.level isEqualToString:@"レベル２"]){
        self.level = @"2";
    }else if ([self.level isEqualToString:@"レベル３"]){
        self.level = @"3";
    }
    
    NSString *url = @"http://49.212.136.103:8080/ichiyazuke_web/select_question_id";
    //NSString *url = @"http://localhost:8080/ichiyazuke_web/select_question_id";
    
    /* POST */
    NSString *keyValue           = [NSString stringWithFormat:@"grade=%@&category=%@&level=%@&personalId=%@", self.grade, self.category, self.level, self.personalId];
    NSData *post                 = [keyValue dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:post];
    
    NSData  *response    = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *jsonError   = nil;
    NSArray *questionIds = [NSJSONSerialization JSONObjectWithData:response
                                                           options:0
                                                             error:&jsonError];
    
    // JSONデータのパースエラー
    if (questionIds == nil) {
        NSLog(@"JSON Parser error: %d", jsonError.code);
        return;
    }
    
    if (questionIds == nil || [questionIds count] < 9){
        NSLog(@"%@",@"falseです");
    }
    
    //パネル9枚を設置
    for(int i = 1; i <= 9; i++){
        NSString *file  = [NSString stringWithFormat:@"q%d",i];
        NSString *path  = [[NSBundle mainBundle] pathForResource:file ofType:@"png"];
        NSURL *imageUrl = [NSURL fileURLWithPath:path];
        UIImage *image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        
        CGRect rect;
        
        if (i%3 == 1){
            rect = CGRectMake( 20,(i-1)/3*55+130,90,50);
        }else if (i%3 == 2){
            rect = CGRectMake(115,(i-1)/3*55+130,90,50);
        }else{
            rect = CGRectMake(210,(i-1)/3*55+130,90,50);
        }
        PanelImageView *imageview = [[PanelImageView alloc] initWithFrame:rect];
        imageview.image           = image;
        
        //問題ID設定
        imageview.questionId = [NSString stringWithFormat:@"%@",[questionIds objectAtIndex:i-1]];
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
    questionViewController.questionId = questionId;
    [self.navigationController pushViewController:questionViewController animated:YES];
}

@end
