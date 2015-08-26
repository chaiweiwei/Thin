//
//  DBManager.m
//  Thin
//
//  Created by 求攻略 on 15/8/25.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>
#import "thinContentModel.h"
#import "thinItemModel.h"

static DBManager *shareInstance = nil; //单例

static sqlite3 *database;

static NSString *dbPath = nil;

@implementation DBManager

+(instancetype)getShareInstance {
    if(!shareInstance) {
        shareInstance = [[DBManager alloc] init];
        
        NSURL *path = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
        
        dbPath = [path.path stringByAppendingPathComponent:@"thin.db"];

    }
    
    return shareInstance;
}

- (NSArray *)queryAllFromItemTable {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM contentItem"];
    
    sqlite3_stmt *sql_stmt;

    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
    
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &sql_stmt, NULL) == SQLITE_OK) {
            NSMutableArray *tempArray = [NSMutableArray array];
            
            while (sqlite3_step(sql_stmt) == SQLITE_ROW) {
                thinItemModel *model = [[thinItemModel alloc] init];
                model.name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(sql_stmt, 1)];
                model.itemId = [NSString stringWithFormat:@"%d",sqlite3_column_int(sql_stmt, 0)];
                
                [tempArray addObject:model];
            }
            
            return [tempArray copy];
        }
    }
    
    sqlite3_finalize(sql_stmt);
    sqlite3_close(database);
    
    return nil;
}

- (NSArray *)queryItemFromItemTableWithItemId:(NSString *)itemId {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM contentItem where id = %@",itemId];
    
    sqlite3_stmt *sql_stmt;
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &sql_stmt, NULL) == SQLITE_OK) {
            NSMutableArray *tempArray = [NSMutableArray array];
            
            while (sqlite3_step(sql_stmt) == SQLITE_ROW) {
                thinItemModel *model = [[thinItemModel alloc] init];
                model.name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(sql_stmt, 1)];
                model.itemId = [NSString stringWithFormat:@"%d",sqlite3_column_int(sql_stmt, 0)];
                
                [tempArray addObject:model];
            }
            
            return [tempArray copy];
        }
    }
    
    sqlite3_finalize(sql_stmt);
    sqlite3_close(database);
    
    return nil;

}

- (NSArray *)queryItemDetailFromDetailTableWithDetailId:(NSString *)DetailId {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM contentDetail where id = %@",DetailId];
    
    sqlite3_stmt *sql_stmt;
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &sql_stmt, NULL) == SQLITE_OK) {
            NSMutableArray *tempArray = [NSMutableArray array];
            
            while (sqlite3_step(sql_stmt) == SQLITE_ROW) {
                thinContentModel *model = [[thinContentModel alloc] init];
                
                model.detailId = [NSString stringWithFormat:@"%d",sqlite3_column_int(sql_stmt, 0)];
                model.itemId = [NSString stringWithFormat:@"%d",sqlite3_column_int(sql_stmt, 1)];
                model.dataNum = [NSNumber numberWithFloat:sqlite3_column_double(sql_stmt, 2)];
                model.createDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(sql_stmt, 3)];
                
                [tempArray addObject:model];
            }
            
            return [tempArray copy];
        }
    }
    
    sqlite3_finalize(sql_stmt);
    sqlite3_close(database);
    
    return nil;

}

- (BOOL)insertDataToItemTableWith:(NSString *)itemName {
    BOOL isSuccess = NO;
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO 'contentItem' ('name') VALUES('%@')",itemName];
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {

        char *errMessage;
        
        if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errMessage) == SQLITE_OK) {
            isSuccess = YES;
        } else {
            NSLog(@"%s",errMessage);
        }
    }
    
    sqlite3_close(database);

    return isSuccess;
    
}

- (BOOL) insertDataToDetailTableWith:(NSString *)itemId dataNum:(NSNumber *)dataNum createdate:(NSString *)createdate {
    BOOL isSuccess = NO;
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO 'contentDetail' ('itemId' , 'dataNum' , 'createDate') VALUES('%@' , '%@' , '%@')",itemId,dataNum.stringValue,createdate];
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        char *errMessage;
        
        if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errMessage) == SQLITE_OK) {
            isSuccess = YES;
        } else {
            NSLog(@"%s",errMessage);
        }
    }
    
    sqlite3_close(database);
    
    return isSuccess;

}

- (BOOL) saveDataToDetailTable:(NSArray *)itemList {
     __block BOOL isSuccess = NO;
    [itemList enumerateObjectsUsingBlock:^(thinContentModel *obj, NSUInteger idx, BOOL *stop) {

        NSArray *dataList = [self queryItemDetailFromDetailTableWithDetailId:obj.detailId];
        
        if(dataList.count <= 0) {
            isSuccess = [self insertDataToDetailTableWith:obj.itemId dataNum:obj.dataNum createdate:obj.createDate];
        }
        
    }];
    return isSuccess;
}

- (BOOL) saveDataToItemTable:(NSArray *)itemList {
    __block BOOL isSuccess = NO;
    [itemList enumerateObjectsUsingBlock:^(thinItemModel *obj, NSUInteger idx, BOOL *stop) {
        
        NSArray *dataList = [self queryItemFromItemTableWithItemId:obj.itemId];
        
        if(dataList.count <= 0) {
            isSuccess = [self insertDataToItemTableWith:obj.name];
        }
    }];
    
    return isSuccess;
}

- (NSArray *)queryAllFromDetailTableFollowByItemId:(NSString *)ItemId{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM contentDetail where itemId = %@",ItemId];
    
    sqlite3_stmt *sql_stmt;
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &sql_stmt, NULL) == SQLITE_OK) {
            NSMutableArray *tempArray = [NSMutableArray array];
            
            while (sqlite3_step(sql_stmt) == SQLITE_ROW) {
                
                thinContentModel *model = [[thinContentModel alloc] init];
                
                model.detailId = [NSString stringWithFormat:@"%d",sqlite3_column_int(sql_stmt, 0)];
                model.itemId = [NSString stringWithFormat:@"%d",sqlite3_column_int(sql_stmt, 1)];
                model.dataNum = [NSNumber numberWithFloat:sqlite3_column_double(sql_stmt, 2)];
                model.createDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(sql_stmt, 3)];
                
                [tempArray addObject:model];
            }
            
            return [tempArray copy];
        }
    }
    
    sqlite3_finalize(sql_stmt);
    sqlite3_close(database);
    
    return nil;

}

@end
