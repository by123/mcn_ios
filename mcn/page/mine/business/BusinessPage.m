//
//  BusinessPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "BusinessPage.h"
#import "BusinessView.h"
#import "BusinessEditPage.h"
#import "STObserverManager.h"

@interface BusinessPage()<BusinessViewDelegate,STObserverProtocol>

@property(strong, nonatomic)BusinessView *businessView;
@property(strong, nonatomic)BusinessViewModel *viewModel;
@property(copy, nonatomic)NSString *mchId;
@property(assign, nonatomic)Boolean isEdit;

@end

@implementation BusinessPage

+(void)show:(BaseViewController *)controller mchId:(NSString *)mchId isEdit:(Boolean)isEdit{
    BusinessPage *page = [[BusinessPage alloc]init];
    page.mchId = mchId;
    page.isEdit = isEdit;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(_isEdit){
        WS(weakSelf)
        [self showSTNavigationBar:@"个人名片" needback:YES rightBtn:@"编辑" block:^{
            [BusinessEditPage show:weakSelf mchId:weakSelf.viewModel.mchId];
        }];
    }else{
        [self showSTNavigationBar:@"个人名片" needback:YES];
    }
    [self initView];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:NOTIFY_UPDATE_BUSINESS];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[BusinessViewModel alloc]init];
    _viewModel.mchId = _mchId;
    _viewModel.delegate = self;
    
    _businessView =[[BusinessView alloc]initWithViewModel:_viewModel];
    _businessView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _businessView.backgroundColor = cwhite;
    [self.view addSubview:_businessView];
    
    [_viewModel requestDetail];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:NOTIFY_UPDATE_BUSINESS delegate:self];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_MCH_MY_CARD]){
        [_businessView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onGoBusinessEditPage{
    
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([NOTIFY_UPDATE_BUSINESS isEqualToString:key]){
        [_viewModel requestDetail];
    }
}


@end

