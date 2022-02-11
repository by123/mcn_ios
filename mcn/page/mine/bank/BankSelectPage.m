//
//  BankSelectPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "BankSelectPage.h"
#import "BankSelectView.h"
#import "AddAlipayPage.h"
#import "AddBankPage.h"
#import "AddPublickBankPage.h"
#import "AccountManager.h"

@interface BankSelectPage()<BankSelectViewDelegate>

@property(strong, nonatomic)BankSelectView *bankSelectView;
@property(strong, nonatomic)BankSelectViewModel *viewModel;

@end

@implementation BankSelectPage

+(void)show:(BaseViewController *)controller{
    BankSelectPage *page = [[BankSelectPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"添加银行卡" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[BankSelectViewModel alloc]init];
    _viewModel.delegate = self;
    
    _bankSelectView =[[BankSelectView alloc]initWithViewModel:_viewModel];
    _bankSelectView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _bankSelectView.backgroundColor = cwhite;
    [self.view addSubview:_bankSelectView];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onGoAddPage:(int)current{
    if(current == 0){
       [AddAlipayPage show:self];
        return;
    }
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    if(model.roleType == RoleType_Celebrity){
        [AddBankPage show:self];
    }else{
        [AddPublickBankPage show:self];
    }
}


@end

