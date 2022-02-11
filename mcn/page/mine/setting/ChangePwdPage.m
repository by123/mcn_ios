//
//  ChangePwdPage.m
//  cigarette
//
//  Created by xiao ming on 2019/12/16.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "ChangePwdPage.h"
#import "ChangePwdViewModel.h"
#import "ChangePwdView.h"

@interface ChangePwdPage ()
@property(strong, nonatomic)ChangePwdViewModel *viewModel;
@property(strong, nonatomic)ChangePwdView *changePwdView;
@end

@implementation ChangePwdPage

+(void)show:(BaseViewController *)controller{
    ChangePwdPage *page = [[ChangePwdPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:MSG_ABOUT_CHANGEPWD needback:YES];
    [self initView];
}

-(void)initView{
    _viewModel = [[ChangePwdViewModel alloc]init];
    
    _changePwdView =[[ChangePwdView alloc]initWithViewModel:_viewModel];
    _changePwdView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _changePwdView.backgroundColor = cbg2;
    [self.view addSubview:_changePwdView];
}

@end
