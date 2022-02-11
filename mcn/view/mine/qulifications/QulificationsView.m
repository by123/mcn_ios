//
//  QulificationsView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "QulificationsView.h"

@interface QulificationsView()

@property(strong, nonatomic)QulificationsViewModel *mViewModel;

@end

@implementation QulificationsView

-(instancetype)initWithViewModel:(QulificationsViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UIButton *merchantBtn = [[UIButton alloc]init];
    [merchantBtn setImage:[UIImage imageNamed:IMAGE_QULIFICATIONS_MERCHANT] forState:UIControlStateNormal];
    merchantBtn.frame = CGRectMake(STWidth(30), STHeight(20), STWidth(315), STHeight(120));
    [merchantBtn addTarget:self action:@selector(onMerchantBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:merchantBtn];
    [self addTitle:merchantBtn titleStr:@"我是商户"];
    
    UIButton *mcnBtn = [[UIButton alloc]init];
    [mcnBtn setImage:[UIImage imageNamed:IMAGE_QULIFICATIONS_MCN] forState:UIControlStateNormal];
    mcnBtn.frame = CGRectMake(STWidth(30), STHeight(160), STWidth(315), STHeight(120));
    [mcnBtn addTarget:self action:@selector(onMCNBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mcnBtn];
    [self addTitle:mcnBtn titleStr:@"我是MCN机构"];
    
    UIButton *celebrityBtn = [[UIButton alloc]init];
    [celebrityBtn setImage:[UIImage imageNamed:IMAGE_QULIFICATIONS_CELEBRITY] forState:UIControlStateNormal];
    celebrityBtn.frame = CGRectMake(STWidth(30), STHeight(300), STWidth(315), STHeight(120));
    [celebrityBtn addTarget:self action:@selector(onCelebrityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:celebrityBtn];
    [self addTitle:celebrityBtn titleStr:@"我是主播"];
    
}

-(void)updateView{}

-(void)addTitle:(UIView *)view titleStr:(NSString *)titleStr{
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:titleStr textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(25), STHeight(24), titleSize.width, STHeight(25));
    [view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(28), STHeight(52), STWidth(14), STHeight(4))];
    lineView.backgroundColor = c16;
    [view addSubview:lineView];
}

-(void)onMerchantBtnClick{
    [_mViewModel goQulificationsEditPage:RoleType_Merchant];
}

-(void)onMCNBtnClick{
    [_mViewModel goQulificationsEditPage:RoleType_Mcn];
}

-(void)onCelebrityBtnClick{
    [_mViewModel goQulificationsEditPage:RoleType_Celebrity];
}

@end

