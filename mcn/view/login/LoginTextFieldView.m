//
//  LoginTextFieldView.m
//  cigarette
//
//  Created by by.huang on 2020/3/6.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "LoginTextFieldView.h"

@interface LoginTextFieldView()

@property(copy, nonatomic)NSString *titleStr;
@property(copy, nonatomic)NSString *placeHolderStr;
@property(strong, nonatomic)UIButton *hideBtn;

@end

@implementation LoginTextFieldView


-(instancetype)initWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder{
    if(self == [super init]){
        _titleStr = title;
        _placeHolderStr = placeHolder;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, STHeight(62));
    self.backgroundColor = cwhite;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:_titleStr textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    titleLabel.frame = CGRectMake(STWidth(15), 0, titleSize.width, STHeight(62));
    [self addSubview:titleLabel];
    
    _textField = [[UITextField alloc]initWithFont:STFont(15) textColor:c10 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    _textField.secureTextEntry = YES;
    _textField.textAlignment = NSTextAlignmentRight;
    [_textField setPlaceholder:_placeHolderStr color:c03 fontSize:STFont(15)];
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _textField.frame = CGRectMake(ScreenWidth - STWidth(279), 0, STWidth(200), STHeight(62));
    [self addSubview:_textField];
    
    _pswClearBtn = [[UIButton alloc]init];
    _pswClearBtn.frame = CGRectMake(ScreenWidth - STWidth(31) , STHeight(10), STWidth(16), STHeight(42));
    [_pswClearBtn setImage:[STConvertUtil imageResize:[UIImage imageNamed:IMAGE_PSW_CLEAR] andResizeTo:CGSizeMake(STWidth(16), STWidth(16))] forState:UIControlStateNormal];
    [_pswClearBtn addTarget:self action:@selector(onPswClearBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_pswClearBtn];
    
    
    _hideBtn = [[UIButton alloc]init];
    _hideBtn.frame = CGRectMake(ScreenWidth - STWidth(64) , STHeight(10), STWidth(18), STHeight(42));
    [_hideBtn setImage:[STConvertUtil imageResize:[UIImage imageNamed:IMAGE_PSW_VISIBLE] andResizeTo:CGSizeMake(STWidth(18), STWidth(18))] forState:UIControlStateNormal];
    [_hideBtn addTarget:self action:@selector(onHideBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_hideBtn];
    
}


- (void)textFieldDidChange:(UITextField *)textField{
    if(_delegate){
        [_delegate onTextFieldDidChange:textField];
    }
}

-(void)onPswClearBtnClicked{
    _textField.text = MSG_EMPTY;
    if(_delegate){
        [_delegate onClearBtnClick:_pswClearBtn];
    }
}

-(void)onHideBtnClicked{
    if(_textField.secureTextEntry){
        _textField.secureTextEntry = NO;
        [_hideBtn setImage:[STConvertUtil imageResize:[UIImage imageNamed:IMAGE_PSW_HIDDEN] andResizeTo:CGSizeMake(STWidth(18), STWidth(18))] forState:UIControlStateNormal];
    }else{
        _textField.secureTextEntry = YES;
        [_hideBtn setImage:[STConvertUtil imageResize:[UIImage imageNamed:IMAGE_PSW_VISIBLE] andResizeTo:CGSizeMake(STWidth(18), STWidth(18))] forState:UIControlStateNormal];
    }
}


@end
