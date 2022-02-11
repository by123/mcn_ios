//
//  CooperationPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "CooperationPage.h"
#import "CooperationView.h"
#import "AddressPage.h"
#import "STObserverManager.h"
#import "SelectCelebrityPage.h"
#import "CelebrityParamModel.h"
#import "AccountManager.h"

@interface CooperationPage()<CooperationViewDelegate,STObserverProtocol>

@property(strong, nonatomic)CooperationView *cooperationView;
@property(strong, nonatomic)CooperationViewModel *viewModel;
@property(strong, nonatomic)NSMutableArray *datas;

@end

@implementation CooperationPage

+(void)show:(BaseViewController *)controller datas:(NSMutableArray *)datas{
    CooperationPage *page = [[CooperationPage alloc]init];
    page.datas = datas;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    [self showSTNavigationBar:userModel.roleType == RoleType_Mcn ? @"MCN提交合作" : @"网红提交合作" needback:YES];
    [self initView];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:NOTIFY_SELECT_ADDRESS delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:NOTIFY_UPDATE_CELEBRITY delegate:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:NOTIFY_SELECT_ADDRESS];
    [[STObserverManager sharedSTObserverManager] removeSTObsever:NOTIFY_UPDATE_CELEBRITY];

}

-(void)initView{
    _viewModel = [[CooperationViewModel alloc]init];
    _viewModel.datas = _datas;
    _viewModel.delegate = self;
    
    for(ShopModel *model in _datas){
        [STLog print:@"商户" content:model.supplierName];
        for(ShopSkuModel *skuModel in model.skuModels){
            [STLog print:@"产品" content:skuModel.spuName];
        }
    }
    
    _cooperationView =[[CooperationView alloc]initWithViewModel:_viewModel];
    _cooperationView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _cooperationView.backgroundColor = cbg2;
    [self.view addSubview:_cooperationView];
    
    [_viewModel requestDefaultAddress];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_GET_ADDRESS_DEFAULT]){
        [_cooperationView updateView];
    }else if([respondModel.requestUrl isEqualToString:URL_PROJECT_SUBMIT]){
        [LCProgressHUD showMessage:@"提交成功!"];
        [self backLastPage];
        [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_GO_PARTNER msg:nil];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


-(void)onGoAddressPage:(NSString *)addressId{
    [AddressPage show:self type:AddressType_Select addressId:addressId];
}

-(void)onGoSelectCelebrityPage:(CelebrityParamModel *)model{
    [SelectCelebrityPage show:self model:model];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:NOTIFY_SELECT_ADDRESS]){
        _viewModel.addressModel = msg;
        [_cooperationView updateView];
    }else if([key isEqualToString:NOTIFY_UPDATE_CELEBRITY]){
        CelebrityParamModel *model = msg;
        [_cooperationView updateCelebrity:model];
    }
}



@end

