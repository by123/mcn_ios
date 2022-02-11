//
//  AddAlipayView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AddAlipayView.h"
#import "AccountManager.h"
#import "STBlankInView.h"
#import "STDefaultBtnView.h"
#import "STImageTipsView.h"
@interface AddAlipayView()<STDefaultBtnViewDelegate,STBlankInViewDelegate>

@property(strong, nonatomic)AddAlipayViewModel *mViewModel;
@property(strong, nonatomic)STBlankInView *accoountView;
@property(strong, nonatomic)STBlankInView *nameView;
@property(strong, nonatomic)STDefaultBtnView *addBtn;

@end

@implementation AddAlipayView

-(instancetype)initWithViewModel:(AddAlipayViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    
    _accoountView = [[STBlankInView alloc]initWithTitle:@"支付宝账号" placeHolder:@"请输入您的支付宝账号"];
    _accoountView.frame = CGRectMake(0, STHeight(15), ScreenWidth, STHeight(60));
    _accoountView.delegate = self;
    [self addSubview:_accoountView];
    
    
    _nameView = [[STBlankInView alloc]initWithTitle:userModel.roleType == RoleType_Celebrity ? @"真实姓名" : @"企业全称" placeHolder:userModel.roleType == RoleType_Celebrity ? @"请输入您的真实姓名" : @"请输入您的企业全称"];
    _nameView.frame = CGRectMake(0, STHeight(75), ScreenWidth, STHeight(60));
    [_nameView hiddenLine];
    [_nameView setMaxLength:15];
    _nameView.delegate = self;
    [self addSubview:_nameView];
    
    STImageTipsView *tipView = [[STImageTipsView alloc]initWithTitle:@"转账时用以确认账户，请如实填写" top:NO];
    tipView.frame = CGRectMake(0, STHeight(135), ScreenWidth, STHeight(50));
    [self addSubview:tipView];
    
    
    _addBtn = [[STDefaultBtnView alloc]initWithTitle:@"确认添加"];
    _addBtn.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
    _addBtn.delegate = self;
    [_addBtn setActive:NO];
    [self addSubview:_addBtn];
}

-(void)onTextFieldDidChange:(id)view{
    [self checkButtonStatu];
}

-(void)checkButtonStatu{
    if(IS_NS_STRING_EMPTY([_nameView getContent])){
        [_addBtn setActive:NO];
        return;
    }
    if(IS_NS_STRING_EMPTY([_accoountView getContent])){
        [_addBtn setActive:NO];
        return;
    }
    [_addBtn setActive:YES];
}

-(void)onDefaultBtnClick{
    NSString *account = [_accoountView getContent];
    NSString *name = [_nameView getContent];
    [_mViewModel addAlipay:account name:name];
}

-(void)updateView{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_nameView resign];
    [_accoountView resign];
}

@end

