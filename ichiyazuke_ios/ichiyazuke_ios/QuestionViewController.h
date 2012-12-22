//
//  QuestionViewController.h
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/06/29.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController

@property (retain, nonatomic) UIWebView *webView;
@property (retain, nonatomic) NSString *questionId;

- (void)configureView;

@end
