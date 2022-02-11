//
//  SelectCelebrityPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "SelectCelebrityPage.h"
#import "SelectCelebrityView.h"
#import "CooperationPage.h"
#import "STObserverManager.h"
#import "CelebrityParamModel.h"

@interface SelectCelebrityPage()<SelectCelebrityViewDelegate>

@property(strong, nonatomic)SelectCelebrityView *selectCelebrityView;
@property(strong, nonatomic)SelectCelebrityViewModel *viewModel;
@property(strong, nonatomic)CelebrityParamModel *celebrityModel;

@end

@implementation SelectCelebrityPage

+(void)show:(BaseViewController *)controller model:(CelebrityParamModel *)model{
    SelectCelebrityPage *page = [[SelectCelebrityPage alloc]init];
    page.celebrityModel = model;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf)
    [self showSTNavigationBar:@"选择主播" needback:YES rightBtn:@"全选" block:^{
        [weakSelf selectAll];
    }];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[SelectCelebrityViewModel alloc]init];
    _viewModel.celebrityModel = _celebrityModel;
    _viewModel.delegate = self;
    
    _selectCelebrityView =[[SelectCelebrityView alloc]initWithViewModel:_viewModel];
    _selectCelebrityView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _selectCelebrityView.backgroundColor = cbg2;
    [self.view addSubview:_selectCelebrityView];
    
    [_viewModel requestList];
}

-(void)selectAll{
    if(!IS_NS_COLLECTION_EMPTY(_viewModel.datas)){
        for(CelebrityModel *model in _viewModel.datas){
            model.isSelect = YES;
        }
    }
    [_selectCelebrityView updateView];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_CELEBRITY_LIST]){
        [_selectCelebrityView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onBackCooperationPage:(NSMutableArray *)celebrityDatas{
    _viewModel.celebrityModel.datas = celebrityDatas;
    [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_UPDATE_CELEBRITY msg:_viewModel.celebrityModel];
    [self backLastPage];
}

@end

