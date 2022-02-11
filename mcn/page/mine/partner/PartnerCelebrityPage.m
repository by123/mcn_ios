//
//  PartnerCelebrityPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "PartnerCelebrityPage.h"
#import "PartnerCelebrityView.h"

@interface PartnerCelebrityPage()<PartnerCelebrityViewDelegate>

@property(strong, nonatomic)PartnerCelebrityView *partnerCelebrityView;
@property(strong, nonatomic)PartnerCelebrityViewModel *viewModel;
@property(copy, nonatomic)NSString *mchId;

@end

@implementation PartnerCelebrityPage

+(void)show:(BaseViewController *)controller mchId:(NSString *)mchId{
    PartnerCelebrityPage *page = [[PartnerCelebrityPage alloc]init];
    page.mchId = mchId;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"主播信息" needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[PartnerCelebrityViewModel alloc]init];
    _viewModel.mchId = _mchId;
    _viewModel.delegate = self;
    
    _partnerCelebrityView =[[PartnerCelebrityView alloc]initWithViewModel:_viewModel];
    _partnerCelebrityView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _partnerCelebrityView.backgroundColor = cwhite;
    [self.view addSubview:_partnerCelebrityView];
    [_viewModel requestDetail];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_MCH_AUTHENTICATE_INFO]){
        [_partnerCelebrityView updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

