//
//  CapitalMerchantView.m
//  mcn
//
//  Created by by.huang on 2020/9/8.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "CapitalMerchantView.h"

@interface CapitalMerchantView()

@property(strong, nonatomic)UILabel *balanceLabel;
@property(strong, nonatomic)UILabel *canWithdrawLabel;
@property(strong, nonatomic)UILabel *freezeLabel;

@property(strong, nonatomic)UILabel *totalLabel;
@property(strong, nonatomic)UILabel *incomeLabel;

@property(strong, nonatomic)UILabel *parterTotalLabel;
@property(strong, nonatomic)UILabel *parterIncomeLabel;

@property(strong, nonatomic)UILabel *natureTotalLabel;
@property(strong, nonatomic)UILabel *natureIncomeLabel;

@end

@implementation CapitalMerchantView

-(instancetype)init{
    if(self == [super init]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, STHeight(310));
    
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(310))];
    bgImageView.image = [UIImage imageNamed:IMAGE_CAPITAL_MCH_BG];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgImageView];
    
    UILabel *balanceTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:@"账户余额（元）" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    CGSize balanceTitleSize = [balanceTitleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    balanceTitleLabel.frame = CGRectMake(STWidth(35), STHeight(30), balanceTitleSize.width, STHeight(20));
    [self addSubview:balanceTitleLabel];
    
    _balanceLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(30)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_balanceLabel];
    
    _canWithdrawLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_canWithdrawLabel];
    
    _freezeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_freezeLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(35), STHeight(135), STWidth(305), 1)];
    lineView.backgroundColor = c16;
    [self addSubview:lineView];
    
    UIButton *withdrawBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"提现" textColor:c04 backgroundColor:cwhite corner:4 borderWidth:0 borderColor:nil];
    withdrawBtn.frame = CGRectMake(STWidth(271), STHeight(30), STWidth(70), STHeight(33));
    [withdrawBtn addTarget:self action:@selector(onWithdrawBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:withdrawBtn];
    
    NSArray *titles = @[@"销售总额(元)",@"合作(元)",@"自然(元)",@"总收入(元)",@"合作(元)",@"自然(元)"];
    for(int i = 0 ; i < titles.count ; i ++){
        CGFloat width = STWidth(35);
        if(i % 3 == 1){
            width = STWidth(162);
        }else if(i % 3 == 2){
            width = STWidth(260);
        }
        UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:titles[i] textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
        CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
        titleLabel.frame = CGRectMake(width ,STHeight(145) + (i/3) * STHeight(51), titleSize.width, STHeight(20));
        [self addSubview:titleLabel];
    }
    
    for(int i = 0 ;i < 2 ; i ++){
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(130), STHeight(160) + STHeight(53) * i, 1, STHeight(15))];
        lineView.backgroundColor = c16;
        [self addSubview:lineView];
    }
    
    _totalLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_totalLabel];
    
    _incomeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_incomeLabel];
    
    _parterTotalLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_parterTotalLabel];
    
    _parterIncomeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_parterIncomeLabel];
    
    _natureTotalLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_natureTotalLabel];
    
    _natureIncomeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_natureIncomeLabel];
    
    UIButton *sellStatisticsBtn = [[UIButton alloc]init];
    sellStatisticsBtn.frame = CGRectMake(STWidth(15), STHeight(129), STWidth(345), STHeight(61));
    sellStatisticsBtn.tag = StaticticsType_Sell;
    [sellStatisticsBtn addTarget:self action:@selector(onStatisticsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sellStatisticsBtn];
    
    UIButton *incomeStatisticsBtn = [[UIButton alloc]init];
    incomeStatisticsBtn.frame = CGRectMake(STWidth(15), STHeight(190), STWidth(345), STHeight(61));
    incomeStatisticsBtn.tag = StaticticsType_Income;
    [incomeStatisticsBtn addTarget:self action:@selector(onStatisticsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:incomeStatisticsBtn];
}

-(void)updateView:(CapitalModel *)model{
    _balanceLabel.text = [NSString stringWithFormat:@"%.2f",model.actualCanWithdrawNum / 100];
    CGSize balanceSize = [_balanceLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(30) fontName:FONT_SEMIBOLD];
    _balanceLabel.frame = CGRectMake(STWidth(35), STHeight(55), balanceSize.width, STHeight(35));
    
    _canWithdrawLabel.text = [NSString stringWithFormat:@"可提现：%.2f",model.canWithdrawNum / 100];
    CGSize canWithdrawSize = [_canWithdrawLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    _canWithdrawLabel.frame = CGRectMake(STWidth(35), STHeight(95), canWithdrawSize.width, STHeight(20));
    
    _freezeLabel.text = [NSString stringWithFormat:@"冻结：%.2f",model.freezeMoney / 100];
    CGSize freezeSize = [_canWithdrawLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    _freezeLabel.frame = CGRectMake(STWidth(55) + canWithdrawSize.width, STHeight(95), freezeSize.width, STHeight(20));
    
    _totalLabel.text = [NSString stringWithFormat:@"%.2f",model.totalSell / 100];
    CGSize totalSize = [_totalLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _totalLabel.frame = CGRectMake(STWidth(35), STHeight(165), totalSize.width, STHeight(21));
    
    _incomeLabel.text = [NSString stringWithFormat:@"%.2f",model.totalIncome / 100];
    CGSize incomeSize = [_incomeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _incomeLabel.frame = CGRectMake(STWidth(35), STHeight(216), incomeSize.width, STHeight(21));
    
    _parterTotalLabel.text = [NSString stringWithFormat:@"%.2f",model.cooperationSell / 100];
    CGSize partnerTotalSize = [_parterTotalLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _parterTotalLabel.frame = CGRectMake(STWidth(162), STHeight(165), partnerTotalSize.width, STHeight(21));
    
    _parterIncomeLabel.text = [NSString stringWithFormat:@"%.2f",model.cooperationIncome / 100];
    CGSize parterIncomeSize = [_parterIncomeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _parterIncomeLabel.frame = CGRectMake(STWidth(162), STHeight(216), parterIncomeSize.width, STHeight(21));
    
    
    _natureTotalLabel.text = [NSString stringWithFormat:@"%.2f",model.natureSell / 100];
    CGSize natureTotalSize = [_natureTotalLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _natureTotalLabel.frame = CGRectMake(STWidth(260), STHeight(165), natureTotalSize.width, STHeight(21));
    
    _natureIncomeLabel.text = [NSString stringWithFormat:@"%.2f",model.natureIncome / 100];
    CGSize natureIncomeSize = [_natureIncomeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _natureIncomeLabel.frame = CGRectMake(STWidth(260), STHeight(216), natureIncomeSize.width, STHeight(21));
    
}

-(void)onWithdrawBtnClick{
    if(_delegate){
        [_delegate onCapitalMerchantViewWithdrawBtnClick];
    }
}

-(void)onStatisticsBtnClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    if(_delegate){
        [_delegate onCapitalMerchantViewStatisticsBtnClick:button.tag];
    }
}
@end

