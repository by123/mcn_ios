//
//  SettingPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "SettingPage.h"
#import "SettingView.h"
#import "LoginPage.h"
#import "AboutPage.h"
#import "AccountManager.h"
#import "STNetUtil.h"
#import "ChangePwdPage.h"
#import "ChangeAccountPage.h"

@interface SettingPage()<SettingViewDelegate>

@property(strong, nonatomic)SettingView *settingView;
@property(strong, nonatomic)SettingViewModel *viewModel;

@end

@implementation SettingPage

+(void)show:(BaseViewController *)controller{
    SettingPage *page = [[SettingPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:MSG_MINE_SETTING needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[SettingViewModel alloc]init];
    _viewModel.delegate = self;
    
    _settingView =[[SettingView alloc]initWithViewModel:_viewModel];
    _settingView.backgroundColor = cbg2;
    _settingView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_settingView];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onLogout{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    dic[@"authorization"] = model.authToken;
    WS(weakSelf)
    [STNetUtil get:URL_LOGOUT parameters:dic success:^(RespondModel *respondModel) {
        [[AccountManager sharedAccountManager] clearUserModel];
        [LoginPage show:weakSelf];
    } failure:^(int errorCode) {
        
    }];
}

-(void)onGoChangeAccountPage{
    [ChangeAccountPage show:self];
}

-(void)onGoNextPage:(NSInteger)position{
    switch (position) {
        case 0:
            [ChangePwdPage show:self];
            break;
        case 1:
            [AboutPage show:self];
            break;
        default:
            break;
    }
}

@end

