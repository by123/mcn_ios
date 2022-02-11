//
//  LogisticalPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "LogisticalPage.h"
#import "LogisticalView.h"

@interface LogisticalPage()<LogisticalViewDelegate>

@property(strong, nonatomic)LogisticalView *logisticalView;
@property(strong, nonatomic)LogisticalViewModel *viewModel;
@property(copy, nonatomic)NSString *cooperationId;

@end

@implementation LogisticalPage

+(void)show:(BaseViewController *)controller cooperationId:(NSString *)cooperationId{
    LogisticalPage *page = [[LogisticalPage alloc]init];
    page.cooperationId = cooperationId;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"物流信息" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[LogisticalViewModel alloc]init];
    _viewModel.cooperationId = _cooperationId;
    _viewModel.delegate = self;
    
    _logisticalView =[[LogisticalView alloc]initWithViewModel:_viewModel];
    _logisticalView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _logisticalView.backgroundColor = cwhite;
    [self.view addSubview:_logisticalView];
    
    [_viewModel requestLogistical];
    
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_PROJECT_DELIVERY]){
        [_logisticalView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}



@end

