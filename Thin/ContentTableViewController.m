//
//  ContentTableViewController.m
//  Thin
//
//  Created by 求攻略 on 15/8/24.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import "ContentTableViewController.h"

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
    
    NSArray *dataList = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath].path];
    
    [dataList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if([obj[@"name"] isEqualToString:self.thinItemName]) {
            self.itemList = obj[@"items"];
            
            [self.tableView reloadData];
            
            *stop = YES;
        }
        
    }];
    
}

- (NSArray *)itemList {
    if(!_itemList) {
        _itemList = [NSArray array];
    }
    return _itemList;
}

- (NSURL *)getFilePath {
    
    NSURL *url = [[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].lastObject;
    
    url = [url URLByAppendingPathComponent:@"content"];
    
    return url;
}

- (IBAction)addContent:(id)sender {
    
    [self.alertTitleView show];
}

- (IBAction)saveAction:(id)sender {
    NSMutableArray *dataList = [[NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath].path] mutableCopy];
    
    __block NSDictionary *deletDict;
    __block NSInteger index;
    
    [dataList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if([obj[@"name"] isEqualToString:self.thinItemName]) {
            deletDict = obj;
            index = idx;
        }
    }];
    
    [dataList removeObject:deletDict];
    
    deletDict = @{
                  @"name":self.thinItemName,
                  @"items":self.itemList
                  };
    
    [dataList insertObject:deletDict atIndex:index];
    
    [NSKeyedArchiver archiveRootObject:[dataList copy] toFile:[self getFilePath].path];
    
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
        NSDictionary *dict = @{
                               @"content":text.text,
                               @"date":[self.formatter stringFromDate:[NSDate date]],
                               };
        
        NSMutableArray *tempArray = [self.itemList mutableCopy];
        [tempArray addObject:dict];
        
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
    
    NSDictionary *model = self.itemList[indexPath.row];
    cell.textLabel.text = model[@"content"];
    cell.detailTextLabel.text = model[@"date"];
    return cell;
}


@end
