//
//  HomeListViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

@protocol HomeListViewModelDelegate<BaseRequestDelegate>

-(void)onRequestNoDatas:(Boolean)isFirst;

@end


@interface HomeListViewModel : NSObject

@property(weak, nonatomic)id<HomeListViewModelDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(copy, nonatomic)NSString *goodClass;


-(void)requestGoodsList:(Boolean)isRefreshNew;

@end



