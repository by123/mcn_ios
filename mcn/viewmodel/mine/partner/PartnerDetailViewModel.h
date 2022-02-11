//
//  PartnerDetailViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartnerDetailModel.h"

@protocol PartnerDetailViewDelegate<BaseRequestDelegate>

-(void)onGoSchdulePage;
-(void)onGoLogisticalPage;
-(void)onGoPartnerMcnPage;
-(void)onGoPartnerCelebrity;
-(void)onGoPartnerMerchantPage;
-(void)onGoDeliveryPage;

@end


@interface PartnerDetailViewModel : NSObject

@property(weak, nonatomic)id<PartnerDetailViewDelegate> delegate;
@property(strong, nonatomic)PartnerDetailModel *model;
@property(copy, nonatomic)NSString *cooperationId;


-(void)requestDetail;

-(void)confirmCooperate;
-(void)cancelCooperate;

-(void)goSchdulePage;
-(void)goLogisticalPage;
-(void)goPartnerMcnPage;
-(void)goPartnerCelebrity;
-(void)goPartnerMerchantPage;
-(void)goDeliveryPage;

@end



