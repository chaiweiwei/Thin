//
//  thinItemModel.m
//  Thin
//
//  Created by 求攻略 on 15/8/23.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import "thinItemModel.h"

@implementation thinItemModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"itemId":@"itemId",
             @"name":@"name",
             @"itemList":@"itemList"
             };
}

@end
