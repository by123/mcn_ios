//
//  PartnerViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PartnerViewDelegate<BaseRequestDelegate>

-(void)onGoPartnerDetailPage:(NSString *)cooperationId;
-(void)onGoProductDetailPage:(NSString *)skuId;
-(void)onGoPartnerMerchantPage:(NSString *)supplierId;

@end


@interface PartnerViewModel : NSObject

@property(weak, nonatomic)id<PartnerViewDelegate> delegate;
@property(assign, nonatomic)PartnerType type;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)goPartnerDetailPage:(NSString *)cooperationId;
-(void)goProductDetailPage:(NSString *)skuId;
-(void)goPartnerMerchantPage:(NSString *)supplierId;

@end



