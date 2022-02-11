//
//  AddPublickBankPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AddPublickBankPage.h"
#import "AddPublickBankView.h"
#import "STObserverManager.h"
#import "BankPage.h"

@interface AddPublickBankPage()<AddPublickBankViewDelegate>

@property(strong, nonatomic)AddPublickBankView *addPublickBankView;
@property(strong, nonatomic)AddPublickBankViewModel *viewModel;

@end

@implementation AddPublickBankPage

+(void)show:(BaseViewController *)controller{
    AddPublickBankPage *page = [[AddPublickBankPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"对公银行卡" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[AddPublickBankViewModel alloc]init];
    _viewModel.delegate = self;
    
    _addPublickBankView =[[AddPublickBankView alloc]initWithViewModel:_viewModel];
    _addPublickBankView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _addPublickBankView.backgroundColor = cbg2;
    [self.view addSubview:_addPublickBankView];
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

