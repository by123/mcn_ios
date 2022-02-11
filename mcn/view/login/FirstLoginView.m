//
//  FirstLoginView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "FirstLoginView.h"
#import "LoginTextFieldView.h"
#import "STImageTipsView.h"

@interface FirstLoginView()<LoginTextFieldViewDelegate>

@property(strong, nonatomic)FirstLoginViewModel *mViewModel;
@property(strong, nonatomic)LoginTextFieldView *pswTF;
@property(strong, nonatomic)LoginTextFieldView *rePswTF;
@property(strong, nonatomic)XWButton *saveBtn;

@end

@implementation FirstLoginView{
    NSString *pswStr;
    NSString *rePswStr;
    
}

-(instancetype)initWithViewModel:(FirstLoginViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(20)] text:@"新用户首次登录\n需要修改密码" textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:STWidth(143) font:STFont(20) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(20), STWidth(143), titleSize.height);
    [self addSubview:titleLabel];
    
    
    _pswTF = [[LoginTextFieldView alloc]initWithTitle:@"新密码" placeHolder:@"请输入新密码"];
    _pswTF.delegate = self;
    _pswTF.frame = CGRectMake(0, STHeight(96), ScreenWidth, STHeight(62));
    [self addSubview:_pswTF];
    
    _rePswTF = [[LoginTextFieldView alloc]initWithTitle:@"确认新密码" placeHolder:@"请再次输入新密码"];
    _rePswTF.delegate = self;
    _rePswTF.frame = CGRectMake(0, STHeight(158), ScreenWidth, STHeight(62));
    [self addSubview:_rePswTF];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(152) - LineHeight, STWidth(345), LineHeight)];
    lineView.backgroundColor = cline;
    [self addSubview:lineView];
    
    _saveBtn = [[XWButton alloc]initWithTitle:MSG_SAVE type:XWButtonType_Positive];
    [_saveBtn setDisable:YES];
    _saveBtn.frame = CGRectMake(STWidth(30), ContentHeight - STHeight(150), STWidth(315), STHeight(50));
    [_saveBtn addTarget:self action:@selector(onSaveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_saveBtn];
    
    STImageTipsView *tipsView = [[STImageTipsView alloc]initWithTitle:@"密码不能少于6位" top:NO];
    tipsView.frame = CGRectMake(0, STHeight(232), ScreenWidth, STHeight(50));
    [self addSubview:tipsView];
}

-(void)updateView{
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_pswTF.textField resignFirstResponder];
    [_rePswTF.textField resignFirstResponder];
}

-(void)onClearBtnClick:(UIButton *)pswClearBtn{
    if(pswClearBtn == _pswTF.pswClearBtn){
        pswStr = MSG_EMPTY;
    }else if(pswClearBtn == _rePswTF.pswClearBtn){
        rePswStr = MSG_EMPTY;
    }
    [self changeBtnStatu];
}

-(void)onTextFieldDidChange:(UITextField *)textField{
     if(textField == _pswTF.textField){
        pswStr = textField.text;
    }else if(textField == _rePswTF.textField){
        rePswStr = textField.text;
    }
    [self changeBtnStatu];
}

-(void)changeBtnStatu{
    if(!IS_NS_STRING_EMPTY(pswStr) && !IS_NS_STRING_EMPTY(rePswStr)){
        [_saveBtn setDisable:NO];
    }else{
        [_saveBtn setDisable:YES];
    }
}

-(void)onSaveBtnClick{
    if(pswStr.length < 6 || rePswStr.length < 6){
        [LCProgressHUD showMessage:@"密码不能少于6位"];
        return;
    }
    if(![pswStr isEqualToString:rePswStr]){
        [LCProgressHUD showMessage:@"新密码与确认密码不同"];
        return;
    }
    [_mViewModel requestChange:pswStr];
}

@end

