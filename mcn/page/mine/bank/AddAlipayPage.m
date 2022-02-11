//
//  AddAlipayPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AddAlipayPage.h"
#import "AddAlipayView.h"
#import "AccountManager.h"
#import "BankPage.h"
#import "STObserverManager.h"

@interface AddAlipayPage()<AddAlipayViewDelegate>

@property(strong, nonatomic)AddAlipayView *addAlipayView;
@property(strong, nonatomic)AddAlipayViewModel *viewModel;

@end

@implementation AddAlipayPage

+(void)show:(BaseViewController *)controller{
    AddAlipayPage *page = [[AddAlipayPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    [self showSTNavigationBar:userModel.roleType == RoleType_Celebrity ? @"个人支付宝" : @"企业支付宝" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[AddAlipayViewModel alloc]init];
    _viewModel.delegate = self;
    
    _addAlipayView =[[AddAlipayView alloc]initWithViewModel:_viewModel];
    _addAlipayView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _addAlipayView.backgroundColor = cbg2;
    [self.view addSubview:_addAlipayView];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_BANK_ADD]){
        [LCProgressHUD showMessage:@"添加成功!"];
        [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_UPDATE_BANK msg:nil];
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[BankPage class]]) {
                BankPage *page =(BankPage *)controller;
                [self.navigationController popToViewController:page animated:YES];
            }
        }
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

