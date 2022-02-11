//
//  CapitalListViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CapitalListModel.h"

@protocol CapitalListViewDelegate<BaseRequestDelegate>

-(void)onRequestNoDatas:(Boolean)isFirst;

@end


@interface CapitalListViewModel : NSObject

@property(weak, nonatomic)id<CapitalListViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(assign, nonatomic)int type;


-(void)requestList:(Boolean)isRefreshNew;

@end



