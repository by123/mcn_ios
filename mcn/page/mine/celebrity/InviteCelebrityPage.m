//
//  InviteCelebrityPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "InviteCelebrityPage.h"
#import "InviteCelebrityView.h"
#import "STObserverManager.h"

@interface InviteCelebrityPage()<InviteCelebrityViewDelegate>

@property(strong, nonatomic)InviteCelebrityView *inviteCelebrityView;
@property(strong, nonatomic)InviteCelebrityViewModel *viewModel;

@end

@implementation InviteCelebrityPage

+(void)show:(BaseViewController *)controller{
    InviteCelebrityPage *page = [[InviteCelebrityPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"邀请主播" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[InviteCelebrityViewModel alloc]init];
    _viewModel.delegate = self;
    
    _inviteCelebrityView =[[InviteCelebrityView alloc]initWithViewModel:_viewModel];
    _inviteCelebrityView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _inviteCelebrityView.backgroundColor = cbg2;
    [self.view addSubview:_inviteCelebrityView];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([URL_MCHINVITE_ADD isEqualToString:respondModel.requestUrl]){
        [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_ADD_CELEBRITY msg:nil];
        [self backLastPage];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

