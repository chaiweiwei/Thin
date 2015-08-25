//
//  DBManager.m
//  Thin
//
//  Created by 求攻略 on 15/8/25.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>

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

- (NSArray *)qurtyAllFromTable:(NSString *)tableName {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    
    sqlite3_stmt *sql_stmt;

    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
    
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &sql_stmt, NULL) == SQLITE_OK) {
            NSMutableArray *tempArray = [NSMutableArray array];
            
            while (sqlite3_step(sql_stmt) == SQLITE_ROW) {
                NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(sql_stmt, 1)];
                [tempArray addObject:name];
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

@end
