//
//  ChangeAccountPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "ChangeAccountPage.h"
#import "ChangeAccountView.h"
#import "MainPage.h"
#import "AccountManager.h"
#import "LoginPage.h"
#import "FirstLoginPage.h"

@interface ChangeAccountPage()<ChangeAccountViewDelegate>

@property(strong, nonatomic)ChangeAccountView *changeAccountView;
@property(strong, nonatomic)ChangeAccountViewModel *viewModel;

@end

@implementation ChangeAccountPage

+(void)show:(BaseViewController *)controller{
    ChangeAccountPage *page = [[ChangeAccountPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf)
    [self showSTNavigationBar:MSG_SETTING_CHANGEACCOUNT needback:YES rightBtn:@"管理账号" block:^{
        weakSelf.viewModel.clearStatu = !weakSelf.viewModel.clearStatu;
        [weakSelf.changeAccountView updateView];
        [weakSelf changeSTNavigationBarRightText:weakSelf.viewModel.clearStatu ? @"取消" : @"管理账号"];
    }];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[ChangeAccountViewModel alloc]init];
    _viewModel.delegate = self;
    
    _changeAccountView =[[ChangeAccountView alloc]initWithViewModel:_viewModel];
    _changeAccountView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _changeAccountView.backgroundColor = cbg2;
    [self.view addSubview:_changeAccountView];
}


-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    UserModel *model = [[AccountManager sharedAccountManager]getUserModel];
    if(model.isFirst == 1){
        [FirstLoginPage show:self result:data];
    }else{
        [MainPage show:self];
    }
}

-(void)onAddNewAccount{
    [STUserDefaults saveKeyValue:UD_USERNAME value:MSG_EMPTY];
    [LoginPage show:self];
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onClearUser{
    [_changeAccountView updateView];
}


@end

