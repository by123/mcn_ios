//
//  HomeSearchViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

@protocol HomeSearchViewDelegate<BaseRequestDelegate>

-(void)onRequestNoDatas:(Boolean)isFirst;
-(void)onGoProductDetailPage:(NSString *)skuId;
-(void)onGoCooperationPage:(NSMutableArray *)datas;

@end


@interface HomeSearchViewModel : NSObject

@property(weak, nonatomic)id<HomeSearchViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(copy, nonatomic)NSString *key;


-(void)requestGoodsList:(Boolean)isRefreshNew;
-(void)goProductDetailPage:(NSString *)skuId;
-(void)goCooperationPage:(NSMutableArray *)datas;

@end



