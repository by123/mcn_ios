//
//  AddBankViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankModel.h"

@protocol AddBankViewDelegate<BaseRequestDelegate>

@end


@interface AddBankViewModel : NSObject

@property(weak, nonatomic)id<AddBankViewDelegate> delegate;
@property(strong, nonatomic)BankModel *model;

-(void)addBank;

@end



