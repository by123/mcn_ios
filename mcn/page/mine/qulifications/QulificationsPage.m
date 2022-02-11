//
//  QulificationsPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "QulificationsPage.h"
#import "QulificationsView.h"
#import "QulificationsEditPage.h"
#import "MainPage.h"

@interface QulificationsPage()<QulificationsViewDelegate>

@property(strong, nonatomic)QulificationsView *qulificationsView;
@property(strong, nonatomic)QulificationsViewModel *viewModel;

@end

@implementation QulificationsPage

+(void)show:(BaseViewController *)controller{
    QulificationsPage *page = [[QulificationsPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"认证资质" needback:YES rightBtn:@"资质变更" block:^{
        
    }];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[QulificationsViewModel alloc]init];
    _viewModel.delegate = self;
    
    _qulificationsView =[[QulificationsView alloc]initWithViewModel:_viewModel];
    _qulificationsView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _qulificationsView.backgroundColor = cwhite;
    [self.view addSubview:_qulificationsView];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onGoQulificationsEditPage:(RoleType)roleType{
    [QulificationsEditPage show:self roleType:roleType model:nil isEdit:NO];
}


@end

