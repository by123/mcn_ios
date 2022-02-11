//
//  PartnerMerchantPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "PartnerMerchantPage.h"
#import "PartnerMerchantView.h"

@interface PartnerMerchantPage()<PartnerMerchantViewDelegate>

@property(strong, nonatomic)PartnerMerchantView *partnerMerchantView;
@property(strong, nonatomic)PartnerMerchantViewModel *viewModel;
@property(copy, nonatomic)NSString *mchId;
@end

@implementation PartnerMerchantPage

+(void)show:(BaseViewController *)controller mchId:(NSString *)mchId{
    PartnerMerchantPage *page = [[PartnerMerchantPage alloc]init];
    page.mchId = mchId;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"商家信息" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[PartnerMerchantViewModel alloc]init];
    _viewModel.mchId = _mchId;
    _viewModel.delegate = self;
    
    _partnerMerchantView =[[PartnerMerchantView alloc]initWithViewModel:_viewModel];
    _partnerMerchantView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _partnerMerchantView.backgroundColor = cwhite;
    [self.view addSubview:_partnerMerchantView];
    
    [_viewModel requestDetail];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_MCH_AUTHENTICATE_INFO]){
        [_partnerMerchantView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

