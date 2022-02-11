//
//  PartnerDetailPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "PartnerDetailPage.h"
#import "PartnerDetailView.h"
#import "SchdulePage.h"
#import "LogisticalPage.h"
#import "PartnerMcnPage.h"
#import "PartnerCelebrityPage.h"
#import "PartnerMerchantPage.h"
#import "DeliveryPage.h"
#import "STObserverManager.h"

@interface PartnerDetailPage()<PartnerDetailViewDelegate,STObserverProtocol>

@property(strong, nonatomic)PartnerDetailView *partnerDetailView;
@property(strong, nonatomic)PartnerDetailViewModel *viewModel;
@property(copy, nonatomic)NSString *cooperationId;

@end

@implementation PartnerDetailPage

+(void)show:(BaseViewController *)controller cooperationId:(NSString *)cooperationId{
    PartnerDetailPage *page = [[PartnerDetailPage alloc]init];
    page.cooperationId = cooperationId;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"合作详情" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[PartnerDetailViewModel alloc]init];
    _viewModel.cooperationId = _cooperationId;
    _viewModel.delegate = self;
    
    _partnerDetailView =[[PartnerDetailView alloc]initWithViewModel:_viewModel];
    _partnerDetailView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _partnerDetailView.backgroundColor = cwhite;
    [self.view addSubview:_partnerDetailView];
    
    [_viewModel requestDetail];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_PROJECT_DETAIL]){
        [_partnerDetailView updateView];
    }else if([respondModel.requestUrl isEqualToString:URL_PROJECT_ACT]){
        [STShowToast show:@"确认合作成功"];
        [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_UPDATE_PARTNER msg:nil];
        [self backLastPage];
    }else if([respondModel.requestUrl isEqualToString:URL_PROJECT_CANCEL]){
        [STShowToast show:@"取消成功"];
        [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_UPDATE_PARTNER msg:nil];
        [self backLastPage];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onGoSchdulePage{
    [SchdulePage show:self cooperationId:_viewModel.model.cooperationId cooperationName:_viewModel.model.cooperationName];
}

-(void)onGoLogisticalPage{
    [LogisticalPage show:self  cooperationId:_viewModel.model.cooperationId];
}

-(void)onGoPartnerMcnPage{
    [PartnerMcnPage show:self mchId:_viewModel.model.mcnId];
}

-(void)onGoPartnerCelebrity{
    [PartnerCelebrityPage show:self mchId:_viewModel.model.mchId];
}

-(void)onGoPartnerMerchantPage{
    [PartnerMerchantPage show:self mchId:_viewModel.model.supplierId];
}

-(void)onGoDeliveryPage{
    [DeliveryPage show:self model:_viewModel.model.addressModel];
}

@end

