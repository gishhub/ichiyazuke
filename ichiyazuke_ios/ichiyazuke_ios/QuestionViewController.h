//
//  QuestionViewController.h
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/06/29.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController

@property (retain, readwrite) NSString *questionId;
@property (retain, readwrite) NSString *questionTitle;
@property (retain, readwrite) NSString *contents;
@property (retain, readwrite) NSString *choice1;
@property (retain, readwrite) NSString *choice2;
@property (retain, readwrite) NSString *choice3;
@property (retain, readwrite) NSString *choice4;
@property (retain, readwrite) NSString *answer;
@property (retain, readwrite) NSString *explanation;
@property (retain, readwrite) NSString *correct;

@end
