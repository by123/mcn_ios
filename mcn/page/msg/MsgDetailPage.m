//
//  MsgDetailPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "MsgDetailPage.h"
#import "MsgDetailView.h"
#import "MainPage.h"

@interface MsgDetailPage()<MsgDetailViewDelegate>

@property(strong, nonatomic)MsgDetailView *msgDetailView;
@property(strong, nonatomic)MsgDetailViewModel *viewModel;

@end

@implementation MsgDetailPage

+(void)show:(BaseViewController *)controller msgId:(NSString *)msgId{
    MsgDetailPage *page = [[MsgDetailPage alloc]init];
    page.msgId = msgId;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:MSG_EMPTY needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[MsgDetailViewModel alloc]init];
    _viewModel.msgId = _msgId;
    _viewModel.delegate = self;
    
    _msgDetailView =[[MsgDetailView alloc]initWithViewModel:_viewModel];
    _msgDetailView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _msgDetailView.backgroundColor = cwhite;
    [self.view addSubview:_msgDetailView];
    
    [_viewModel requestMsgDetail];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl containsString:URL_MESSAGE_DETAIL]){
        [_msgDetailView updateView];
    }else if([respondModel.requestUrl containsString:URL_MCHINVITE_CELEBRITY_AGREE]){
        [LCProgressHUD showMessage:@"操作成功!"];
        [self backLastPage];
    }
    
}

-(void)onRequestFail:(NSString *)msg{
    
}


-(void)backLastPage{
    if(self.navigationController.viewControllers.count == 1){
        [STWindowUtil clearAllAndOpenNewPage:[[MainPage alloc]init]];
    }else{
        [super backLastPage];
    }
}

-(void)onNotExist{
    _viewModel.model.optState = 1;
    [_msgDetailView updateView];
}


@end

