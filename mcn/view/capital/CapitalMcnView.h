//
//  CapitalMcnView.h
//  mcn
//
//  Created by by.huang on 2020/9/8.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CapitalModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol CapitalMcnViewDelegate

-(void)onCapitalMcnViewWithdrawBtnClick;
-(void)onCapitalMcnViewStatisticsBtnClick:(StaticticsType)type;

@end

@interface CapitalMcnView : UIView

@property(weak, nonatomic)id<CapitalMcnViewDelegate> delegate;
-(void)updateView:(CapitalModel *)model;

@end

NS_ASSUME_NONNULL_END
