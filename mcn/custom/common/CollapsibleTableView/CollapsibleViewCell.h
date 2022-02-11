//
//  CollapsibleViewCell.h
//  TreasureChest
//
//  Created by xiao ming on 2019/12/19.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapsibleModel.h"
@class CollapsibleViewCell;

NS_ASSUME_NONNULL_BEGIN

@protocol CollapsibleViewCellDelegate <NSObject>

- (void)cellSelectedBtnClick:(CollapsibleViewCell *)cell;

@end

@interface CollapsibleViewCell : UITableViewCell

@property (nonatomic, weak) id<CollapsibleViewCellDelegate> delegate;

@property (nonatomic, strong) CollapsibleModel *menuItem;

@end

NS_ASSUME_NONNULL_END
