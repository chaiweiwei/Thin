//
//  thinItemModel.h
//  Thin
//
//  Created by 求攻略 on 15/8/23.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface thinItemModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSString *itemId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSArray *itemList;

@end
