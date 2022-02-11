//
//  WithdrawPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "WithdrawPage.h"
#import "WithdrawView.h"
#import "WithdrawListPage.h"
#import "BankPage.h"
#import "STObserverManager.h"

@interface WithdrawPage()<WithdrawViewDelegate,STObserverProtocol>

@property(strong, nonatomic)WithdrawView *withdrawView;
@property(strong, nonatomic)WithdrawViewModel *viewModel;

@end

@implementation WithdrawPage

+(void)show:(BaseViewController *)controller{
    WithdrawPage *page = [[WithdrawPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf)
    [self showSTNavigationBar:@"提现" needback:YES rightBtn:@"提现记录" block:^{
        [WithdrawListPage show:weakSelf];
    }];
    [self initView];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:NOTIFY_SELECT_BANK delegate:self];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:NOTIFY_SELECT_BANK];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[WithdrawViewModel alloc]init];
    _viewModel.delegate = self;
    
    _withdrawView =[[WithdrawView alloc]initWithViewModel:_viewModel];
    _withdrawView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _withdrawView.backgroundColor = cwhite;
    [self.view addSubview:_withdrawView];
    
    [_viewModel requestBankList];
    [_viewModel requestWithdraw];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_BANK_LIST]){
        [_withdrawView updateBankView];
    }else if([respondModel.requestUrl isEqualToString:URL_BALANCE]){
        [_withdrawView updateView];
    }else if([respondModel.requestUrl isEqualToString:URL_WITHDRAW_BALANCE]){
        [STShowToast show:@"提现成功!"];
        [self backLastPage];
    }else if([respondModel.requestUrl isEqualToString:URL_WITHDRAW_CONFIG_TIPS]){
        [_withdrawView updateTipsView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onGoBankPage:(Boolean)isSelect{
    [BankPage show:self isSelect:isSelect];
}


-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:NOTIFY_SELECT_BANK]){
        _viewModel.bankModel = msg;
        [_withdrawView updateBankView];
        [_viewModel requestWithdrawConfig];
    }
}
@end

