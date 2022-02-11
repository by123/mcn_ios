//
//  CollapsibleTableView.h
//  cigarette
//
//  Created by xiao ming on 2019/12/26.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapsibleModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CollapsibleTableViewDelegate <NSObject>

- (void)requestSubDataForTargetModel:(CollapsibleModel *)targetModel;

@end

@interface CollapsibleTableView : UIView

@property (nonatomic, weak) id<CollapsibleTableViewDelegate> delegate;

///完整的整个数据结构
@property (nonatomic, strong) NSMutableArray<CollapsibleModel *> *rootItems;

@property(strong, nonatomic)CollapsibleModel *selectedItem;

@end

NS_ASSUME_NONNULL_END
