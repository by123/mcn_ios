//
//  ProductDetailViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

@protocol ProductDetailViewDelegate<BaseRequestDelegate>

-(void)onGoBack;
-(void)onGoCooperationPage;
-(void)onGoMessageTab;

@end


@interface ProductDetailViewModel : NSObject

@property(weak, nonatomic)id<ProductDetailViewDelegate> delegate;
@property(copy, nonatomic)NSString *skuId;
@property(strong, nonatomic)ProductModel *model;



//产品详情
-(void)requesDetail;
//加入选品站
-(void)addProductCart;

-(void)goBack;

-(void)goCooperationPage;

-(void)goMessageTab;


@end



