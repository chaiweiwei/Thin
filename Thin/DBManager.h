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

- (NSArray *)qurtyAllFromTable:(NSString *)tableName;

- (BOOL) insertDataToItemTableWith:(NSString *)itemName;


@end
