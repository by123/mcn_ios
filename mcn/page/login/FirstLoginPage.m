//
//  FirstLoginPage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "FirstLoginPage.h"
#import "FirstLoginView.h"
#import "MainPage.h"

@interface FirstLoginPage()<FirstLoginViewDelegate>

@property(strong, nonatomic)FirstLoginView *firstLoginView;
@property(strong, nonatomic)FirstLoginViewModel *viewModel;
@property(copy, nonatomic)NSString *result;

@end

@implementation FirstLoginPage

+(void)show:(BaseViewController *)controller result:(NSString *)result{
    FirstLoginPage *page = [[FirstLoginPage alloc]init];
    page.result = result;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:MSG_ABOUT_CHANGEPWD needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    _viewModel = [[FirstLoginViewModel alloc]init];
    _viewModel.delegate = self;
    
    _firstLoginView =[[FirstLoginView alloc]initWithViewModel:_viewModel];
    _firstLoginView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _firstLoginView.backgroundColor = cbg2;
    [self.view addSubview:_firstLoginView];
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MainPage show:self];
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end

