//
//  ContentTableViewController.m
//  Thin
//
//  Created by 求攻略 on 15/8/24.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import "ContentTableViewController.h"
#import "thinContentModel.h"

@interface ContentTableViewController ()<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *itemList;

@property (nonatomic,strong) NSDateFormatter *formatter;

@property (nonatomic,strong) UIAlertView *alertTitleView;

@end

@implementation ContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = 50;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.itemList = [[DBManager getShareInstance] queryAllFromDetailTableFollowByItemId:self.itemId];
}

- (NSArray *)itemList {
    if(!_itemList) {
        _itemList = [NSArray array];
    }
    return _itemList;
}


- (IBAction)addContent:(id)sender {
    
    [self.alertTitleView show];
}

- (IBAction)saveAction:(id)sender {
    
    [[DBManager getShareInstance] saveDataToDetailTable:self.itemList];
    
    [sender setTitle:@"已保存" forState:UIControlStateNormal];
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UITextField *text = [alertView textFieldAtIndex:0];
    
    if(buttonIndex == 1 && text.text.length > 0) {

        thinContentModel *model = [[thinContentModel alloc] init];
        model.itemId = self.itemId;
        model.dataNum = [NSNumber numberWithFloat:text.text.floatValue];
        model.createDate = [self.formatter stringFromDate:[NSDate date]];
        
        NSMutableArray *tempArray = [self.itemList mutableCopy];
        [tempArray addObject:model];
        
        self.itemList = [tempArray copy];

        [self.tableView reloadData];
    }
}


- (NSDateFormatter *)formatter {
    if(!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    return _formatter;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    thinContentModel *model = self.itemList[indexPath.row];
    cell.textLabel.text = model.dataNum.stringValue;
    cell.detailTextLabel.text = model.createDate;
    return cell;
}


@end
