//
//  CapitalDetailPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "CapitalDetailPage.h"
#import "CapitalDetailView.h"

@interface CapitalDetailPage()<CapitalDetailViewDelegate>

@property(strong, nonatomic)CapitalDetailView *capitalDetailView;
@property(strong, nonatomic)CapitalDetailViewModel *viewModel;
@property(copy, nonatomic)NSString *orderId;

@end

@implementation CapitalDetailPage

+(void)show:(BaseViewController *)controller orderId:(NSString *)orderId{
    CapitalDetailPage *page = [[CapitalDetailPage alloc]init];
    page.orderId = orderId;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"账单详情" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[CapitalDetailViewModel alloc]init];
    _viewModel.orderId = _orderId;
    _viewModel.delegate = self;
    
    _capitalDetailView =[[CapitalDetailView alloc]initWithViewModel:_viewModel];
    _capitalDetailView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _capitalDetailView.backgroundColor = cbg2;
    [self.view addSubview:_capitalDetailView];
    
    [_viewModel requestDetail];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_CAPITAL_DETAIL]){
        [_capitalDetailView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

