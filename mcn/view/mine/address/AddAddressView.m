//
//  AddAddressView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AddAddressView.h"
#import "STBlankInView.h"
#import "STSelectInView.h"
#import "STAddressPickerLayerView.h"
#import "STSwitchView.h"
@interface AddAddressView()<STSelectInViewDelegate,STSwitchViewDelegate,STAddressPickerLayerViewDelegate,STBlankInViewDelegate>

@property(strong, nonatomic)AddAddressViewModel *mViewModel;
@property(strong, nonatomic)STBlankInView *nameView;
@property(strong, nonatomic)STBlankInView *phoneView;
@property(strong, nonatomic)STSelectInView *addressSelectView;
@property(strong, nonatomic)STBlankInView *detailView;
@property(strong, nonatomic)STSwitchView *switchView;
@property(strong, nonatomic)STAddressPickerLayerView *addressLayerView;
@property(strong, nonatomic)XWBottomButton *defaultBtn;

@end

@implementation AddAddressView

-(instancetype)initWithViewModel:(AddAddressViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    CGFloat top = 0;
    _nameView = [[STBlankInView alloc]initWithTitle:MSG_ADDRESSMANAGE_NAME placeHolder:MSG_ADDRESSMANAGE_NAME_HOLDER];
    _nameView.frame = CGRectMake(0, top, ScreenWidth, BlankHeight);
    _nameView.delegate = self;
    [self addSubview:_nameView];
    
    top += BlankHeight;
    _phoneView = [[STBlankInView alloc]initWithTitle:MSG_ADDRESSMANAGE_PHONE placeHolder:MSG_ADDRESSMANAGE_PHONE_HOLDER];
    [_phoneView inputNumber];
    [_phoneView setMaxLength:11];
    _phoneView.frame = CGRectMake(0, top, ScreenWidth, BlankHeight);
    _phoneView.delegate = self;
    [self addSubview:_phoneView];
    
    top += BlankHeight;
    _addressSelectView = [[STSelectInView alloc]initWithTitle:MSG_ADDRESSMANAGE_ADDRESS placeHolder:MSG_ADDRESSMANAGE_ADDRESS_HOLDER frame:CGRectMake(0, 0, ScreenWidth, STHeight(51))];
    _addressSelectView.delegate = self;
    _addressSelectView.frame = CGRectMake(0, top, ScreenWidth, BlankHeight);
    [self addSubview:_addressSelectView];
    
    top += BlankHeight;
    _detailView = [[STBlankInView alloc]initWithTitle:MSG_ADDRESSMANAGE_DETAIL placeHolder:MSG_ADDRESSMANAGE_DETAIL_HOLDER];
    _detailView.frame = CGRectMake(0, top, ScreenWidth, BlankHeight);
    _detailView.delegate = self;
    [self addSubview:_detailView];
    
    top += BlankHeight;
    UILabel *defaultLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_ADDRESSMANAGE_DEFAULT_ADDRESS textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    CGSize defaultSize = [defaultLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    defaultLabel.frame = CGRectMake(STWidth(15), top + STHeight(23), defaultSize.width, STHeight(21));
    [self addSubview:defaultLabel];
    
    _switchView = [[STSwitchView alloc]init];
    _switchView.frame = CGRectMake(ScreenWidth - STWidth(65), top + STHeight(21), STWidth(50), STHeight(25));
    _switchView.delegate = self;
    [self addSubview:_switchView];
    
    
    _defaultBtn = [[XWBottomButton alloc]initWithTitle:MSG_SAVE];
    _defaultBtn.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
    [_defaultBtn addTarget:self action:@selector(onDefaultBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_defaultBtn];
    
    _addressLayerView = [[STAddressPickerLayerView alloc]init];
    _addressLayerView.hidden = YES;
    _addressLayerView.delegate = self;
    [self addSubview:_addressLayerView];
    
    
    if(!IS_NS_STRING_EMPTY(_mViewModel.model.contactUser)){
        [_nameView setContent:_mViewModel.model.contactUser];
    }
    if(!IS_NS_STRING_EMPTY(_mViewModel.model.contactPhone)){
        [_phoneView setContent:_mViewModel.model.contactPhone];
    }
    if(!IS_NS_STRING_EMPTY(_mViewModel.model.detailAddr)){
        [_detailView setContent:_mViewModel.model.detailAddr];
    }
    if(!IS_NS_STRING_EMPTY(_mViewModel.model.province)){
        [_addressSelectView setContent:[NSString stringWithFormat:@"%@-%@-%@",_mViewModel.model.province,_mViewModel.model.city,_mViewModel.model.area]];
    }
    if(_mViewModel.model){
        [_switchView setOn:_mViewModel.model.defaultFlag];
    }
    [self checkDefaultBtnStatu];
}

-(void)onSwitchStatuChange:(Boolean)on tag:(NSInteger)tag view:(id)switchView{
    _mViewModel.model.defaultFlag = on;
}

-(void)onSelectClicked:(id)selectInView{
    [self resignAll];
    _addressLayerView.hidden = NO;
}

-(void)onTextFieldDidChange:(id)view{
    [self checkDefaultBtnStatu];
}

-(void)onSelectResult:(UIView *)layerView province:(NSString *)provinceStr city:(NSString *)cityStr area:(NSString *)area{
    _mViewModel.model.province = provinceStr;
    _mViewModel.model.city = cityStr;
    _mViewModel.model.area = area;
    [_addressSelectView setContent:[NSString stringWithFormat:@"%@-%@-%@",provinceStr,cityStr,area]];
    [self checkDefaultBtnStatu];
}

-(void)updateView{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resignAll];
}

-(void)resignAll{
    [_nameView resign];
    [_phoneView resign];
    [_detailView resign];
}

-(void)checkDefaultBtnStatu{
    if(IS_NS_STRING_EMPTY([_nameView getContent]) ||
       IS_NS_STRING_EMPTY([_phoneView getContent]) ||
       IS_NS_STRING_EMPTY([_detailView getContent]) ||
       IS_NS_STRING_EMPTY([_addressSelectView getContent])){
        [_defaultBtn setDisable:YES];
        return;
    }else{
        [_defaultBtn setDisable:NO];
    }
}

-(void)onDefaultBtnClick{
    if(_mViewModel){
        _mViewModel.model.detailAddr = [_detailView getContent];
        _mViewModel.model.contactUser = [_nameView getContent];
        _mViewModel.model.contactPhone = [_phoneView getContent];
        if(_mViewModel.type == AddAddressType_Add){
            [_mViewModel requestAddAddress];
        }else{
            [_mViewModel requestEditAddress];
        }
    }
}

@end

