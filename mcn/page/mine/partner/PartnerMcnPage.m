//
//  PartnerMcnPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "PartnerMcnPage.h"
#import "PartnerMcnView.h"

@interface PartnerMcnPage()<PartnerMcnViewDelegate>

@property(strong, nonatomic)PartnerMcnView *partnerMcnView;
@property(strong, nonatomic)PartnerMcnViewModel *viewModel;
@property(copy, nonatomic)NSString *mcnId;

@end

@implementation PartnerMcnPage

+(void)show:(BaseViewController *)controller mchId:(NSString *)mcnId{
    PartnerMcnPage *page = [[PartnerMcnPage alloc]init];
    page.mcnId = mcnId;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"MCN机构" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[PartnerMcnViewModel alloc]init];
    _viewModel.mchId = _mcnId;
    _viewModel.delegate = self;
    
    _partnerMcnView =[[PartnerMcnView alloc]initWithViewModel:_viewModel];
    _partnerMcnView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _partnerMcnView.backgroundColor = cbg2;
    [self.view addSubview:_partnerMcnView];
    
    [_viewModel requestDetail];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_MCN_CELEBRITY_LIST]){
        [_partnerMcnView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

