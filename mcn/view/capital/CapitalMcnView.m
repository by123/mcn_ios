//
//  CapitalMcnView.m
//  mcn
//
//  Created by by.huang on 2020/9/8.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "CapitalMcnView.h"
#import "AccountManager.h"

@interface CapitalMcnView()

@property(strong, nonatomic)UILabel *balanceLabel;
@property(strong, nonatomic)UILabel *canWithdrawLabel;
@property(strong, nonatomic)UILabel *freezeLabel;
@property(strong, nonatomic)UILabel *totalLabel;
@property(strong, nonatomic)UILabel *incomeLabel;

@end

@implementation CapitalMcnView

-(instancetype)init{
    if(self == [super init]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, STHeight(260));
    
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(260))];
    bgImageView.image = [UIImage imageNamed:IMAGE_CAPITAL_BG];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgImageView];
    
    UILabel *balanceTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:@"账户余额（元）" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    CGSize balanceTitleSize = [balanceTitleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    balanceTitleLabel.frame = CGRectMake(STWidth(35), STHeight(35), balanceTitleSize.width, STHeight(20));
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
    withdrawBtn.frame = CGRectMake(STWidth(270), STHeight(35), STWidth(70), STHeight(33));
    [withdrawBtn addTarget:self action:@selector(onWithdrawBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:withdrawBtn];
    
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if([userModel.mchId isEqualToString:@"m202009220000163"]){
        withdrawBtn.hidden = YES;
    }
    
    UILabel *totalTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:@"销售总额（元）" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    CGSize totalTitleSize = [totalTitleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    totalTitleLabel.frame = CGRectMake(STWidth(35), STHeight(150), totalTitleSize.width, STHeight(20));
    [self addSubview:totalTitleLabel];
    
    _incomeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(20)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_incomeLabel];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(STWidth(140), STHeight(164), 1, STHeight(18))];
    lineView2.backgroundColor = c16;
    [self addSubview:lineView2];
    
    UILabel *incomeTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:@"收入分成（元）" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    CGSize incomeTitleSize = [incomeTitleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    incomeTitleLabel.frame = CGRectMake(STWidth(170), STHeight(150), incomeTitleSize.width, STHeight(20));
    [self addSubview:incomeTitleLabel];
    
    _totalLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(20)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_totalLabel];
    
    UIButton *sellStatisticsBtn = [[UIButton alloc]init];
    sellStatisticsBtn.frame = CGRectMake(STWidth(15), STHeight(135), STWidth(126), STHeight(78));
    sellStatisticsBtn.tag = StaticticsType_Sell;
    [sellStatisticsBtn addTarget:self action:@selector(onStatisticsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sellStatisticsBtn];
    
    UIButton *incomeStatisticsBtn = [[UIButton alloc]init];
     incomeStatisticsBtn.frame = CGRectMake(STWidth(141), STHeight(135), STWidth(233), STHeight(78));
     incomeStatisticsBtn.tag = StaticticsType_Income;
     [incomeStatisticsBtn addTarget:self action:@selector(onStatisticsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview:incomeStatisticsBtn];
}

-(void)updateView:(CapitalModel *)model{
    _balanceLabel.text = [NSString stringWithFormat:@"%.2f",model.actualCanWithdrawNum / 100];
    CGSize balanceSize = [_balanceLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(30) fontName:FONT_SEMIBOLD];
    _balanceLabel.frame = CGRectMake(STWidth(35), STHeight(60), balanceSize.width, STHeight(35));
    
    _canWithdrawLabel.text = [NSString stringWithFormat:@"可提现：%.2f",model.canWithdrawNum / 100];
    CGSize canWithdrawSize = [_canWithdrawLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    _canWithdrawLabel.frame = CGRectMake(STWidth(35), STHeight(100), canWithdrawSize.width, STHeight(20));
    
    _freezeLabel.text = [NSString stringWithFormat:@"冻结：%.2f",model.freezeMoney / 100];
    CGSize freezeSize = [_canWithdrawLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    _freezeLabel.frame = CGRectMake(STWidth(55) + canWithdrawSize.width, STHeight(100), freezeSize.width, STHeight(20));
    
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
     if([userModel.mchId isEqualToString:@"m202009220000163"]){
         _canWithdrawLabel.hidden = YES;
         _freezeLabel.hidden = YES;
     }
    
    _totalLabel.text = [NSString stringWithFormat:@"%.2f",model.totalSell / 100];
    CGSize totalSize = [_totalLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(20) fontName:FONT_SEMIBOLD];
    _totalLabel.frame = CGRectMake(STWidth(35), STHeight(170), totalSize.width, STHeight(24));
    
    _incomeLabel.text = [NSString stringWithFormat:@"%.2f",model.totalIncome / 100];
    CGSize incomeSize = [_incomeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(20) fontName:FONT_SEMIBOLD];
    _incomeLabel.frame = CGRectMake(STWidth(170), STHeight(170), incomeSize.width, STHeight(24));
}

-(void)onWithdrawBtnClick{
    if(_delegate){
        [_delegate onCapitalMcnViewWithdrawBtnClick];
    }
}

-(void)onStatisticsBtnClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    if(_delegate){
        [_delegate onCapitalMcnViewStatisticsBtnClick:button.tag];
    }
}

@end
