//
//  WithdrawViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankModel.h"
#import "CapitalModel.h"
#import "WithdrawModel.h"

@protocol WithdrawViewDelegate<BaseRequestDelegate>

-(void)onGoBankPage:(Boolean)isSelect;
@end


@interface WithdrawViewModel : NSObject

@property(weak, nonatomic)id<WithdrawViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(strong, nonatomic)BankModel *bankModel;
@property(strong, nonatomic)CapitalModel *capitalModel;
@property(strong, nonatomic)WithdrawTipsModel *tipsModel;


-(void)requestBankList;
-(void)goBankPage:(Boolean)isSelect;
-(void)requestWithdraw;
-(void)requestWithdrawConfig;
-(void)doWithdraw:(double)money;

@end



