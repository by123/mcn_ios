//
//  PartnerPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "PartnerPage.h"
#import "PartnerView.h"
#import "PartnerDetailPage.h"
#import "ProductDetailPage.h"
#import "PartnerMerchantPage.h"
#import "STObserverManager.h"
@interface PartnerPage()<PartnerViewDelegate>

@property(strong, nonatomic)PartnerView *partnerView;
@property(strong, nonatomic)PartnerViewModel *viewModel;
@property(assign, nonatomic)PartnerType type;


@end

@implementation PartnerPage

+(void)show:(BaseViewController *)controller type:(PartnerType)type{
    PartnerPage *page = [[PartnerPage alloc]init];
    page.type = type;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"我的合作" needback:YES];
    [self initView];
    [[STObserverManager sharedSTObserverManager]registerSTObsever:NOTIFY_UPDATE_PARTNER delegate:self];

}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:NOTIFY_UPDATE_PARTNER];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[PartnerViewModel alloc]init];
    _viewModel.type = _type;
    _viewModel.delegate = self;
    
    _partnerView =[[PartnerView alloc]initWithViewModel:_viewModel];
    _partnerView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _partnerView.backgroundColor = cbg2;
    [self.view addSubview:_partnerView];
    
    
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onGoPartnerDetailPage:(NSString *)cooperationId{
    [PartnerDetailPage show:self cooperationId:cooperationId];
}

-(void)onGoProductDetailPage:(NSString *)skuId{
    [ProductDetailPage show:self skuId:skuId];
}

-(void)onGoPartnerMerchantPage:(NSString *)supplierId{
    [PartnerMerchantPage show:self mchId:supplierId];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:NOTIFY_UPDATE_PARTNER]){
        [_partnerView reloadView];
    }
}


@end

