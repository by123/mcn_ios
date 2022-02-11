//
//  DeliveryView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "DeliveryView.h"
#import "STBlankInView.h"
#import "STDefaultBtnView.h"
#import "STSelectInView.h"
#import "STSinglePickerLayerView.h"

@interface DeliveryView()<STBlankInViewDelegate,STDefaultBtnViewDelegate,STSelectInViewDelegate,STSinglePickerLayerViewDelegate>

@property(strong, nonatomic)DeliveryViewModel *mViewModel;
@property(strong, nonatomic)UIView *cardView;
@property(strong, nonatomic)STSelectInView *selectView;
@property(strong, nonatomic)STBlankInView *companyView;
@property(strong, nonatomic)STBlankInView *numberView;
@property(strong, nonatomic)STDefaultBtnView *confirmBtn;
@property(strong, nonatomic)STSinglePickerLayerView *layerView;

@end

@implementation DeliveryView{
    CGFloat dynamicHeight;
}

-(instancetype)initWithViewModel:(DeliveryViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _cardView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15), STWidth(345), 0)];
    _cardView.backgroundColor = cwhite;
    _cardView.layer.cornerRadius = 4;
    _cardView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _cardView.layer.shadowOffset = CGSizeMake(0,2);
    _cardView.layer.shadowOpacity = 1;
    _cardView.layer.shadowRadius = 10;
    [self addSubview:_cardView];
    
    UILabel *contactLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:[NSString stringWithFormat:@"%@  %@",_mViewModel.addressModel.contactUser,_mViewModel.addressModel.contactPhone] textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize contactSize = [contactLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    contactLabel.frame = CGRectMake(STWidth(18), STHeight(19), contactSize.width, STHeight(21));
    [_cardView addSubview:contactLabel];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:[NSString stringWithFormat:@"%@%@%@%@",_mViewModel.addressModel.province,_mViewModel.addressModel.city,_mViewModel.addressModel.area,_mViewModel.addressModel.detailAddr] textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    CGSize addressSize = [addressLabel.text sizeWithMaxWidth:STWidth(270) font:STFont(15) fontName:FONT_SEMIBOLD];
    addressLabel.frame = CGRectMake(STWidth(18), STHeight(50), STWidth(270), addressSize.height);
    [_cardView addSubview:addressLabel];
    
    UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, STHeight(66) + addressSize.height, STWidth(345), STHeight(4))];
    lineImageView.image = [UIImage imageNamed:IMAGE_ADDRESSINFO_BOTTOM];
    lineImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_cardView addSubview:lineImageView];
    
    _cardView.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(70) + addressSize.height);

    dynamicHeight = STHeight(85) + addressSize.height;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:@"请填写物流信息" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(15), dynamicHeight + STHeight(35), titleSize.width, STHeight(25));
    [self addSubview:titleLabel];
        
    _selectView = [[STSelectInView alloc]initWithTitle:@"快递公司" placeHolder:@"请选择物流公司名称" frame:CGRectMake(0, 0, ScreenWidth, STHeight(60))];
    _selectView.frame = CGRectMake(0, dynamicHeight + STHeight(70), ScreenWidth, STHeight(60));
    _selectView.delegate = self;
    [self addSubview:_selectView];
    
    _companyView = [[STBlankInView alloc]initWithTitle:@"快递公司" placeHolder:@"请填写物流公司名称"];
    _companyView.frame = CGRectMake(0, dynamicHeight + STHeight(130), ScreenWidth, STHeight(60));
    _companyView.delegate = self;
    _companyView.hidden = YES;
    [self addSubview:_companyView];
    
    _numberView = [[STBlankInView alloc]initWithTitle:@"物流单号" placeHolder:@"请填写物流单号"];
    _numberView.frame = CGRectMake(0, dynamicHeight + STHeight(130), ScreenWidth, STHeight(60));
    _numberView.delegate = self;
    [self addSubview:_numberView];
    
    _confirmBtn = [[STDefaultBtnView alloc]initWithTitle:@"确认发货"];
    _confirmBtn.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
    _confirmBtn.delegate = self;
    [self addSubview:_confirmBtn];
    
    _layerView = [[STSinglePickerLayerView alloc]initWithDatas:nil];
    _layerView.hidden = YES;
    _layerView.delegate = self;
    [STWindowUtil addWindowView:_layerView];
}

-(void)onTextFieldDidChange:(id)view{
    [self checkButtonStatu];
}

-(void)onSelectClicked:(id)selectInView{
    _layerView.hidden = NO;
    [_companyView resign];
    [_numberView resign];
}

-(void)onSelectResult:(NSString *)result layerView:(UIView *)layerView position:(NSInteger)position{
    ExpressModel *model = [_mViewModel.expressDatas objectAtIndex:position];
    _mViewModel.model.expressCompanyId = model.expressCode;
    _mViewModel.model.expressCompanyName = model.expressName;
    [_selectView setContent:model.expressName];
    if(model.expressCode == 100){
        _companyView.hidden = NO;
        _numberView.frame = CGRectMake(0, dynamicHeight + STHeight(190), ScreenWidth, STHeight(60));
    }else{
        _companyView.hidden = YES;
        _numberView.frame = CGRectMake(0, dynamicHeight + STHeight(130), ScreenWidth, STHeight(60));
    }
    [self checkButtonStatu];
}

-(void)onDefaultBtnClick{
    if(_mViewModel.model.expressCompanyId == 100){
        _mViewModel.model.expressCompanyName = [_companyView getContent];
    }
    _mViewModel.model.expressNumber = [_numberView getContent];
    [_mViewModel submitDelivery];
}

-(void)checkButtonStatu{
    if(IS_NS_STRING_EMPTY([_numberView getContent])){
        [_confirmBtn setActive:NO];
        return;
    }
    if(IS_NS_STRING_EMPTY([_selectView getContent])){
        [_confirmBtn setActive:NO];
        return;
    }
    if(IS_NS_STRING_EMPTY([_companyView getContent]) && _mViewModel.model.expressCompanyId == 100){
        [_confirmBtn setActive:NO];
        return;
    }
    [_confirmBtn setActive:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_companyView resign];
    [_numberView resign];
}

-(void)updateView{
    
}

-(void)updateExpressView{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.expressDatas)){
        for(ExpressModel *model in _mViewModel.expressDatas){
            [datas addObject:model.expressName];
        }
    }
    [_layerView updateDatas:datas];
}


@end

