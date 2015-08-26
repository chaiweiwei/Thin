//
//  PassWordViewController.m
//  Thin
//
//  Created by 求攻略 on 15/8/25.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import "PassWordViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface PassWordViewController ()
{
    LogingAnimationType AnimationType;
}

@end

@implementation PassWordViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"hehe";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.passWordView setFinishedInputBlock:^(NSString *passNum) {
        if([passNum isEqualToString:@"666666"]) {
            [self performSegueWithIdentifier:@"title" sender:self];
        } else {
           MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            HUD.labelText = @"错误";
            
            //设置模式为进度框形的
            HUD.mode = MBProgressHUDModeText;

            [HUD hide:YES afterDelay:0.8];
        }
        
    }];
    
    [self.passWordView setBeginInputBlock:^{
        
        if(AnimationType == LogingAnimationType_PWD) {
            return ;
        }
        
        [self AnimationUserToPassword];
        AnimationType = LogingAnimationType_PWD;
        
    }];
}

#pragma mark 移开手动画
-(void)AnimationPasswordToUser{
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.left_look.frame = CGRectMake(self.left_look.frame.origin.x - 80, self.left_look.frame.origin.y, 40, 40);
        self.right_look.frame = CGRectMake(self.right_look.frame.origin.x + 40, self.right_look.frame.origin.y, 40, 40);
        
        self.right_hidden.frame = CGRectMake(self.right_hidden.frame.origin.x+55, self.right_hidden.frame.origin.y+40, 40, 66);
        self.left_hidden.frame = CGRectMake(self.left_hidden.frame.origin.x-60, self.left_hidden.frame.origin.y+40, 40, 66);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark 捂眼
-(void)AnimationUserToPassword{
    [UIView animateWithDuration:0.5f animations:^{
        
        self.left_look.frame = CGRectMake(self.left_look.frame.origin.x + 80, self.left_look.frame.origin.y, 0, 0);
        self.right_look.frame = CGRectMake(self.right_look.frame.origin.x - 40, self.right_look.frame.origin.y, 0, 0);
        
        self.right_hidden.frame = CGRectMake(self.right_hidden.frame.origin.x-55, self.right_hidden.frame.origin.y-40, 40, 66);
        self.left_hidden.frame = CGRectMake(self.left_hidden.frame.origin.x+60, self.left_hidden.frame.origin.y-40, 40, 66);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)endEdit:(id)sender {
    if (AnimationType == LogingAnimationType_PWD) {
        [self AnimationPasswordToUser];
    }
    AnimationType = LogingAnimationType_NONE;
    [self.view endEditing:YES];

}




@end
