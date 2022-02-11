//
//  HomeSearchPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "HomeSearchPage.h"
#import "HomeSearchView.h"
#import "ProductDetailPage.h"
#import "CooperationPage.h"
#import "STDialog.h"
#import "QulificationsPage.h"
#import "AccountManager.h"

@interface HomeSearchPage()<HomeSearchViewDelegate,STDialogDelegate>

@property(strong, nonatomic)HomeSearchView *homeSearchView;
@property(strong, nonatomic)HomeSearchViewModel *viewModel;
@property(strong, nonatomic)STDialog *authenticateDialog;

@end

@implementation HomeSearchPage

+(void)show:(BaseViewController *)controller{
    HomeSearchPage *page = [[HomeSearchPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"搜索" needback:YES];
    [self initView];
    [self initAuthDialog];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[HomeSearchViewModel alloc]init];
    _viewModel.delegate = self;
    
    _homeSearchView =[[HomeSearchView alloc]initWithViewModel:_viewModel];
    _homeSearchView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _homeSearchView.backgroundColor = cbg2;
    [self.view addSubview:_homeSearchView];
    
    [_viewModel requestGoodsList:YES];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_GOODS_HOME_LIST]){
        [_homeSearchView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onRequestNoDatas:(Boolean)isFirst{
    [_homeSearchView onRequestNoDatas:isFirst];
}

-(void)onGoProductDetailPage:(NSString *)skuId{
    [ProductDetailPage show:self skuId:skuId];
}

-(void)onGoCooperationPage:(NSMutableArray *)datas{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if(userModel.authenticateState == AuthenticateState_Success){
        [CooperationPage show:self datas:datas];
    }else{
        _authenticateDialog.hidden = NO;
    }
}

-(void)onConfirmBtnClicked:(id)dialog{
    _authenticateDialog.hidden = YES;
    [QulificationsPage show:self];
}

-(void)onCancelBtnClicked:(id)dialog{
    _authenticateDialog.hidden = YES;
}


-(void)initAuthDialog{
    _authenticateDialog = [[STDialog alloc]initWithTitle:@"提醒" content:@"您还未提交资质认证,点击确定提交" subContent:MSG_EMPTY size:CGSizeMake(STWidth(315), STHeight(200))];
    _authenticateDialog.delegate = self;
    _authenticateDialog.hidden = YES;
    [_authenticateDialog showConfirmBtn:YES cancelBtn:YES];
    [_authenticateDialog setConfirmBtnStr:@"确定" cancelStr:@"取消"];
    [self.view addSubview:_authenticateDialog];
}

@end

