//
//  AddPublickBankView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AddPublickBankView.h"
#import "STBlankInView.h"
#import "STSelectInView.h"
#import "STBankLayerView.h"
#import "STWindowUtil.h"

@interface AddPublickBankView()<STSelectInViewDelegate,STBlankInViewDelegate,STBankLayerViewDelegte>

@property(strong, nonatomic)AddPublickBankViewModel *mViewModel;
@property(strong, nonatomic)STBlankInView *cardNumView;
@property(strong, nonatomic)STBlankInView *nameView;
@property(strong, nonatomic)STSelectInView *bankSelectView;
@property(strong, nonatomic)STBlankInView *branchView;
@property(strong, nonatomic)STBankLayerView *layerView;
@property(strong, nonatomic)XWBottomButton *saveBtn;

@end

@implementation AddPublickBankView

-(instancetype)initWithViewModel:(AddPublickBankViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    CGFloat top = STHeight(15);
    
    _nameView = [[STBlankInView alloc]initWithTitle:MSG_BANKINFO_ACCOUNT_NAME placeHolder:MSG_BANKINFO_ACCOUNT_NAME_HOLDER];
    _nameView.delegate = self;
    _nameView.frame = CGRectMake(0, top, ScreenWidth, BlankHeight);
    [self addSubview:_nameView];
    
    top += BlankHeight;
    _cardNumView = [[STBlankInView alloc]initWithTitle:MSG_BANKINFO_CARDNUM placeHolder:MSG_BANKINFO_CARDNUM_HOLDER];
    _cardNumView.delegate = self;
    [_cardNumView inputNumber];
    _cardNumView.frame = CGRectMake(0, top, ScreenWidth, BlankHeight);
    [self addSubview:_cardNumView];
    
    top += BlankHeight;
    _bankSelectView = [[STSelectInView alloc]initWithTitle:MSG_BANKINFO_BANK placeHolder:MSG_BANKINFO_BANK_HOLDER frame:CGRectMake(0, 0, ScreenWidth, BlankHeight)];
    _bankSelectView.delegate = self;
    _bankSelectView.frame = CGRectMake(0,  top, ScreenWidth, BlankHeight);
    [self addSubview:_bankSelectView];
    
    
    top += BlankHeight;
    _branchView = [[STBlankInView alloc]initWithTitle:MSG_BANKINFO_BRANCH_NAME placeHolder:MSG_BANKINFO_BRANCH_NAME_HOLDER];
    _branchView.delegate = self;
    [_branchView hiddenLine];
    _branchView.frame = CGRectMake(0, top, ScreenWidth, BlankHeight);
    [self addSubview:_branchView];
    
    
    _layerView = [[STBankLayerView alloc]init];
    _layerView.hidden = YES;
    _layerView.delegate = self;
    [STWindowUtil addWindowView:_layerView];
    
    _saveBtn = [[XWBottomButton alloc]initWithTitle:MSG_SAVE];
    _saveBtn.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
    [_saveBtn addTarget:self action:@selector(onDefaultBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_saveBtn];
}

-(void)onTextFieldDidChange:(id)view{
    [self checkSaveBtnStatu];
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


-(void)checkSaveBtnStatu{
    if(IS_NS_STRING_EMPTY([_cardNumView getContent]) ||
       IS_NS_STRING_EMPTY([_nameView getContent]) ||
       IS_NS_STRING_EMPTY([_branchView getContent]) ||
       IS_NS_STRING_EMPTY([_bankSelectView getContent])){
        [_saveBtn setDisable:YES];
    }else{
        [_saveBtn setDisable:NO];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resignAll];
}

-(void)resignAll{
    [_nameView resign];
    [_cardNumView resign];
    [_branchView resign];
}

-(void)updateView{
    [self checkSaveBtnStatu];
}

-(void)onDefaultBtnClick{
    _mViewModel.model.accountName = [_nameView getContent];
    _mViewModel.model.bankId = [_cardNumView getContent];
    _mViewModel.model.bankBranch = [_branchView getContent];

    [_mViewModel addBank];
}

@end

