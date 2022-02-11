//
//  VerifyCodePage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "VerifyCodePage.h"
#import "VerifyCodeView.h"
#import "MainPage.h"
#import "AccountManager.h"
#import "UpdatePhonePage.h"
#import "FirstLoginPage.h"

@interface VerifyCodePage()<VerifyCodeViewDelegate>

@property(strong, nonatomic)VerifyCodeView *verifyCodeView;
@property(strong, nonatomic)VerifyCodeViewModel *viewModel;
@property(copy, nonatomic)NSString *phoneNum;
@property(assign, nonatomic)Boolean updatePhone;

@end

@implementation VerifyCodePage

+(void)show:(BaseViewController *)controller phoneNum:(NSString *)phoneNum updatePhone:(Boolean)updatePhone{
    VerifyCodePage *page = [[VerifyCodePage alloc]init];
    page.updatePhone = updatePhone;
    page.phoneNum = phoneNum;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self showSTNavigationBar:MSG_EMPTY needback:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[VerifyCodeViewModel alloc]init];
    _viewModel.updatePhone = _updatePhone;
    _viewModel.phoneNum = _phoneNum;
    _viewModel.delegate = self;
    
    _verifyCodeView =[[VerifyCodeView alloc]initWithViewModel:_viewModel];
    _verifyCodeView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _verifyCodeView.backgroundColor = cwhite;
    [self.view addSubview:_verifyCodeView];
    
    if(_updatePhone){
        [_viewModel updateSendVerifyCode];
    }else{
        [_viewModel sendVerifyCode];
    }
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_VERIFYCODE_LOGIN]){
        UserModel *model = [[AccountManager sharedAccountManager]getUserModel];
        if(model.isFirst == 1){
            [FirstLoginPage show:self result:data];
        }else{
            [MainPage show:self];
        }
    }else if([respondModel.requestUrl isEqualToString:URL_UPDATEPHONE_VERIFYCODE]){
        [UpdatePhonePage show:self];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

