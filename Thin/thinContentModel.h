//
//  thinContentModel.h
//  Thin
//
//  Created by 求攻略 on 15/8/23.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface thinContentModel : MTLModel<MTLJSONSerializing>

//@property (nonatomic,copy) NSNumber *abdomenDown;
//@property (nonatomic,copy) NSString *abdomenDownDesc;
//
//@property (nonatomic,copy) NSNumber *abdomenMiddle;
//@property (nonatomic,copy) NSString *abdomenMiddleDesc;
//
//@property (nonatomic,copy) NSNumber *abdomenUp;
//@property (nonatomic,copy) NSString *abdomenUpDesc;
//
//@property (nonatomic,copy) NSNumber *thighMiddle;
//@property (nonatomic,copy) NSString *thighMiddleDesc;
//
//@property (nonatomic,copy) NSNumber *armMiddle;
//@property (nonatomic,copy) NSString *armMiddleDesc;
//
//@property (nonatomic,copy) NSNumber *breastDown;
//@property (nonatomic,copy) NSString *breastDownDesc;
//
//@property (nonatomic,copy) NSNumber *breastModdle;
//@property (nonatomic,copy) NSString *breastModdleDesc;
//
//@property (nonatomic,copy) NSNumber *breastUp;
//@property (nonatomic,copy) NSString *breastUpDesc;
@property (nonatomic,copy) NSString *itemId;
@property (nonatomic,copy) NSString *detailId;
@property (nonatomic,copy) NSString *createDate;
@property (nonatomic,copy) NSNumber *dataNum;


@end
