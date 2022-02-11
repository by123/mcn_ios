//
//  AddressPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AddressPage.h"
#import "AddressView.h"
#import "AddAddressPage.h"
#import "STObserverManager.h"

@interface AddressPage()<AddressViewDelegate,STObserverProtocol>

@property(strong, nonatomic)AddressView *addressView;
@property(strong, nonatomic)AddressViewModel *viewModel;
@property(assign, nonatomic)AddressType type;
@property(copy, nonatomic)NSString *addressId;

@end

@implementation AddressPage

+(void)show:(BaseViewController *)controller type:(AddressType)type  addressId:(NSString *)addressId{
    AddressPage *page = [[AddressPage alloc]init];
    page.addressId = addressId;
    page.type = type;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf)
    [self showSTNavigationBar:@"地址管理" needback:YES rightBtn:@"新增地址" block:^{
        [AddAddressPage show:weakSelf model:nil];
    }];
    [self initView];
    
    [[STObserverManager sharedSTObserverManager] registerSTObsever:NOTIFY_ADDRESS_LIST delegate:self];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:NOTIFY_ADDRESS_LIST];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([NOTIFY_ADDRESS_LIST isEqualToString:key]){
        [_viewModel requestAddress:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[AddressViewModel alloc]init];
    _viewModel.type = _type;
    _viewModel.addressId = _addressId;
    _viewModel.delegate = self;
    
    _addressView =[[AddressView alloc]initWithViewModel:_viewModel];
    _addressView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _addressView.backgroundColor = cbg2;
    [self.view addSubview:_addressView];
    
    [_viewModel requestAddress:YES];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_ADDRESS_DEL]){
        [_viewModel requestAddress:YES];
    }else if([respondModel.requestUrl isEqualToString:URL_ADDRESS_QUERY]){
        [_addressView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onRequestNoDatas:(Boolean)isFirst{
    [self showNoDataView:isFirst];
    [_addressView onRequestNoDatas:isFirst];
}

-(void)onGoAddAddressPage:(AddressInfoModel *)model{
    [AddAddressPage show:self model:model];
}

-(void)onGoBackLastPage{
    [self backLastPage];
}


@end


