//
//  SchdulePage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "SchdulePage.h"
#import "SchduleView.h"

@interface SchdulePage()<SchduleViewDelegate>

@property(strong, nonatomic)SchduleView *schduleView;
@property(strong, nonatomic)SchduleViewModel *viewModel;
@property(copy, nonatomic)NSString *cooperationId;
@property(copy, nonatomic)NSString *cooperationName;

@end

@implementation SchdulePage

+(void)show:(BaseViewController *)controller cooperationId:(NSString *)cooperationId cooperationName:(NSString *)cooperationName{
    SchdulePage *page = [[SchdulePage alloc]init];
    page.cooperationName = cooperationName;
    page.cooperationId = cooperationId;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"合作进度" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[SchduleViewModel alloc]init];
    _viewModel.cooperationName = _cooperationName;
    _viewModel.cooperationId = _cooperationId;
    _viewModel.delegate = self;
    
    _schduleView =[[SchduleView alloc]initWithViewModel:_viewModel];
    _schduleView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _schduleView.backgroundColor = cwhite;
    [self.view addSubview:_schduleView];
    
    [_viewModel requestSchedule];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_PROJECT_OPERATIONS]){
        [_schduleView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

