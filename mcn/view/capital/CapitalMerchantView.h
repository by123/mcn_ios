//
//  CapitalMerchantView.h
//  mcn
//
//  Created by by.huang on 2020/9/8.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CapitalModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CapitalMerchantViewDelegate

-(void)onCapitalMerchantViewWithdrawBtnClick;
-(void)onCapitalMerchantViewStatisticsBtnClick:(StaticticsType)type;


@end

@interface CapitalMerchantView : UIView

@property(weak, nonatomic)id<CapitalMerchantViewDelegate> delegate;
-(void)updateView:(CapitalModel *)model;

@end

NS_ASSUME_NONNULL_END
