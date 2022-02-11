//
//  UpdatePhoneView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "UpdatePhoneView.h"
#import "STBlankInView.h"
#import "STDefaultBtnView.h"

@interface UpdatePhoneView()<STDefaultBtnViewDelegate,STBlankInViewDelegate>

@property(strong, nonatomic)UpdatePhoneViewModel *mViewModel;
@property(strong, nonatomic)UIButton *verifyBtn;
@property(strong, nonatomic)UITextField *verifyTF;
@property(strong, nonatomic)STBlankInView *phoneView;
@property(strong, nonatomic)STDefaultBtnView *confirmBtn;

@end

@implementation UpdatePhoneView{
    int seconds;
}

-(instancetype)initWithViewModel:(UpdatePhoneViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        seconds = 10;
        [self initView];
    }
    return self;
}

-(void)initView{
    _phoneView = [[STBlankInView alloc]initWithTitle:@"新手机号码" placeHolder:@"请输入新手机号码"];
    _phoneView.frame = CGRectMake(0, STHeight(15), ScreenWidth, STHeight(60));
    _phoneView.delegate = self;
    [_phoneView setMaxLength:11];
    [_phoneView inputNumber];
    [_phoneView hiddenLine];
    [self addSubview:_phoneView];
    
    _verifyTF = [[UITextField alloc]initWithFont:STFont(15) textColor:c10 backgroundColor:cwhite corner:0 borderWidth:0 borderColor:nil padding:STWidth(15)];
    _verifyTF.frame = CGRectMake(0, STHeight(90), ScreenWidth, STHeight(60));
    [_verifyTF setMaxLength:@"10"];
    [_verifyTF setPlaceholder:@"请输入短信验证码" color:c11 fontSize:STFont(15)];
    _verifyTF.keyboardType = UIKeyboardTypeNumberPad;
    [_verifyTF addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_verifyTF];
    
    _verifyBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"获取验证码" textColor:cwhite backgroundColor:c16 corner:4 borderWidth:0 borderColor:nil];
    [self reFrameButton];
    [_verifyBtn addTarget:self action:@selector(onSendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_verifyBtn];
    
    _confirmBtn = [[STDefaultBtnView alloc]initWithTitle:@"完成"];
    _confirmBtn.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
    _confirmBtn.delegate = self;
    [_confirmBtn setActive:NO];
    [self addSubview:_confirmBtn];
    
}

-(void)onTextFieldDidChange:(id)view{
    _mViewModel.phoneNum = [_phoneView getContent];
    [self checkButton];
}

- (void)textDidChange:(UITextField*)textField {
    [self checkButton];
}

-(void)onDefaultBtnClick{
    [_mViewModel updatePhone:_verifyTF.text];
}

-(void)onSendBtnClick{
    [_mViewModel updateSendVerifyCode];
    seconds = 60;
    [self startCount];
}

-(void)startCount{
    if(seconds == 0){
        _verifyBtn.enabled = YES;
        [_verifyBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:cwhite forState:UIControlStateNormal];
        [self reFrameButton];
        
    }else{
        _verifyBtn.enabled = NO;
        seconds --;
        [_verifyBtn setTitle:[NSString stringWithFormat:@"%ds",seconds] forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:cwhite forState:UIControlStateNormal];
        [self reFrameButton];
        [self performSelector:@selector(startCount) withObject:nil afterDelay:1.0f];
        
    }
}

-(void)reFrameButton{
    CGSize verifySize = [_verifyBtn.titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14)];
    _verifyBtn.frame = CGRectMake(ScreenWidth -  STWidth(45) - verifySize.width, STHeight(105),verifySize.width + STWidth(30), STHeight(30));
}

-(void)checkButton{
    if([_phoneView getContent].length == 11 && _verifyTF.text.length > 0){
        [_confirmBtn setActive:YES];
    }else{
        [_confirmBtn setActive:NO];
    }
}

-(void)updateView{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneView resign];
    [_verifyTF resignFirstResponder];
}

@end

