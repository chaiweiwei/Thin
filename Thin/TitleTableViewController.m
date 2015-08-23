//
//  TitleTableViewController.m
//  Thin
//
//  Created by 求攻略 on 15/8/23.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import "TitleTableViewController.h"
#import "ThinDefine.h"
#import "thinItemModel.h"
#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface TitleTableViewController ()<UIAlertViewDelegate>

@property (nonatomic,assign) BOOL rightPW;

@property (nonatomic,copy) NSArray *thinItemList;

@property (nonatomic,strong) UIAlertView *alertTitleView;

@end

@implementation TitleTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag= 11;
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.frame = CGRectMake(alert.center.x+65,alert.center.y+48, 150,23);
    [alert addSubview:textField];
    
    [alert show];
    
    @weakify(self);


    [RACObserve(self, rightPW) subscribeNext:^(id x) {
        @strongify(self);
        
        if(self.rightPW) {
            _thinItemList = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath].path];
            [self.tableView reloadData];
        }

    }];
}

- (NSURL *)getFilePath {

    NSURL *url = [[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].lastObject;
    
    url = [url URLByAppendingPathComponent:@"content"];
    
    return url;
}

-(UIAlertView *)alertTitleView {
    if(!_alertTitleView) {
        _alertTitleView = [[UIAlertView alloc] initWithTitle:@"添加内容" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        _alertTitleView.alertViewStyle = UIAlertViewStylePlainTextInput;
        _alertTitleView.tag = 12;
        UITextField *textField = [[UITextField alloc] init];
        textField.backgroundColor = [UIColor whiteColor];
        textField.frame = CGRectMake(_alertTitleView.center.x+65,_alertTitleView.center.y+48, 150,23);
        [_alertTitleView addSubview:textField];
    }
    
    UITextField *text = [_alertTitleView textFieldAtIndex:0];
    text.text = @"";
    
    return _alertTitleView;
}


-(NSArray *)thinItemList {
    if(!_thinItemList) {
        _thinItemList = [NSArray array];
    }
    return _thinItemList;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UITextField *text = [alertView textFieldAtIndex:0];
    
    switch (alertView.tag) {
        case 12:
            if(buttonIndex == 1 && text.text.length > 0) {
                NSMutableArray *tempArray = [self.thinItemList mutableCopy];
                [tempArray addObject:@{@"name":text.text}];
                
                self.thinItemList = [tempArray copy];
                
                [NSKeyedArchiver archiveRootObject:_thinItemList toFile:[self getFilePath].path];
                
                [self.tableView reloadData];
                
            }

            break;
        case 11:

            if(buttonIndex == 1 && [text.text isEqualToString:@"chaiweiwei"]) {
                self.rightPW = YES;
            }
            
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"titleCell"];
}

- (IBAction)ediAction:(id)sender {
    
    UIBarButtonItem *item = (UIBarButtonItem *)sender;
    
    self.tableView.editing = !self.tableView.editing;
    
    if(self.tableView.editing) {
        
        item.title = @"完成";
    } else {
        item.title = @"编辑";
    }
}

- (IBAction)addThinItem:(id)sender {
    [self.alertTitleView show];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.thinItemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
    
    NSDictionary *model = _thinItemList[indexPath.row];
    cell.textLabel.text = model[@"name"];
    
    return cell;
}


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
