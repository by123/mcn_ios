//
//  BankPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "BankPage.h"
#import "BankView.h"
#import "BankSelectPage.h"
#import "STObserverManager.h"

@interface BankPage()<BankViewDelegate,STObserverProtocol>

@property(strong, nonatomic)BankView *bankView;
@property(strong, nonatomic)BankViewModel *viewModel;
@property(assign, nonatomic)Boolean isSelect;
@end

@implementation BankPage

+(void)show:(BaseViewController *)controller isSelect:(Boolean)isSelect{
    BankPage *page = [[BankPage alloc]init];
    page.isSelect = isSelect;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"收款账户" needback:YES];
    [self initView];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:NOTIFY_UPDATE_BANK delegate:self];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:NOTIFY_UPDATE_BANK];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[BankViewModel alloc]init];
    _viewModel.isSelect = _isSelect;
    _viewModel.delegate = self;
    
    _bankView =[[BankView alloc]initWithViewModel:_viewModel];
    _bankView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _bankView.backgroundColor = cbg2;
    [self.view addSubview:_bankView];
    
    [_viewModel requestBankList];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_BANK_LIST]){
        [_bankView updateView];
    }else if([respondModel.requestUrl isEqualToString:URL_BANK_DEL]){
        [LCProgressHUD showMessage:@"删除成功!"];
        [_viewModel requestBankList];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


-(void)onGoBankSelectPage{
    [BankSelectPage show:self];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([NOTIFY_UPDATE_BANK isEqualToString:key]){
        [_viewModel requestBankList];
    }
}


-(void)onSelectBankModel:(BankModel *)model{
    [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_SELECT_BANK msg:model];
    [self backLastPage];
}

@end

