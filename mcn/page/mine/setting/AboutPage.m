//
//  AboutPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AboutPage.h"
#import "AboutView.h"
#import "AgreementPage.h"

@interface AboutPage()<AboutViewDelegate>

@property(strong, nonatomic)AboutView *aboutView;
@property(strong, nonatomic)AboutViewModel *viewModel;

@end

@implementation AboutPage

+(void)show:(BaseViewController *)controller{
    AboutPage *page = [[AboutPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:MSG_ABOUT_TITLE needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[AboutViewModel alloc]init];
    _viewModel.delegate = self;
    
    _aboutView =[[AboutView alloc]initWithViewModel:_viewModel];
    _aboutView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _aboutView.backgroundColor = cbg2;
    [self.view addSubview:_aboutView];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    
}

-(void)onRequestFail:(NSString *)msg{
    
}

-(void)onGoAgressmentPage{
    [AgreementPage show:self];
}


@end

