//
//  WithdrawView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "WithdrawView.h"

@interface WithdrawView()<UITextFieldDelegate>

@property(strong, nonatomic)WithdrawViewModel *mViewModel;
@property(strong, nonatomic)UIImageView *logoImageView;
@property(strong, nonatomic)UILabel *bankLabel;
@property(strong, nonatomic)UILabel *idLabel;
@property(strong, nonatomic)UILabel *canWithdrawLabel;
@property(strong, nonatomic)UITextField *moneyTF;
@property(strong, nonatomic)UIButton *withdrawBtn;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *tipsLabel;
@property(assign, nonatomic)CGFloat btnHeight;

@end

@implementation WithdrawView

-(instancetype)initWithViewModel:(WithdrawViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initBankView];
    [self initWithdrawView];
    UIImageView *tipsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(197), STHeight(16), STHeight(16))];
    tipsImageView.image = [UIImage imageNamed:IMAGE_TIPS];
    tipsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:tipsImageView];
    
    _tipsLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:YES];
    [self addSubview:_tipsLabel];
    
    _withdrawBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"提现" textColor:cwhite backgroundColor:c16_d corner:4 borderWidth:0 borderColor:nil];
    _withdrawBtn.frame = CGRectMake(STWidth(30), ContentHeight - STHeight(150), STWidth(315), STHeight(50));
    _withdrawBtn.enabled = NO;
    [_withdrawBtn addTarget:self action:@selector(onWithdrawBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_withdrawBtn];
}

-(void)initBankView{
    UIButton *bankView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(77))];
    bankView.backgroundColor = cwhite;
    [bankView addTarget:self action:@selector(onSelectBankClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bankView];
    
    _titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(16)] text:@"提现至" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(16) fontName:FONT_SEMIBOLD];
    _titleLabel.frame = CGRectMake(STWidth(15), STHeight(15), titleSize.width, STHeight(22));
    [bankView addSubview:_titleLabel];
    
    _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(95), STHeight(19), STHeight(14), STHeight(14))];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [bankView addSubview:_logoImageView];
    
    _bankLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(16)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [bankView addSubview:_bankLabel];
    
    _idLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [bankView addSubview:_idLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STHeight(17) - STWidth(15), STHeight(30), STHeight(17), STHeight(17))];
    arrowImageView.image = [UIImage imageNamed:IMAGE_ARROW_RIGHT_GREY];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [bankView addSubview:arrowImageView];
    
    [bankView addSubview:LINEVIEW(STHeight(77), STWidth(345))];
}

-(void)updateBankView{
    BankModel *model = _mViewModel.bankModel;
    NSString *bankName = model.bankName;
    NSString *logoImage = IMAGE_WITHDRAW_BANK;
    if(model.isPublic == BankType_Alipay_Public || model.isPublic == BankType_Alipay_Personal){
        bankName = @"支付宝";
        logoImage = IMAGE_WITHDRAW_ALIPAY;
    }
    if(!IS_NS_STRING_EMPTY(bankName) && !IS_NS_STRING_EMPTY(model.bankId)){
        _bankLabel.text = bankName;
        CGSize bankSize = [_bankLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(16) fontName:FONT_SEMIBOLD];
        _bankLabel.frame = CGRectMake(STWidth(115), STHeight(15), bankSize.width, STHeight(22));
        
        _idLabel.text = model.bankId;
        CGSize idSize = [_idLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
        _idLabel.frame = CGRectMake(STWidth(115), STHeight(38), idSize.width, STHeight(20));
        
        [_logoImageView setImage:[UIImage imageNamed:logoImage]];
        
        _logoImageView.hidden = NO;
        _idLabel.hidden = NO;
        _bankLabel.hidden = NO;
        _titleLabel.text = @"提现至";
        CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(16) fontName:FONT_SEMIBOLD];
        _titleLabel.frame = CGRectMake(STWidth(15), STHeight(15), titleSize.width, STHeight(22));
    }else{
        _logoImageView.hidden = YES;
        _idLabel.hidden = YES;
        _bankLabel.hidden = YES;
        _titleLabel.text = @"请选择提现方式";
        CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(16) fontName:FONT_SEMIBOLD];
        _titleLabel.frame = CGRectMake(STWidth(15), 0, titleSize.width, STHeight(77));
    }
}

-(void)initWithdrawView{
    UIView *withdrawView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(77), ScreenWidth, STHeight(106))];
    withdrawView.backgroundColor = cwhite;
    [self addSubview:withdrawView];
    
    _canWithdrawLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:@"可提现金额：0.00元" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [withdrawView addSubview:_canWithdrawLabel];
    
    UIButton *withdrawAllBtn = [[UIButton alloc]initWithFont:STFont(12) text:@"全部提现" textColor:c10 backgroundColor:nil corner:4 borderWidth:LineHeight borderColor:c10];
    withdrawAllBtn.frame = CGRectMake(STWidth(293), STHeight(29), STWidth(67), STHeight(30));
    [withdrawAllBtn addTarget:self action:@selector(onWithdrawAllBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [withdrawView addSubview:withdrawAllBtn];
    
    UILabel *unitLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(30)] text:@"¥" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize unitSize = [unitLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(30) fontName:FONT_SEMIBOLD];
    unitLabel.frame = CGRectMake(STWidth(15), STHeight(65), unitSize.width, STHeight(42));
    [withdrawView addSubview:unitLabel];
    
    _moneyTF = [[UITextField alloc]initWithFont:STFont(18) textColor:c10 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:STWidth(10)];
    [_moneyTF setPlaceholder:@"输入提现金额" color:c05 fontSize:STFont(14)];
    _moneyTF.frame = CGRectMake(STWidth(33), STHeight(71), ScreenWidth - STWidth(63), STHeight(35));
    _moneyTF.delegate = self;
    [_moneyTF addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    _moneyTF.keyboardType = UIKeyboardTypeDecimalPad;
    [withdrawView addSubview:_moneyTF];
    
    [withdrawView addSubview:LINEVIEW(STHeight(106), STWidth(345))];
    
}

-(void)onSelectBankClick{
    [_mViewModel goBankPage:YES];
}

-(void)onWithdrawAllBtnClick{
    _moneyTF.text = [NSString stringWithFormat:@"%.2f",_mViewModel.capitalModel.canWithdrawNum / 100];
    _withdrawBtn.backgroundColor = c16;
    _withdrawBtn.enabled = YES;
}

-(void)onWithdrawBtnClick{
    if([_moneyTF.text doubleValue] > 0){
        [_mViewModel doWithdraw:[_moneyTF.text doubleValue]];
    }else{
        [LCProgressHUD showMessage:@"提现金额必须大于0"];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    WS(weakSelf)
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.withdrawBtn.frame = CGRectMake(STWidth(30), weakSelf.btnHeight, STWidth(315), STHeight(50));
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    WS(weakSelf)
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.withdrawBtn.frame = CGRectMake(STWidth(30),ContentHeight - STHeight(150), STWidth(315), STHeight(50));
    }];
}

- (void)textDidChange:(UITextField*)textField {
     NSString *content = textField.text;
     if([content containsString:@"."]){
         NSArray *datas = [content componentsSeparatedByString:@"."];
         NSString *intValue = datas[0];
         NSString *pointValue = datas[1];
         if(pointValue.length > 2){
             pointValue = [pointValue substringWithRange:NSMakeRange(0, 2)];
         }
         textField.text = [NSString stringWithFormat:@"%@.%@",intValue,pointValue];
     }
    if(!IS_NS_STRING_EMPTY(textField.text)){
        double money = [textField.text doubleValue];
        _withdrawBtn.backgroundColor = c16;
        _withdrawBtn.enabled = YES;
        if(money > _mViewModel.capitalModel.canWithdrawNum / 100){
            [LCProgressHUD showMessage:@"提现金额不能超过最大可提现金额!"];
            textField.text = [NSString stringWithFormat:@"%.2f",_mViewModel.capitalModel.canWithdrawNum / 100];
        }
        if(money * 100 < _mViewModel.tipsModel.min){
            [LCProgressHUD showMessage:[NSString stringWithFormat:@"提现金额不得低于%.2f元",_mViewModel.tipsModel.min/100]];
            textField.text = [NSString stringWithFormat:@"%.2f",_mViewModel.tipsModel.min / 100];
        }
        if(money * 100 > _mViewModel.tipsModel.max){
            [LCProgressHUD showMessage:[NSString stringWithFormat:@"提现金额不得高于%.2f元",_mViewModel.tipsModel.max/100]];
        }
    }else{
        _withdrawBtn.backgroundColor = c16_d;
        _withdrawBtn.enabled = NO;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_moneyTF resignFirstResponder];
}

-(void)updateView{
    _canWithdrawLabel.text = [NSString stringWithFormat:@"可提现金额：%.2f元",_mViewModel.capitalModel.canWithdrawNum / 100];
    CGSize canWithdrawSize = [_canWithdrawLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _canWithdrawLabel.frame = CGRectMake(STWidth(15), STHeight(29), canWithdrawSize.width, STHeight(21));
}

-(void)updateTipsView{
    NSString *tipsStr = MSG_EMPTY;
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.tipsModel.bankHint)){
        for(NSString *str in _mViewModel.tipsModel.bankHint){
            tipsStr = [tipsStr stringByAppendingString:str];
            tipsStr = [tipsStr stringByAppendingString:@"\n"];
        }
    }
    tipsStr = [tipsStr stringByAppendingString:[NSString stringWithFormat:@"手续费：%.2f元",_mViewModel.tipsModel.fee / 100]];
    _tipsLabel.text = tipsStr;
    CGSize tipsSize = [_tipsLabel.text sizeWithMaxWidth:ScreenWidth - STWidth(51) font:STFont(12) fontName:FONT_REGULAR];
    _tipsLabel.frame = CGRectMake(STWidth(36), STHeight(196), ScreenWidth - STWidth(51), tipsSize.height);
    
    _btnHeight = STHeight(236) + tipsSize.height;
}
@end

