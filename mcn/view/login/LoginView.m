//
//  LoginView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "LoginView.h"
#import "STUserDefaults.h"
#import "STConvertUtil.h"

@interface LoginView()<UITextFieldDelegate>

@property(strong, nonatomic)LoginViewModel *mViewModel;
@property(strong, nonatomic)UITextField *userNameTF;
@property(strong, nonatomic)UITextField *pswTF;
@property(strong, nonatomic)XWButton *loginBtn;
@property(strong, nonatomic)UIButton *forgetBtn;
@property(strong, nonatomic)UIButton *hideBtn;
@property(strong, nonatomic)UIButton *userNameClearBtn;
@property(strong, nonatomic)UIButton *pswClearBtn;
@property(strong, nonatomic)UIButton  *selectImageView;
@property(strong, nonatomic)UIButton *loginStyleBtn;
@property(strong, nonatomic)UIView *pswlineView;
@property(strong, nonatomic)UIView *userlineView;

@property(strong, nonatomic)UILabel *welcomeLabel;
@property(strong, nonatomic)UIView *contentView;
@property(strong, nonatomic)UILabel *tipsLabel;


@end

@implementation LoginView{
    Boolean isSelect;
    Boolean isMessageLogin;
}

-(instancetype)initWithViewModel:(LoginViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        isSelect = YES;
        [self initView];
        //监听当键将要弹出时
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        //监听当键将要退出时
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    return self;
}

//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification{
    WS(weakSelf)
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.welcomeLabel.text = MSG_LOGIN_WELCOME2;
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:weakSelf.welcomeLabel.text];
        NSRange range1= NSMakeRange(0, weakSelf.welcomeLabel.text.length - 1);
        [hintString addAttribute:NSForegroundColorAttributeName value:c10 range:range1];
        
        NSRange range2= NSMakeRange(weakSelf.welcomeLabel.text.length-1, 1);
        [hintString addAttribute:NSForegroundColorAttributeName value:c16 range:range2];
        weakSelf.welcomeLabel.attributedText=hintString;
        
        weakSelf.welcomeLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(20)];
        CGSize welcomeSize = [weakSelf.welcomeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(20) fontName:FONT_SEMIBOLD];
        weakSelf.welcomeLabel.frame = CGRectMake(STWidth(30), STHeight(54), welcomeSize.width, STHeight(42));
        weakSelf.contentView.frame = CGRectMake(0, STHeight(92), ScreenWidth, STHeight(500));
    }];
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification{
    WS(weakSelf)
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.welcomeLabel.text = MSG_LOGIN_WELCOME;
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:weakSelf.welcomeLabel.text];
        NSRange range1= NSMakeRange(0, weakSelf.welcomeLabel.text.length - 1);
        [hintString addAttribute:NSForegroundColorAttributeName value:c10 range:range1];
        
        NSRange range2= NSMakeRange(weakSelf.welcomeLabel.text.length-1, 1);
        [hintString addAttribute:NSForegroundColorAttributeName value:c16 range:range2];
        weakSelf.welcomeLabel.attributedText=hintString;
        weakSelf.welcomeLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(30)];
        CGSize welcomeSize = [weakSelf.welcomeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(30) fontName:FONT_SEMIBOLD];
        weakSelf.welcomeLabel.frame = CGRectMake(STWidth(30), STHeight(94), STWidth(300), welcomeSize.height);
        weakSelf.contentView.frame = CGRectMake(0, STHeight(228), ScreenWidth, STHeight(500));
    }];
}


-(void)initView{
    
    _welcomeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(30)] text:MSG_LOGIN_WELCOME textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    NSMutableAttributedString *wHintStr=[[NSMutableAttributedString alloc]initWithString:_welcomeLabel.text];
    NSRange wRange1= NSMakeRange(0, _welcomeLabel.text.length - 1);
    [wHintStr addAttribute:NSForegroundColorAttributeName value:c10 range:wRange1];
    
    NSRange wRang2= NSMakeRange(_welcomeLabel.text.length-1, 1);
    [wHintStr addAttribute:NSForegroundColorAttributeName value:c16 range:wRang2];
    _welcomeLabel.attributedText=wHintStr;
    
    CGSize welcomeSize = [MSG_LOGIN_WELCOME sizeWithMaxWidth:STWidth(300) font:STFont(30) fontName:FONT_SEMIBOLD];
    _welcomeLabel.frame = CGRectMake(STWidth(30), STHeight(94), STWidth(300), welcomeSize.height);
    [self addSubview:_welcomeLabel];
    
    
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(228), ScreenWidth, ScreenHeight - STHeight(176))];
    [self addSubview:_contentView];
    
    _userNameTF = [[UITextField alloc]initWithFont:STFont(16) textColor:c10 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    _userNameTF.frame = CGRectMake(STWidth(30), 0, ScreenWidth - STWidth(60),  STHeight(42));
    [_userNameTF setPlaceholder:@"输入登录账号/手机号" color:c03 fontSize:STFont(16)];
    _userNameTF.delegate = self;
    [_userNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_contentView addSubview:_userNameTF];
    
    _userNameClearBtn = [[UIButton alloc]init];
    _userNameClearBtn.frame = CGRectMake(ScreenWidth - STWidth(69) , 0, STWidth(42), STHeight(42));
    [_userNameClearBtn setImage:[STConvertUtil imageResize:[UIImage imageNamed:IMAGE_PSW_CLEAR] andResizeTo:CGSizeMake(STWidth(20), STWidth(20))] forState:UIControlStateNormal];
    _userNameClearBtn.hidden = YES;
    [_userNameClearBtn addTarget:self action:@selector(onUserNameClearBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_userNameClearBtn];
    
    NSString *userNameStr = [STUserDefaults getKeyValue:UD_USERNAME];
    if(!IS_NS_STRING_EMPTY(userNameStr)){
        _userNameTF.text = userNameStr;
    }
    
    
    _userlineView =[[UIView alloc]initWithFrame:CGRectMake(STWidth(30), STHeight(42) - LineHeight, ScreenWidth - STWidth(60), LineHeight)];
    _userlineView.backgroundColor = cline;
    [_contentView addSubview:_userlineView];
    
    _pswTF = [[UITextField alloc]initWithFont:STFont(16) textColor:c10 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    _pswTF.frame = CGRectMake(STWidth(30), STHeight(72), ScreenWidth - STWidth(60),  STHeight(42));
    _pswTF.secureTextEntry = YES;
    [_pswTF setPlaceholder:@"输入密码" color:c03 fontSize:STFont(16)];
    _pswTF.maxLength = @"20";
    _pswTF.delegate = self;
    [_pswTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_contentView addSubview:_pswTF];
    
    _pswlineView =[[UIView alloc]initWithFrame:CGRectMake(STWidth(30), STHeight(116) - LineHeight, ScreenWidth - STWidth(60), LineHeight)];
    _pswlineView.backgroundColor = cline;
    [_contentView addSubview:_pswlineView];
    
    _pswClearBtn = [[UIButton alloc]init];
    _pswClearBtn.frame = CGRectMake(ScreenWidth - STWidth(69) , STHeight(72), STWidth(42), STHeight(42));
    [_pswClearBtn setImage:[STConvertUtil imageResize:[UIImage imageNamed:IMAGE_PSW_CLEAR] andResizeTo:CGSizeMake(STWidth(20), STWidth(20))] forState:UIControlStateNormal];
    _pswClearBtn.hidden = YES;
    [_pswClearBtn addTarget:self action:@selector(onPswClearBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_pswClearBtn];
    
    
    _hideBtn = [[UIButton alloc]init];
    _hideBtn.frame = CGRectMake(ScreenWidth - STWidth(95) , STHeight(72), STWidth(42), STHeight(42));
    [_hideBtn setImage:[STConvertUtil imageResize:[UIImage imageNamed:IMAGE_PSW_VISIBLE] andResizeTo:CGSizeMake(STWidth(20), STWidth(20))] forState:UIControlStateNormal];
    _hideBtn.hidden = YES;
    [_hideBtn addTarget:self action:@selector(onHideBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_hideBtn];
    
    
    _loginBtn = [[XWButton alloc]initWithTitle:@"登录" type:XWButtonType_Positive];
    _loginBtn.frame = CGRectMake(STWidth(30), STHeight(194), ScreenWidth - STWidth(60),  STHeight(50));
    [_loginBtn addTarget:self action:@selector(onLoginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_loginBtn];
    
    _tipsLabel = [[UILabel alloc]initWithFont:STFont(12) text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c04 backgroundColor:nil multiLine:NO];
    _tipsLabel.frame = CGRectMake(STWidth(30), STHeight(118), ScreenWidth-STWidth(60), STHeight(30));
    [_contentView addSubview:_tipsLabel];
    
    
    _loginStyleBtn = [[UIButton alloc]initWithFont:STFont(15) text:@"使用短信验证码登录" textColor:c11 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    CGSize loginStyleSize = [_loginStyleBtn.titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15)];
    _loginStyleBtn.frame = CGRectMake(STWidth(30), STHeight(264), loginStyleSize.width, STHeight(21));
    [_loginStyleBtn addTarget:self action:@selector(onLoginStyleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_loginStyleBtn];
    
    _forgetBtn = [[UIButton alloc]initWithFont:STFont(15) text:@"忘记密码" textColor:c16 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    CGSize forgetSize = [_forgetBtn.titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15)];
    _forgetBtn.frame = CGRectMake(ScreenWidth - forgetSize.width - STWidth(30), STHeight(264), forgetSize.width,  STHeight(21));
    [_forgetBtn addTarget:self action:@selector(onForgetBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_forgetBtn];
    
    
    
    _selectImageView = [[UIButton alloc]init];
    [_selectImageView setSelected:isSelect];
    [_selectImageView setImage:[UIImage imageNamed:IMAGE_AGREE_NORMAL] forState:UIControlStateNormal];
    [_selectImageView setImage:[UIImage imageNamed:IMAGE_AGREE_PRESSED] forState:UIControlStateSelected];
    _selectImageView.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_selectImageView addTarget:self action:@selector(onSelectClicked) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_selectImageView];
    
    UIButton *agreeBtn = [[UIButton alloc]initWithFont:STFont(15) text:@"已同意《小红菇用户协议》" textColor:c11 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    CGSize agreeSize = [agreeBtn.titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15)];
    [agreeBtn addTarget:self action:@selector(onAgreeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:agreeBtn];
    
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:agreeBtn.titleLabel.text];
    NSRange range1=[[hintString string]rangeOfString:@"《小红菇用户协议》"];
    [hintString addAttribute:NSForegroundColorAttributeName value:c16 range:range1];
    agreeBtn.titleLabel.attributedText=hintString;
    
    _selectImageView.frame = CGRectMake((ScreenWidth - (STWidth(21) + agreeSize.width))/2,STHeight(2.5) +  STHeight(396) , STWidth(16), STWidth(16));
    agreeBtn.frame = CGRectMake((ScreenWidth - (STWidth(21) + agreeSize.width))/2 + STWidth(21), STHeight(396) , agreeSize.width, STHeight(21));
    
    
    [self changeLoginBtnStatu];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == _userNameTF){
        _userlineView.backgroundColor = c16;
        _pswlineView.backgroundColor = cline;
    }else if(textField == _pswTF){
        _userlineView.backgroundColor = cline;
        _pswlineView.backgroundColor = c16;
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_userNameTF resignFirstResponder];
    [_pswTF resignFirstResponder];
}



- (void)textFieldDidChange:(UITextField *)textField{
    if(textField == _pswTF){
        _pswClearBtn.hidden = IS_NS_STRING_EMPTY(textField.text);
        _hideBtn.hidden = IS_NS_STRING_EMPTY(textField.text) ? YES : NO;
    }else  if(textField == _userNameTF){
        _userNameClearBtn.hidden = IS_NS_STRING_EMPTY(textField.text);
    }
    _tipsLabel.text = MSG_EMPTY;
    
    [self changeLoginBtnStatu];
}

-(void)changeLoginBtnStatu{
    _tipsLabel.text = MSG_EMPTY;
    if(isMessageLogin){
        if(!IS_NS_STRING_EMPTY(_userNameTF.text)){
            [_loginBtn setDisable:NO];
        }else{
            [_loginBtn setDisable:YES];
        }
    }else{
        if(!IS_NS_STRING_EMPTY(_userNameTF.text) && !IS_NS_STRING_EMPTY(_pswTF.text) && isSelect && _pswTF.text.length >= 6){
            [_loginBtn setDisable:NO];
        }else{
            [_loginBtn setDisable:YES];
        }
    }
}


-(void)onLoginBtnClicked{
    if(_mViewModel){
        if(isMessageLogin && _userNameTF.text.length != 11){
            [LCProgressHUD showMessage:@"请输入正确的手机号"];
            return;
        }
        [_mViewModel doLogin:_userNameTF.text psw:_pswTF.text isMessgeLogin:isMessageLogin];
    }
    
}

-(void)onForgetBtnClicked{
    if(_mViewModel){
        [_mViewModel goForgetPswPage];
    }
}

-(void)onLoginStyleBtnClick{
    isMessageLogin = !isMessageLogin;
    
    [_loginStyleBtn setTitle:isMessageLogin ? @"使用账号密码登录" : @"使用短信验证码登录" forState:UIControlStateNormal];
    CGSize loginStyleSize = [_loginStyleBtn.titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15)];
    _loginStyleBtn.frame = CGRectMake(STWidth(30), STHeight(264), loginStyleSize.width, STHeight(21));
    
    _pswTF.hidden = isMessageLogin;
    _pswClearBtn.hidden = isMessageLogin;
    _hideBtn.hidden = isMessageLogin;
    _pswlineView.hidden = isMessageLogin;
    
    [_loginBtn setTitle:isMessageLogin ? @"下一步":@"登录" forState:UIControlStateNormal];
    [self changeLoginBtnStatu];
    
}

-(void)onUserNameClearBtnClicked{
    _userNameTF.text = MSG_EMPTY;
    _userNameClearBtn.hidden = YES;
}

-(void)onPswClearBtnClicked{
    _pswTF.text = MSG_EMPTY;
    _pswClearBtn.hidden = YES;
    _hideBtn.hidden = YES;
}

-(void)onHideBtnClicked{
    if(_pswTF.secureTextEntry){
        _pswTF.secureTextEntry = NO;
        [_hideBtn setImage:[STConvertUtil imageResize:[UIImage imageNamed:IMAGE_PSW_HIDDEN] andResizeTo:CGSizeMake(STWidth(18), STWidth(18))] forState:UIControlStateNormal];
        
    }else{
        _pswTF.secureTextEntry = YES;
        [_hideBtn setImage:[STConvertUtil imageResize:[UIImage imageNamed:IMAGE_PSW_VISIBLE] andResizeTo:CGSizeMake(STWidth(18), STWidth(18))] forState:UIControlStateNormal];
    }
}

-(void)onSelectClicked{
    isSelect = !isSelect;
    [self changeLoginBtnStatu];
    [_selectImageView setSelected:isSelect];
}

-(void)onAgreeBtnClicked{
    if(_mViewModel){
        [_mViewModel goAgreementPage];
    }
}

-(void)updateTips:(NSString *)tips{
    _tipsLabel.text = tips;
}


@end

