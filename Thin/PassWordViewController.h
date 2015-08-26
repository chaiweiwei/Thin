//
//  PassWordViewController.h
//  Thin
//
//  Created by 求攻略 on 15/8/25.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputPasswordView.h"

typedef NS_ENUM(NSInteger, LogingAnimationType) {
    LogingAnimationType_NONE,
    LogingAnimationType_USER,
    LogingAnimationType_PWD
};

@interface PassWordViewController : UIViewController
@property (weak, nonatomic) IBOutlet InputPasswordView *passWordView;

@property (weak, nonatomic) IBOutlet UIImageView *left_hidden;
@property (weak, nonatomic) IBOutlet UIImageView *right_hidden;

@property (weak, nonatomic) IBOutlet UIImageView *left_look;
@property (weak, nonatomic) IBOutlet UIImageView *right_look;

@end
