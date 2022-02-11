//
//  AddBankPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AddBankPage.h"
#import "AddBankView.h"
#import "AccountManager.h"
#import "STObserverManager.h"
#import "BankPage.h"

@interface AddBankPage()<AddBankViewDelegate>

@property(strong, nonatomic)AddBankView *addBankView;
@property(strong, nonatomic)AddBankViewModel *viewModel;

@end

@implementation AddBankPage

+(void)show:(BaseViewController *)controller{
    AddBankPage *page = [[AddBankPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    [self showSTNavigationBar:userModel.roleType == RoleType_Celebrity ? @"个人银行卡" : @"对公银行卡" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[AddBankViewModel alloc]init];
    _viewModel.delegate = self;
    
    _addBankView =[[AddBankView alloc]initWithViewModel:_viewModel];
    _addBankView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _addBankView.backgroundColor = cbg2;
    [self.view addSubview:_addBankView];
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

