//
//  CelebrityPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "CelebrityPage.h"
#import "CelebrityView.h"
#import "InviteCelebrityPage.h"
#import "STObserverManager.h"
#import "CelebrityDetailPage.h"

@interface CelebrityPage()<CelebrityViewDelegate,STObserverProtocol>

@property(strong, nonatomic)CelebrityView *celebrityView;
@property(strong, nonatomic)CelebrityViewModel *viewModel;

@end

@implementation CelebrityPage

+(void)show:(BaseViewController *)controller{
    CelebrityPage *page = [[CelebrityPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf)
    [self showSTNavigationBar:@"主播管理" needback:YES rightBtn:@"邀请主播" block:^{
        [InviteCelebrityPage show:weakSelf];
    }];
    [self initView];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:NOTIFY_ADD_CELEBRITY delegate:self];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:NOTIFY_ADD_CELEBRITY];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[CelebrityViewModel alloc]init];
    _viewModel.delegate = self;
    
    _celebrityView =[[CelebrityView alloc]initWithViewModel:_viewModel];
    _celebrityView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _celebrityView.backgroundColor = cbg2;
    [self.view addSubview:_celebrityView];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([key isEqualToString:NOTIFY_ADD_CELEBRITY]){
        [_celebrityView updateView];
    }
}

-(void)onGoCelebrityDetailPage:(NSString *)mchId type:(int)type operateState:(int)operateState celebrityId:(NSString *)celebrityId{
    [CelebrityDetailPage show:self mchId:mchId type:type operateState:operateState celebrityId:celebrityId];
}


@end

