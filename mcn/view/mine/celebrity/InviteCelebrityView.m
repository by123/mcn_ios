//
//  InviteCelebrityView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "InviteCelebrityView.h"
#import "STBlankInView.h"
#import "STSelectInView.h"
#import "STDefaultBtnView.h"
#import "STSinglePickerLayerView.h"

@interface InviteCelebrityView()<STBlankInViewDelegate,STSelectInViewDelegate,STDefaultBtnViewDelegate,STSinglePickerLayerViewDelegate>

@property(strong, nonatomic)InviteCelebrityViewModel *mViewModel;
@property(strong, nonatomic)STBlankInView *nameView;
@property(strong, nonatomic)STBlankInView *mobileView;
@property(strong, nonatomic)STSelectInView *profitView;
@property(strong, nonatomic)STDefaultBtnView *confirmBtn;
@property(strong, nonatomic)STSinglePickerLayerView *layerView;

@end

@implementation InviteCelebrityView

-(instancetype)initWithViewModel:(InviteCelebrityViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _nameView = [[STBlankInView alloc]initWithTitle:@"姓名" placeHolder:@"请输入主播姓名"];
    _nameView.delegate = self;
    [_nameView setMaxLength:10];
    _nameView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(60));
    [self addSubview:_nameView];
    
    _mobileView = [[STBlankInView alloc]initWithTitle:@"手机号" placeHolder:@"请输入主播手机号"];
    _mobileView.delegate = self;
    [_mobileView inputNumber];
    [_mobileView setMaxLength:11];
    _mobileView.frame = CGRectMake(0, STHeight(60), ScreenWidth, STHeight(60));
    [self addSubview:_mobileView];
    
    _profitView = [[STSelectInView alloc]initWithTitle:@"分成比例" placeHolder:@"请选择分成比例" frame:CGRectMake(0, 0, ScreenWidth, STHeight(60))];
    _profitView.delegate = self;
    _profitView.frame = CGRectMake(0, STHeight(120), ScreenWidth, STHeight(60));
    [_profitView hiddenLine];
    [self addSubview:_profitView];
    
    _confirmBtn = [[STDefaultBtnView alloc]initWithTitle:@"确认添加"];
    _confirmBtn.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
    _confirmBtn.delegate = self;
    [_confirmBtn setActive:NO];
    [self addSubview:_confirmBtn];
    
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    for(int i = 0 ; i <= 10 ; i ++){
        [datas addObject:[NSString stringWithFormat:@"%d%%",i * 10]];
    }
    _layerView = [[STSinglePickerLayerView alloc]initWithDatas:datas];
    _layerView.hidden = YES;
    _layerView.delegate = self;
    [STWindowUtil addWindowView:_layerView];
}

-(void)onTextFieldDidChange:(id)view{
    [self checkButtonStatu];
}

-(void)onSelectClicked:(id)selectInView{
    [_nameView resign];
     [_mobileView resign];
    _layerView.hidden = NO;
}

-(void)onSelectResult:(NSString *)result layerView:(UIView *)layerView position:(NSInteger)position{
    [_profitView setContent:result];
    [self checkButtonStatu];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_nameView resign];
    [_mobileView resign];
}


-(void)checkButtonStatu{
    if(IS_NS_STRING_EMPTY([_nameView getContent])){
        [_confirmBtn setActive:NO];
        return;
    }
    if(IS_NS_STRING_EMPTY([_mobileView getContent])){
        [_confirmBtn setActive:NO];
        return;
    }
    if(IS_NS_STRING_EMPTY([_profitView getContent])){
        [_confirmBtn setActive:NO];
        return;
    }
    [_confirmBtn setActive:YES];
}

-(void)onDefaultBtnClick{
    if(_mViewModel){
        _mViewModel.model.anchorName = [_nameView getContent];
        _mViewModel.model.anchorMobile = [_mobileView getContent];
        int profit = 0;
        NSString *profitStr = [_profitView getContent];
        profitStr = [profitStr substringWithRange:NSMakeRange(0, profitStr.length - 1)];
        profit = [profitStr intValue];
        _mViewModel.model.allocateRatio = profit;
        [_mViewModel inviteCelebrity];
    }
}

-(void)updateView{
    
}

@end

