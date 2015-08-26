//
//  ContentTableViewController.h
//  Thin
//
//  Created by 求攻略 on 15/8/24.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentTableViewController : UIViewController

@property (nonatomic,copy) NSString *itemId;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end
