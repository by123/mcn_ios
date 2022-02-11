//
//  AddAddressPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AddAddressPage.h"
#import "AddAddressView.h"
#import "STObserverManager.h"

@interface AddAddressPage()<AddAddressViewDelegate>

@property(strong, nonatomic)AddAddressView *addAddressView;
@property(strong, nonatomic)AddAddressViewModel *viewModel;
@property(strong, nonatomic)AddressInfoModel *model;

@end

@implementation AddAddressPage

+(void)show:(BaseViewController *)controller model:(AddressInfoModel *)model{
    AddAddressPage *page = [[AddAddressPage alloc]init];
    page.model = model;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:_model == nil ? @"新增地址" : @"编辑地址" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[AddAddressViewModel alloc]init];
    _viewModel.type = AddAddressType_Add;
    if(_model){
        _viewModel.model = _model;
        _viewModel.type = AddAddressType_Edit;
    }
    _viewModel.delegate = self;
    _addAddressView =[[AddAddressView alloc]initWithViewModel:_viewModel];
    _addAddressView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _addAddressView.backgroundColor = cwhite;
    [self.view addSubview:_addAddressView];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_ADDRESS_LIST msg:nil];
    [self backLastPage];
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

