//
//  PanelImageView.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/06/29.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import "PanelImageView.h"

@implementation PanelImageView

@synthesize questionId;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //タッチの可否
        self.userInteractionEnabled = YES;

        //マルチタッチの可否
        [self setMultipleTouchEnabled:YES];
    }
    return self;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"タッチイベント終了");
}

@end
