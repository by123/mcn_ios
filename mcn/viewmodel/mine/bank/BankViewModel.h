//
//  BankViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankModel.h"

@protocol BankViewDelegate<BaseRequestDelegate>

-(void)onGoBankSelectPage;
-(void)onSelectBankModel:(BankModel *)model;

@end


@interface BankViewModel : NSObject

@property(weak, nonatomic)id<BankViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(assign, nonatomic)Boolean isSelect;


-(void)requestBankList;
-(void)goBankSelectPage;
-(void)delBankCard:(NSString *)bid;
-(void)selectModel:(BankModel *)model;

@end



