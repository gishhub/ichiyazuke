//
//  PanelTableViewController.h
//  ichiyazuke_ios
//
//  Created by Yuichi Takada on 12/12/25.
//
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface PanelTableViewController : UITableViewController <ADBannerViewDelegate>

@property (retain, nonatomic) ADBannerView *customAdView;
@property (retain, nonatomic) NSUserDefaults *userDefaults;
@property (retain, nonatomic) UIView *myView;
@property (retain, nonatomic) NSString *grade;
@property (retain, nonatomic) NSString *category;
@property (retain, nonatomic) NSString *level;
@property (retain, nonatomic) NSString *personalId;
@property (retain, nonatomic) NSArray *questionIds;

- (void)configureView;
- (void)goLogin;
- (void)translateFromValueToNumber;

@end
