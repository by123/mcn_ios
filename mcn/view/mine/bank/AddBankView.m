//
//  AddBankView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AddBankView.h"
#import "STBlankInView.h"
#import "STSelectInView.h"
#import "STSinglePickerLayerView.h"
#import "STBankLayerView.h"

@interface AddBankView()<STSelectInViewDelegate,STSinglePickerLayerViewDelegate,STBlankInViewDelegate,STBankLayerViewDelegte>

@property(strong, nonatomic)AddBankViewModel *mViewModel;
@property(strong, nonatomic)STBlankInView *cardNumView;
@property(strong, nonatomic)STBlankInView *nameView;
@property(strong, nonatomic)STSelectInView *bankSelectView;
@property(strong, nonatomic)STBlankInView *idView;
@property(strong, nonatomic)STBankLayerView *layerView;
@property(strong, nonatomic)XWBottomButton *saveBtn;

@end

@implementation AddBankView

-(instancetype)initWithViewModel:(AddBankViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UIView *tipsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(50))];
    tipsView.backgroundColor = c23;
    [self addSubview:tipsView];
    
    UIImageView *tipsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), (STHeight(50) - STWidth(14))/2, STWidth(14), STWidth(14))];
    tipsImageView.image = [UIImage imageNamed:IMAGE_TIPS];
    tipsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [tipsView addSubview:tipsImageView];
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_BANKINFO_TIPS textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize tipsSize = [tipsLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    tipsLabel.frame = CGRectMake(STWidth(34), 0, tipsSize.width, STHeight(50));
    [tipsView addSubview:tipsLabel];
    
    CGFloat top = STHeight(50);
    
    _bankSelectView = [[STSelectInView alloc]initWithTitle:MSG_BANKINFO_BANK placeHolder:MSG_BANKINFO_BANK_HOLDER frame:CGRectMake(0, 0, ScreenWidth, BlankHeight)];
    _bankSelectView.delegate = self;
    _bankSelectView.frame = CGRectMake(0,  top, ScreenWidth, BlankHeight);
    [self addSubview:_bankSelectView];
    
    top += BlankHeight;
    _cardNumView = [[STBlankInView alloc]initWithTitle:MSG_BANKINFO_CARDNUM placeHolder:MSG_BANKINFO_CARDNUM_HOLDER];
    _cardNumView.delegate = self;
    [_cardNumView inputNumber];
    _cardNumView.frame = CGRectMake(0, top, ScreenWidth, BlankHeight);
    [self addSubview:_cardNumView];
    
    top += BlankHeight;
    _nameView = [[STBlankInView alloc]initWithTitle:MSG_BANKINFO_NAME placeHolder:MSG_BANKINFO_NAME_HOLDER];
    _nameView.delegate = self;
    _nameView.frame = CGRectMake(0, top, ScreenWidth, BlankHeight);
    [self addSubview:_nameView];
    
    top += BlankHeight;
    _idView = [[STBlankInView alloc]initWithTitle:MSG_BANKINFO_ID placeHolder:MSG_BANKINFO_ID_HOLDER];
    _idView.delegate = self;
    [_idView hiddenLine];
    [_idView setMaxLength:18];
    _idView.frame = CGRectMake(0, top, ScreenWidth, BlankHeight);
    [self addSubview:_idView];
    
    
    _layerView = [[STBankLayerView alloc]init];
    _layerView.hidden = YES;
    _layerView.delegate = self;
    [STWindowUtil addWindowView:_layerView];
    
    _saveBtn = [[XWBottomButton alloc]initWithTitle:MSG_SAVE];
    _saveBtn.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
    [_saveBtn addTarget:self action:@selector(onDefaultBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_saveBtn];
    
}

-(void)onSelectClicked:(id)selectInView{
    [self resignAll];
    _layerView.hidden = NO;
}

-(void)onBankSelectResult:(BankSelectModel *)data layerView:(UIView *)layerView position:(NSInteger)position{
    if(layerView == _layerView){
        _mViewModel.model.bankName = data.bank_name;
        _mViewModel.model.bankCode = data.bank_code;
        [_bankSelectView setContent:data.bank_name];
    }
    [self checkSaveBtnStatu];
}

-(void)onTextFieldDidChange:(id)view{
    [self checkSaveBtnStatu];
}

-(void)checkSaveBtnStatu{
    if(IS_NS_STRING_EMPTY([_cardNumView getContent]) ||
       IS_NS_STRING_EMPTY([_nameView getContent]) ||
       IS_NS_STRING_EMPTY([_idView getContent]) ||
       IS_NS_STRING_EMPTY([_bankSelectView getContent])){
        [_saveBtn setDisable:YES];
    }else{
        [_saveBtn setDisable:NO];
    }
}

-(void)onDefaultBtnClick{
    if([_idView getContent].length != 18){
        [LCProgressHUD showMessage:@"请检查身份证号位数！"];
        return;
    }
    _mViewModel.model.accountName = [_nameView getContent];
    _mViewModel.model.bankId = [_cardNumView getContent];
    _mViewModel.model.creid = [_idView getContent];

    [_mViewModel addBank];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resignAll];
}

-(void)resignAll{
    [_nameView resign];
    [_cardNumView resign];
    [_idView resign];
}

-(void)updateView{
    [self checkSaveBtnStatu];
}

@end

