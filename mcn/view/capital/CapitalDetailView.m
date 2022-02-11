//
//  CapitalDetailView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "CapitalDetailView.h"
#import "STBlankInView.h"
#import "ProductModel.h"
#import "STTimeUtil.h"
@interface CapitalDetailView()

@property(strong, nonatomic)CapitalDetailViewModel *mViewModel;
@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)UILabel *moneyLabel;
@property(strong, nonatomic)STBlankInView *typeView;
@property(strong, nonatomic)STBlankInView *nameView;
@property(strong, nonatomic)STBlankInView *acturePayView;
@property(strong, nonatomic)STBlankInView *profitView;
@property(strong, nonatomic)STBlankInView *originView;
@property(strong, nonatomic)STBlankInView *idView;
@property(strong, nonatomic)STBlankInView *timeView;

@end


@implementation CapitalDetailView

-(instancetype)initWithViewModel:(CapitalDetailViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(340))];
    topView.backgroundColor = cwhite;
    [_scrollView addSubview:topView];
    
    _moneyLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(36)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c45 backgroundColor:nil multiLine:NO];
    _moneyLabel.frame = CGRectMake(0, STHeight(15), ScreenWidth, STHeight(42));
    [topView addSubview:_moneyLabel];
    
    UILabel *compeleteLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:@"交易完成" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    compeleteLabel.frame = CGRectMake(0, STHeight(62), ScreenWidth, STHeight(17));
    [topView addSubview:compeleteLabel];
    
    _typeView = [[STBlankInView alloc]initWithTitle:@"交易类型" placeHolder:MSG_EMPTY];
    _typeView.contentTF.enabled = NO;
    _typeView.frame = CGRectMake(0, STHeight(100), ScreenWidth, STHeight(60));
    [topView addSubview:_typeView];
    
    _nameView = [[STBlankInView alloc]initWithTitle:@"交易商品" placeHolder:MSG_EMPTY];
    _nameView.contentTF.enabled = NO;
    _nameView.frame = CGRectMake(0, STHeight(160), ScreenWidth, STHeight(60));
    [topView addSubview:_nameView];
    
    _acturePayView = [[STBlankInView alloc]initWithTitle:@"实付金额" placeHolder:MSG_EMPTY];
    _acturePayView.contentTF.enabled = NO;
    _acturePayView.frame = CGRectMake(0, STHeight(220), ScreenWidth, STHeight(60));
    [topView addSubview:_acturePayView];
    
    _profitView = [[STBlankInView alloc]initWithTitle:@"平台分成" placeHolder:MSG_EMPTY];
    _profitView.contentTF.enabled = NO;
    _profitView.frame = CGRectMake(0, STHeight(280), ScreenWidth, STHeight(60));
    [_profitView hiddenLine];
    [topView addSubview:_profitView];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(355), ScreenWidth, STHeight(180))];
    bottomView.backgroundColor = cwhite;
    [_scrollView addSubview:bottomView];
    
    _originView = [[STBlankInView alloc]initWithTitle:@"订单来源" placeHolder:MSG_EMPTY];
    _originView.contentTF.enabled = NO;
    _originView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(60));
    [bottomView addSubview:_originView];
    
    _idView = [[STBlankInView alloc]initWithTitle:@"订单编号" placeHolder:MSG_EMPTY];
    _idView.contentTF.enabled = NO;
    _idView.frame = CGRectMake(0, STHeight(60), ScreenWidth, STHeight(60));
    [bottomView addSubview:_idView];
    
    _timeView = [[STBlankInView alloc]initWithTitle:@"订单时间" placeHolder:MSG_EMPTY];
    _timeView.contentTF.enabled = NO;
    _timeView.frame = CGRectMake(0, STHeight(120), ScreenWidth, STHeight(60));
    [_timeView hiddenLine];
    [bottomView addSubview:_timeView];
    
}

-(void)updateView{
    CapitalDetailModel *model  = _mViewModel.model;
    _moneyLabel.text = [NSString stringWithFormat:@"%@%.2f",model.direction == 0 ? @"+" : @"-" , model.profit / 100];
    
    if(model.profitType == ProfitType_NatureBuy){
        [_typeView setContent:@"自然购买"];
    }else if(model.profitType == ProfitType_GuideBuy){
        [_typeView setContent:@"导购订单"];
    }else if(model.profitType == ProfitType_Withdraw){
        [_typeView setContent:@"提现"];
    }else{
        [_typeView setContent:@"未知"];
    }
    
    [_nameView setContent:[NSString stringWithFormat:@"%@%@",model.spuName,[ProductModel getAttributeValue:model.attribute]]];
    
    [_acturePayView setContent:[NSString stringWithFormat:@"%.2f元",model.actualPrice/ 100]];
    [_profitView setContent:[NSString stringWithFormat:@"%.2f元",[CapitalDetailModel getMoney:MoneyType_PLAT_IN detailJson:model.detailJson] / 100]];
    
    
    [_originView setContent:model.orderOrigin];
    [_idView setContent:model.orderId];
    [_timeView setContent:[STTimeUtil generateDate:model.orderTime format:MSG_DATE_FORMAT_ALL]];

}

@end

