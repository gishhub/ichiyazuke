//
//  ViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/05/03.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)loginButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ログイン"
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK",nil];
    alert.delegate = self;
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *loginNameField = [alertView textFieldAtIndex:0];
        UITextField *passField = [alertView textFieldAtIndex:1];
        NSString *login = loginNameField.text;
        NSString *pass = passField.text;
        NSLog(@"id: %@",login);
        NSLog(@"password: %@",pass);
    }
}
@end
