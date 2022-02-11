//
//  CelebrityDetailPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "CelebrityDetailPage.h"
#import "CelebrityDetailView.h"
#import "STObserverManager.h"

@interface CelebrityDetailPage()<CelebrityDetailViewDelegate>

@property(strong, nonatomic)CelebrityDetailView *celebrityDetailView;
@property(strong, nonatomic)CelebrityDetailViewModel *viewModel;
@property(copy, nonatomic)NSString *mchId;
@property(assign, nonatomic)int type;
@property(assign, nonatomic)int operateState;
@property(copy, nonatomic)NSString *celebrityId;

@end

@implementation CelebrityDetailPage

+(void)show:(BaseViewController *)controller mchId:(NSString *)mchId type:(int)type operateState:(int)operateState celebrityId:(NSString *)celebrityId{
    CelebrityDetailPage *page = [[CelebrityDetailPage alloc]init];
    page.celebrityId = celebrityId;
    page.operateState = operateState;
    page.type = type;
    page.mchId = mchId;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"主播详情" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[CelebrityDetailViewModel alloc]init];
    _viewModel.celebrityId = _celebrityId;
    _viewModel.operateState = _operateState;
    _viewModel.mchId = _mchId;
    _viewModel.type = _type;
    _viewModel.delegate = self;
    
    _celebrityDetailView =[[CelebrityDetailView alloc]initWithViewModel:_viewModel];
    _celebrityDetailView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _celebrityDetailView.backgroundColor = cbg2;
    [self.view addSubview:_celebrityDetailView];
    
    [_viewModel requestCelebrityDetail];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_MCH_AUTHENTICATE_INFO]){
        [_celebrityDetailView updateView];
    }else if([respondModel.requestUrl isEqualToString:URL_MCH_REMOVE_CELEBRITY]){
        [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_ADD_CELEBRITY msg:nil];
        [self backLastPage];
    }else if([respondModel.requestUrl isEqualToString:URL_MCHINVITE_REMOVE]){
        [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_ADD_CELEBRITY msg:nil];
        [self backLastPage];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

