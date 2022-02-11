//
//  WithdrawListPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "WithdrawListPage.h"
#import "WithdrawListView.h"

@interface WithdrawListPage()<WithdrawListViewDelegate>

@property(strong, nonatomic)WithdrawListView *withdrawListView;
@property(strong, nonatomic)WithdrawListViewModel *viewModel;

@end

@implementation WithdrawListPage

+(void)show:(BaseViewController *)controller{
    WithdrawListPage *page = [[WithdrawListPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"提现记录" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[WithdrawListViewModel alloc]init];
    _viewModel.delegate = self;
    
    _withdrawListView =[[WithdrawListView alloc]initWithViewModel:_viewModel];
    _withdrawListView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _withdrawListView.backgroundColor = cbg2;
    [self.view addSubview:_withdrawListView];
    
    [_viewModel reqeustList:YES];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_WITHDRAW_LIST]){
        [_withdrawListView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onRequestNoDatas:(Boolean)isFirst{
    [_withdrawListView onRequestNoDatas:isFirst];
}

@end

