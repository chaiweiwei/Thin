//
//  DBManager.h
//  Thin
//
//  Created by 求攻略 on 15/8/25.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

+(instancetype) getShareInstance;

- (NSArray *)queryAllFromItemTable;

- (NSArray *)queryItemFromItemTableWithItemId:(NSString *)itemId;

- (NSArray *)queryAllFromDetailTableFollowByItemId:(NSString *)ItemId;

- (NSArray *)queryItemDetailFromDetailTableWithDetailId:(NSString *)DetailId;

- (BOOL) saveDataToItemTable:(NSArray *)itemList;

- (BOOL) saveDataToDetailTable:(NSArray *)itemList;

- (BOOL) insertDataToItemTableWith:(NSString *)itemName;

- (BOOL) insertDataToDetailTableWith:(NSString *)itemId dataNum:(NSNumber *)dataNum createdate:(NSString *)createdate;

@end
