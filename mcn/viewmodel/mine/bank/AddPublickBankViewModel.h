//
//  AddPublickBankViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankModel.h"

@protocol AddPublickBankViewDelegate<BaseRequestDelegate>

@end


@interface AddPublickBankViewModel : NSObject

@property(weak, nonatomic)id<AddPublickBankViewDelegate> delegate;
@property(strong, nonatomic)BankModel *model;


-(void)addBank;

@end



