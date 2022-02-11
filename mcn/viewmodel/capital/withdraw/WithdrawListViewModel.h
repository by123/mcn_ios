//
//  WithdrawListViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WithdrawModel.h"

@protocol WithdrawListViewDelegate<BaseRequestDelegate>

-(void)onRequestNoDatas:(Boolean)isFirst;

@end


@interface WithdrawListViewModel : NSObject

@property(weak, nonatomic)id<WithdrawListViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;


-(void)reqeustList:(Boolean)isRefreshNew;

@end



