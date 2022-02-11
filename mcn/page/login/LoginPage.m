//
//  LoginPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "LoginPage.h"
#import "LoginView.h"
#import "ForgetPswPage.h"
#import "MainPage.h"
#import "AgreementPage.h"
#import "AccountManager.h"
#import "STWindowUtil.h"
#import "VerifyCodePage.h"
#import "FirstLoginPage.h"

@interface LoginPage ()<LoginViewDelegate>

@property(strong, nonatomic)LoginViewModel *viewModel;
@property(strong, nonatomic)LoginView *loginView;
@property(copy, nonatomic)NSString *toastContent;

@end

@implementation LoginPage

+(void)show:(BaseViewController *)controller{
    LoginPage *page = [[LoginPage alloc]init];
    BaseNavigationController *navigationController = [[BaseNavigationController alloc]initWithRootViewController:page];
    [UIApplication sharedApplication].keyWindow.rootViewController = navigationController;
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
}

+(void)back:(BaseViewController *)controller content:(nonnull NSString *)content{
    LoginPage *page = [[LoginPage alloc]init];
    page.toastContent = content;
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:page];
    [controller presentViewController:nav animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel = [[LoginViewModel alloc]init];
    _viewModel.delegate = self;
    
    _loginView = [[LoginView alloc]initWithViewModel:_viewModel];
    _loginView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:_loginView];
    
    if(!IS_NS_STRING_EMPTY(_toastContent)){
        WS(weakSelf)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LCProgressHUD showMessage:weakSelf.toastContent];
            
        });
    }
}




-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_LOGIN]){
        UserModel *model = [[AccountManager sharedAccountManager]getUserModel];
        if(model.isFirst == 1){
            [FirstLoginPage show:self result:data];
        }else{
            [MainPage show:self];
        }
    }
}

-(void)onRequestFail:(NSString *)msg{
    if(_loginView){
        [_loginView updateTips:msg];
    }
}

-(void)goNextPage{
    [ForgetPswPage show:self];
}

-(void)onGoAgreementPage{
    [AgreementPage show:self];
}

-(void)onGoVerifyCodePage:(NSString *)phoneNum{
    [VerifyCodePage show:self phoneNum:phoneNum updatePhone:NO];
}

@end
