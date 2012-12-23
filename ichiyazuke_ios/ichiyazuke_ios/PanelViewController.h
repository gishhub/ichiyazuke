//
//  PanelViewController.h
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/06/28.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanelViewController : UIViewController

@property (retain, nonatomic) NSUserDefaults *userDefaults;
@property (retain, nonatomic) UIView *myView;
@property (retain, nonatomic) NSString *grade;
@property (retain, nonatomic) NSString *category;
@property (retain, nonatomic) NSString *level;
@property (retain, nonatomic) NSString *personalId;

- (void)configureView;
- (void)goLogin;
- (void)goQuestion:(NSString *)questionId;
- (void)translateFromValueToNumber;

@end