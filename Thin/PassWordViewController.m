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

@end

@implementation PassWordViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"机密档案";
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
