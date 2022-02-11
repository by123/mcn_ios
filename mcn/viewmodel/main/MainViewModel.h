//
//  MainViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QulificationsModel.h"

@protocol MainViewDelegate<BaseRequestDelegate>

-(void)onGoSettingPage;
-(void)onGoPartnerPage:(PartnerType)type;
-(void)onGoBusinessPage:(NSString *)mchId isEdit:(Boolean)isEdit;
-(void)onGoPartnerMerchantPage:(NSString *)mchId;
-(void)onGoCelebrityPage;
-(void)onGoQualificationsPage;
-(void)onGoQualificationsEditPage:(QulificationsModel *)qulificationModel;
-(void)onGoBankPage;
-(void)onGoAddressPage;
-(void)onGoWithdrawPage;
-(void)onGoMsgDetailPage:(NSString *)msgId;
-(void)onGoProductPage:(NSString *)skuId;
-(void)onGoCooperationPage:(NSMutableArray *)datas;
-(void)onGoHomeSearchPage;
-(void)onGoAddProductPage;
-(void)onGoCapitalDetailPage:(NSString *)listId;
-(void)onGoStaticticsPage:(StaticticsType)type;
-(void)onGoWithdrawListPage;

-(void)onHiddenBottomView:(Boolean)hidden;

@end


@interface MainViewModel : NSObject

@property(weak, nonatomic)id<MainViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)goSettingPage;
-(void)goPartnerPage:(PartnerType)type;
-(void)goBusinessPage:(NSString *)mchId isEdit:(Boolean)isEdit;
-(void)goPartnerMerchantPage:(NSString *)mchId;
-(void)goCelebrityPage;
-(void)goQualificationsPage;
-(void)goBankPage;
-(void)goAddressPage;
-(void)goWithdrawPage;
-(void)goMsgDetailPage:(NSString *)msgId;
-(void)goProductPage:(NSString *)skuId;
-(void)goCooperationPage:(NSMutableArray *)datas;
-(void)goHomeSearchPage;
-(void)goAddProductPage;
-(void)goCapitalDetailPage:(NSString *)listId;
-(void)goStaticticsPage:(StaticticsType)type;
-(void)goWithdrawListPage;

-(void)hiddenBottomView:(Boolean)hidden;
-(void)loginByToken;

@end



