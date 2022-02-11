//
//  StaticticsPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "StaticticsPage.h"
#import "StaticticsView.h"
#import "PartnerDetailPage.h"

@interface StaticticsPage()<StaticticsViewDelegate>

@property(strong, nonatomic)StaticticsView *staticticsView;
@property(strong, nonatomic)StaticticsViewModel *viewModel;
@property(assign, nonatomic)StaticticsType type;

@end

@implementation StaticticsPage

+(void)show:(BaseViewController *)controller type:(StaticticsType)type{
    StaticticsPage *page = [[StaticticsPage alloc]init];
    page.type = type;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:(_type == StaticticsType_Sell) ? @"销售统计" : @"收入统计" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[StaticticsViewModel alloc]init];
    _viewModel.type = _type;
    _viewModel.delegate = self;
    
    _staticticsView =[[StaticticsView alloc]initWithViewModel:_viewModel];
    _staticticsView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _staticticsView.backgroundColor = cwhite;
    [self.view addSubview:_staticticsView];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    
}

-(void)onRequestFail:(NSString *)msg{
    
}


-(void)onGoPartnerDetailPage:(NSString *)cooperationId{
    [PartnerDetailPage show:self cooperationId:cooperationId];
}

@end

