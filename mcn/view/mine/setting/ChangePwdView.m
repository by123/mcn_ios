//
//  ChangePwdView.m
//  cigarette
//
//  Created by xiao ming on 2019/12/16.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "ChangePwdView.h"
#import "PwdTextfieldView.h"
#import "ReactiveObjC.h"
#import "STWindowUtil.h"

@interface ChangePwdView()
@property(strong, nonatomic)ChangePwdViewModel *viewModel;
@property(strong, nonatomic)PwdTextfieldView *oldPwdView;
@property(strong, nonatomic)PwdTextfieldView *changeNewPwdView;
@property(strong, nonatomic)PwdTextfieldView *changeAgainPwdView;
@property(strong, nonatomic)XWButton *confirmButton;
@end

@implementation ChangePwdView

-(instancetype)initWithViewModel:(ChangePwdViewModel *)viewModel {
    if(self == [super init]){
        [self initView];
        [self bindModel:viewModel];
    }
    return self;
}

- (void)bindModel:(ChangePwdViewModel *)viewModel {
    _viewModel = viewModel;
    
    @weakify(self);
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] deliverOnMainThread] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        CGRect frame = [x.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [self.confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-frame.size.height - 30);
        }];
    } completed:^{
        
    }];
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] deliverOnMainThread] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self.confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-90);
        }];
    } completed:^{
        
    }];
    
    //绑定输入
    [[RACObserve(self.changeAgainPwdView, text) ignore:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.confirmButton setDisable:YES];
        if (self.oldPwdView.text.length > 0 && self.changeNewPwdView.text.length > 0 && self.changeAgainPwdView.text.length && [self.changeNewPwdView.text isEqualToString:self.changeAgainPwdView.text]) {
            [self.confirmButton setDisable:NO];
        }
    }];
    
    //绑定接口
    [[RACObserve(self.viewModel, isSuccess) ignore:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        BOOL result = [x boolValue];
        if (result) {
            [LCProgressHUD showSuccess:@"修改成功"];
            [[STWindowUtil currentController].navigationController popViewControllerAnimated:true];
        }
    }];
}

-(void)initView {
    _oldPwdView = [[PwdTextfieldView alloc]initWithTitle:@"当前密码" placehold:@"请输入当前密码"];
    [self addSubview:_oldPwdView];
    [_oldPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(STHeight(15));
        make.left.right.equalTo(self);
        make.height.equalTo(@STHeight(50));
    }];
    
    _changeNewPwdView = [[PwdTextfieldView alloc]initWithTitle:@"新密码" placehold:@"请输入新密码"];
    [self addSubview:_changeNewPwdView];
    [_changeNewPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oldPwdView.mas_bottom).offset(STHeight(15));
        make.left.right.equalTo(self);
        make.height.equalTo(_oldPwdView);
    }];
    
    _changeAgainPwdView = [[PwdTextfieldView alloc]initWithTitle:@"确认新密码" placehold:@"请再次输入新密码"];
    [self addSubview:_changeAgainPwdView];
    [_changeAgainPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_changeNewPwdView.mas_bottom).offset(STHeight(15));
        make.left.right.equalTo(self);
        make.height.equalTo(_changeNewPwdView);
    }];
    
    _confirmButton = [[XWButton alloc]initWithTitle:@"确认修改" type:XWButtonType_Positive];
    [_confirmButton setDisable:YES];
    [_confirmButton addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_confirmButton];
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(STHeight(-90));
        make.width.equalTo(@STWidth(315));
        make.height.equalTo(@STHeight(50));
    }];
}

-(void)updateView {
    
}

- (void)confirmBtnClick {
    [_viewModel requestChange:_oldPwdView.text newPwd:_changeAgainPwdView.text];
}

@end
