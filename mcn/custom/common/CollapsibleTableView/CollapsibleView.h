//
//  CollapsibleView.h
//  TreasureChest
//
//  Created by xiao ming on 2019/12/19.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapsibleModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CollapsibleViewDelegate <NSObject>

- (void)collapsibleViewSelectedItem:(CollapsibleModel *)selectedItem;

@end

@interface CollapsibleView : UIView

@property (nonatomic, weak) id<CollapsibleViewDelegate> delegate;

///订单模块默认初始化为：3。   库存传入：4
- (instancetype)initWithSubMchType:(int)type isOrder:(Boolean)isOrder;
- (void)startWithAnimation:(BOOL)isShow;


#pragma mark - < 特殊配置:库存模块调用 >
- (void)congfigStockTypeBtnText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
