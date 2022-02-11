//
//  UpdatePhonePage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "UpdatePhonePage.h"
#import "UpdatePhoneView.h"
#import "BusinessEditPage.h"
#import "STObserverManager.h"
#import "AccountManager.h"

@interface UpdatePhonePage()<UpdatePhoneViewDelegate>

@property(strong, nonatomic)UpdatePhoneView *updatePhoneView;
@property(strong, nonatomic)UpdatePhoneViewModel *viewModel;

@end

@implementation UpdatePhonePage

+(void)show:(BaseViewController *)controller{
    UpdatePhonePage *page = [[UpdatePhonePage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"变更手机号" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[UpdatePhoneViewModel alloc]init];
    _viewModel.delegate = self;
    
    _updatePhoneView =[[UpdatePhoneView alloc]initWithViewModel:_viewModel];
    _updatePhoneView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _updatePhoneView.backgroundColor = cbg2;
    [self.view addSubview:_updatePhoneView];
}


-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_UPDATE_MOBILE]){
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[BusinessEditPage class]]) {
                UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
                userModel.mobile = data;
                [[AccountManager sharedAccountManager] saveUserModel:userModel];
                [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_UPDATE_PHONE msg:nil];
                [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_UPDATE_BUSINESS msg:nil];
                BusinessEditPage *page =(BusinessEditPage *)controller;
                [self.navigationController popToViewController:page animated:YES];
            }
        }
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

