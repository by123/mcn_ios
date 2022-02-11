//
//  VerifyCodeView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "VerifyCodeView.h"

@interface VerifyCodeView()<UITextFieldDelegate>

@property(strong, nonatomic)VerifyCodeViewModel *mViewModel;
@property(strong, nonatomic)UILabel *phoneLabel;
@property(strong, nonatomic)NSMutableArray *textFieldViews;
@property(strong, nonatomic)NSMutableArray *lineViews;
@property(strong, nonatomic)UIButton *verifyBtn;
@property(copy, nonatomic)NSString *verifyCode;

@end

@implementation VerifyCodeView{
    int seconds;
}

-(instancetype)initWithViewModel:(VerifyCodeViewModel *)viewModel{
    if(self == [super init]){
        seconds = 60;
        _mViewModel = viewModel;
        _textFieldViews = [[NSMutableArray alloc]init];
        _lineViews = [[NSMutableArray alloc]init];
        [self initView];
    }
    return self;
}

-(void)initView{
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(30)] text:@"输入短信验证码" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(30) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(30), STHeight(94), titleSize.width, STHeight(42));
    [self addSubview:titleLabel];
    
    _phoneLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:[NSString stringWithFormat:@"验证码已发送至%@",_mViewModel.phoneNum] textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    CGSize phoneSize = [_phoneLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    _phoneLabel.frame = CGRectMake(STWidth(30), STHeight(144), phoneSize.width, STHeight(20));
    [self addSubview:_phoneLabel];
    
    
    CGFloat width = (ScreenWidth - STWidth(56) - STWidth(50))/6;
    for(int i =0 ; i < 6 ; i ++){
        UITextField *textField = [[UITextField alloc]initWithFont:STFont(20) textColor:c10 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
        textField.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(20)];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.maxLength = @"1";
        textField.tag = i;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        textField.frame = CGRectMake(STWidth(28) + (width + STWidth(10)) * i, STHeight(228), width, STHeight(44));
        [self addSubview:textField];
        [_textFieldViews addObject:textField];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(28) + (width + STWidth(10)) * i, STHeight(264), width, LineHeight)];
        lineView.backgroundColor = cline;
        [self addSubview:lineView];
        [_lineViews addObject:lineView];
        
        if(i == 0){
            [textField becomeFirstResponder];
            lineView.backgroundColor = c16;
        }
    }
    
    _verifyBtn = [[UIButton alloc]initWithFont:STFont(16) text:[NSString stringWithFormat:@"%ds",seconds] textColor:c11 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    [self reFrameButton];
    _verifyBtn.enabled = NO;
    [_verifyBtn addTarget:self action:@selector(onVerifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_verifyBtn];
    
    [self startCount];
    
}

-(void)startCount{
    if(seconds == 0){
        _verifyBtn.enabled = YES;
        [_verifyBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:c16 forState:UIControlStateNormal];
        [self reFrameButton];
        
    }else{
        _verifyBtn.enabled = NO;
        seconds --;
        [_verifyBtn setTitle:[NSString stringWithFormat:@"%ds",seconds] forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:c11 forState:UIControlStateNormal];
        [self reFrameButton];
        [self performSelector:@selector(startCount) withObject:nil afterDelay:1.0f];
        
    }
}

-(void)reFrameButton{
    CGSize verifySize = [_verifyBtn.titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(16)];
    _verifyBtn.frame = CGRectMake(ScreenWidth -  STWidth(28) - verifySize.width, STHeight(275),verifySize.width , STHeight(22));
}


- (void)textFieldDidChange:(UITextField *)textField{
    if(textField.text.length == 0){
        UIView *lineView =  _lineViews[textField.tag];
        lineView.backgroundColor = cline;
        if(textField.tag > 0){
            UITextField *lastTF = _textFieldViews[textField.tag - 1];
            [lastTF becomeFirstResponder];
        }
    }else{
        UIView *lineView =  _lineViews[textField.tag];
        lineView.backgroundColor = c16;
        if(textField.tag + 1 < _textFieldViews.count){
            UITextField *nextTF = _textFieldViews[textField.tag + 1];
            if(IS_NS_STRING_EMPTY(nextTF.text)){
                nextTF.text = @" ";
            }
            [nextTF becomeFirstResponder];
        }
    }
    [self checkBlankIn];
}

-(void)onVerifyBtnClick{
    seconds = 60;
    [self startCount];
}

-(void)checkBlankIn{
    _verifyCode = MSG_EMPTY;
    for(UITextField *textField in _textFieldViews){
        if(IS_NS_STRING_EMPTY(textField.text) || [textField.text isEqualToString:@" "]){
            [STLog print:@"验证码无效"];
            return;
        }else{
            _verifyCode = [_verifyCode stringByAppendingString:textField.text];
        }
    }
    [STLog print:@"验证码" content:_verifyCode];
    if(_mViewModel.updatePhone){
        [_mViewModel updateVerifyCode:_verifyCode];
    }else{
        [_mViewModel verifyCode:_verifyCode];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for(UITextField *textField in _textFieldViews){
        [textField resignFirstResponder];
    }
}

@end

