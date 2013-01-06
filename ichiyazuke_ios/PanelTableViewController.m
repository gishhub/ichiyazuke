//
//  PanelTableViewController.m
//  ichiyazuke_ios
//
//  Created by Yuichi Takada on 12/12/25.
//
//

#import "PanelTableViewController.h"
#import "PanelTableViewCell.h"
#import "LoginTableViewController.h"
#import "SettingTableViewController.h"
#import "QuestionViewController.h"

@interface PanelTableViewController ()

@end

@implementation PanelTableViewController

@synthesize customAdView;
@synthesize userDefaults;
@synthesize myView;
@synthesize grade;
@synthesize category;
@synthesize level;
@synthesize personalId;
@synthesize questionIds;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    // 広告バナー
    self.customAdView = [[ADBannerView alloc] initWithFrame:CGRectMake(0.0, 480.0, 0.0, 0.0)];
    self.customAdView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    self.customAdView.delegate = self;
    [self.view addSubview:customAdView];

    // 一番下の問題Cellが広告バナーに隠れてしまわないように空のフッター設置
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, self.customAdView.frame.size.height)];

    // NSUserDefaultsに初期値を登録する
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *initial = [NSMutableDictionary dictionary];
    [initial setObject:@"高校１年生"    forKey:@"selectedGrade"];
    [initial setObject:@"方程式と不等式" forKey:@"selectedCategory"];
    [initial setObject:@"レベル１"      forKey:@"selectedLevel"];
    [initial setObject:[NSNumber numberWithBool:NO] forKey:@"login"];
    [self.userDefaults registerDefaults:initial];

    //ログインしてなかったら、設定画面へGO
    BOOL login = [self.userDefaults boolForKey:@"login"];
    if (login == NO){
        [self goLogin];
    }

    //API仕様に合わせ、設定情報を数値に変換
    [self translateFromValueToNumber];

    self.title = [self.userDefaults stringForKey:@"selectedCategory"];

    NSString *url = @"http://49.212.136.103:8080/ichiyazuke_web/select_question_id";
    //NSString *url = @"http://localhost:8080/ichiyazuke_web/select_question_id";
    
    /* POST */
    NSString *keyValue = [NSString stringWithFormat:@"grade=%@&category=%@&level=%@&personalId=%@", self.grade, self.category, self.level, self.personalId];
    NSData *post = [keyValue dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:post];

    NSData  *response  = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:nil
                                                           error:nil];

    // HTTPリクエストのエラー
    if (response == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"問題の読み込みに失敗しました", @"")
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK",nil];
        [alert show];
        return;
    }

    self.questionIds   = [NSJSONSerialization JSONObjectWithData:response
                                                           options:0
                                                             error:nil];
    // JSONデータのパースエラー
    if (self.questionIds == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"問題の読み込みに失敗しました", @"")
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK",nil];
        [alert show];
        return;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.questionIds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PanelTableViewCell";
    PanelTableViewCell *cell = (PanelTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[PanelTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if(indexPath.section == 0) {
        int i = 0;
        for (NSDictionary *question in self.questionIds){
            if(indexPath.row == i) {
                cell.tag = [[question objectForKey:@"id"] intValue];
                cell.titleLabel.text = [question objectForKey:@"title"];
                cell.contentsLabel.text = [question objectForKey:@"contents"];
            }
            i++;
        }
    }
    return cell;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self goSetting];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    float viewHeight = frame.size.height;
    float adViewWidth = self.customAdView.frame.size.width;
    float adViewHeight = self.customAdView.frame.size.height;
    // 44 はnavigationBarの高さ
    self.customAdView.center = CGPointMake(adViewWidth / 2, self.tableView.contentOffset.y + viewHeight - 44.0 - adViewHeight / 2);
    [self.view bringSubviewToFront:self.customAdView];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    float viewHeight = frame.size.height;
    float adViewHeight = self.customAdView.frame.size.height;
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.customAdView.center = CGPointMake(160.0, self.tableView.contentOffset.y + viewHeight - 44.0 - adViewHeight / 2);
                         self.customAdView.alpha = 1.0;
                     }
                     completion:nil];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    //NSLog(@"広告表示が失敗しました");
}

- (void)translateFromValueToNumber
{
    //NSUserDefaultsに保存された値を読み込み
    self.grade      = [self.userDefaults stringForKey:@"selectedGrade"];
    self.category   = [self.userDefaults stringForKey:@"selectedCategory"];
    self.level      = [self.userDefaults stringForKey:@"selectedLevel"];
    self.personalId = @"1";
    
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
}

// ios5.1用の記述
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown || interfaceOrientation == UIInterfaceOrientationPortrait);
}

// ios6.0用の記述
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)goLogin
{
    LoginTableViewController *loginTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginTableViewController"];
    [self.navigationController pushViewController:loginTableViewController animated:YES];
}

- (void)goSetting
{
    SettingTableViewController *settingTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingTableViewController"];
    settingTableViewController.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:settingTableViewController animated:YES];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    QuestionViewController *questionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"questionViewController"];
    questionViewController.questionId = [NSString stringWithFormat:@"%d",cell.tag];
    [self.navigationController pushViewController:questionViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
