//
//  CollapsibleViewModel.h
//  TreasureChest
//
//  Created by xiao ming on 2019/12/19.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollapsibleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollapsibleViewModel : NSObject

///完整的整个数据结构
@property (nonatomic, strong) NSMutableArray<CollapsibleModel *> *rootItems;
@property(strong, nonatomic)NSString *failMsg;
@property(assign, nonatomic)BOOL noMoreData;

///订单模块默认初始化为：3。   库存传入：4
@property(assign, nonatomic)int subMchType;
@property(assign, nonatomic)Boolean isOrder;

- (void)requestRootItemsData;
- (void)requestSubDataForTargetModel:(CollapsibleModel *)targetModel;


@end

NS_ASSUME_NONNULL_END
