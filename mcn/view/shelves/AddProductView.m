//
//  AddProductView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AddProductView.h"
#import "STBlankInView.h"
#import "STDefaultBtnView.h"
#import "TouchScrollView.h"
#import "STAddImageView.h"
#import "STSelectInView.h"
#import "STSinglePickerLayerView.h"
#import "UITextView+Placeholder.h"

@interface AddProductView()<STBlankInViewDelegate,STDefaultBtnViewDelegate,TouchScrollViewDelegate,STAddImageViewDelegate,STSelectInViewDelegate,STSinglePickerLayerViewDelegate,UITextViewDelegate>

@property(strong, nonatomic)AddProductViewModel *mViewModel;
@property(strong, nonatomic)STBlankInView *nameView;
@property(strong, nonatomic)STSelectInView *typeView;
@property(strong, nonatomic)STBlankInView *priceView;
@property(strong, nonatomic)TouchScrollView *scrollView;
@property(strong, nonatomic)STDefaultBtnView *commitBtn;
@property(strong, nonatomic)STAddImageView *photeView;
@property(strong, nonatomic)STAddImageView *detailView;
@property(strong, nonatomic)STBlankInView *firstProfitView;
@property(strong, nonatomic)STSelectInView *reProfitView;
@property(strong, nonatomic)STSinglePickerLayerView *typeLayerView;
@property(strong, nonatomic)STSinglePickerLayerView *layerView;
@property(strong, nonatomic)UILabel *reProfitLabel;
@property(strong, nonatomic)UILabel *sellProfitLabel;
@property(strong, nonatomic)UITextView *descriptTv;

@property(assign, nonatomic)CGFloat dynamicHeight;

@end

@implementation AddProductView

-(instancetype)initWithViewModel:(AddProductViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _scrollView = [[TouchScrollView alloc]initWithParentView:self delegate:self];
    _scrollView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(80));
    [self addSubview:_scrollView];
    
    _dynamicHeight = 0;
    [self initInfoView];
    [self initPictureView];
    [self initProfitView];
    [self initDescriptView];
    [self initDetailView];
    [_scrollView setContentSize:CGSizeMake(ScreenWidth, _dynamicHeight)];
    
    _commitBtn = [[STDefaultBtnView alloc]initWithTitle:@"确认上传"];
    _commitBtn.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
    _commitBtn.delegate = self;
    [_commitBtn setActive:NO];
    [self addSubview:_commitBtn];
    
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    for(int i = 0 ; i <= 10 ; i ++){
        [datas addObject:[NSString stringWithFormat:@"%d%%",i * 5]];
    }
    _layerView = [[STSinglePickerLayerView alloc]initWithDatas:datas];
    _layerView.hidden = YES;
    _layerView.delegate = self;
    [STWindowUtil addWindowView:_layerView];
    
    
    _typeLayerView = [[STSinglePickerLayerView alloc]initWithDatas:nil];
    _typeLayerView.hidden = YES;
    _typeLayerView.delegate = self;
    [STWindowUtil addWindowView:_typeLayerView];
    
}

//基本信息
-(void)initInfoView{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(222))];
    topView.backgroundColor = cwhite;
    [_scrollView addSubview:topView];
    
    [self buildTitle:topView title:@"基本信息"];
    
    _nameView = [[STBlankInView alloc]initWithTitle:@"产品名称" placeHolder:@"请输入产品名称"];
    _nameView.delegate = self;
    _nameView.frame = CGRectMake(0, STHeight(42), ScreenWidth, STHeight(60));
    [topView addSubview:_nameView];
    
    _typeView = [[STSelectInView alloc]initWithTitle:@"产品类型" placeHolder:@"请选择产品类型" frame:CGRectMake(0, 0, ScreenWidth, STHeight(60))];
    _typeView.delegate = self;
    _typeView.frame = CGRectMake(0, STHeight(102), ScreenWidth, STHeight(60));
    [topView addSubview:_typeView];
    
    _priceView = [[STBlankInView alloc]initWithTitle:@"产品价格" placeHolder:@"请输入产品价格"];
    _priceView.delegate = self;
    _priceView.frame = CGRectMake(0, STHeight(162), ScreenWidth, STHeight(60));
    [_priceView inputDecimalNumber];
    [_priceView hiddenLine];
    [topView addSubview:_priceView];
    
    
    _dynamicHeight += STHeight(222);
    
}

//产品相册
-(void)initPictureView{
    
    UIView *picView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(15) + _dynamicHeight, ScreenWidth, STHeight(125 + 42))];
    picView.backgroundColor = cwhite;
    [_scrollView addSubview:picView];
    
    [self buildTitle:picView title:@"产品相册"];
    
    
    _photeView = [[STAddImageView alloc]initWithImages:nil];
    _photeView.frame = CGRectMake(0, STHeight(42), ScreenWidth, STHeight(125));
    _photeView.delegate = self;
    [picView addSubview:_photeView];
    _dynamicHeight += STHeight(182);
}

//分成信息
-(void)initProfitView{
    UIView *profitView = [[UIView alloc]initWithFrame:CGRectMake(0, _dynamicHeight + STHeight(15), ScreenWidth, STHeight(247))];
    profitView.backgroundColor = cwhite;
    [_scrollView addSubview:profitView];
    
    [self buildTitle:profitView title:@"分成信息"];
    
    _firstProfitView = [[STBlankInView alloc]initWithTitle:@"首单分成金额" placeHolder:MSG_EMPTY];
    _firstProfitView.delegate = self;
    _firstProfitView.contentTF.enabled = NO;
    _firstProfitView.frame = CGRectMake(0, STHeight(42), ScreenWidth, STHeight(60));
    [_firstProfitView inputDecimalNumber];
    [profitView addSubview:_firstProfitView];
    
    _reProfitView = [[STSelectInView alloc]initWithTitle:@"选择复购分成比例" placeHolder:@"请选择" frame:CGRectMake(0, 0, ScreenWidth, STHeight(60))];
    _reProfitView.delegate = self;
    _reProfitView.frame = CGRectMake(0, STHeight(102), ScreenWidth, STHeight(60));
    [profitView addSubview:_reProfitView];
    
    _reProfitLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:@"复购分成金额:¥0.00" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [profitView addSubview:_reProfitLabel];
    
    _sellProfitLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:@"销售分成金额:¥0.00" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [profitView addSubview:_sellProfitLabel];
    
    _dynamicHeight += STHeight(262);
    
}

//产品介绍
-(void)initDescriptView{
    UIView *descriptView = [[UIView alloc]initWithFrame:CGRectMake(0, _dynamicHeight + STHeight(15), ScreenWidth, STHeight(202))];
    descriptView.backgroundColor = cwhite;
    [_scrollView addSubview:descriptView];
    
    UIView *descriptionContentView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(57), STWidth(345), STHeight(125))];
    descriptionContentView.backgroundColor = cbg;
    [descriptView addSubview:descriptionContentView];
    
    _descriptTv = [[UITextView alloc]initWithFrame:CGRectMake(STWidth(10), STHeight(5), STWidth(325), STHeight(115))];
    _descriptTv.font = [UIFont fontWithName:FONT_REGULAR size:STFont(15)];
    _descriptTv.textColor = c10;
    _descriptTv.backgroundColor = cbg;
    _descriptTv.delegate = self;
    [_descriptTv setPlaceholder:@"请输入内容介绍" placeholdColor:c03];
    _descriptTv.showsHorizontalScrollIndicator = NO;
    _descriptTv.showsVerticalScrollIndicator = NO;
    [descriptionContentView addSubview:_descriptTv];
    
    
    [self buildTitle:descriptView title:@"产品介绍"];
    
    _dynamicHeight += STHeight(217);
}

//产品详情
-(void)initDetailView{
    UIView *descriptView = [[UIView alloc]initWithFrame:CGRectMake(0, _dynamicHeight + STHeight(15), ScreenWidth, STHeight(167))];
    descriptView.backgroundColor = cwhite;
    [_scrollView addSubview:descriptView];
    
    _detailView = [[STAddImageView alloc]initWithImages:nil];
    _detailView.frame = CGRectMake(0, STHeight(42), ScreenWidth, STHeight(125));
    _detailView.delegate = self;
    [descriptView addSubview:_detailView];
    
    [self buildTitle:descriptView title:@"产品详情"];
    
    _dynamicHeight += STHeight(197);
}

-(void)buildTitle:(UIView *)view title:(NSString *)title{
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(16)] text:title textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize nameSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(16) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(20), nameSize.width, STHeight(22));
    [view addSubview:titleLabel];
}


-(void)updateView{
    
}

-(void)updatePhotoView{
    [_photeView setDatas:_mViewModel.photosImgDatas];
    [self checkButtonStatu];
}

-(void)updateDetailView{
    [_detailView setDatas:_mViewModel.detailImgDatas];
    [self checkButtonStatu];
}

-(void)updateConfig{
    double price = [[_priceView getContent] doubleValue];
    double firstPrice = price * _mViewModel.configModel.order / 100;
    double rePrice = firstPrice * _mViewModel.addProductModel.repeatRatio / 100;
    double sellPrice = firstPrice - rePrice;
    
    [_firstProfitView setContent:[NSString stringWithFormat:@"%.2f",firstPrice]];
    
    _reProfitLabel.text = [NSString stringWithFormat:@"复购分成金额:¥%.2f",rePrice];
    CGSize reProfitSize = [_reProfitLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    _reProfitLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - reProfitSize.width, STHeight(177), reProfitSize.width, STHeight(20));
    
    _sellProfitLabel.text = [NSString stringWithFormat:@"销售分成金额:¥%.2f",sellPrice];
    CGSize sellProfitSize = [_sellProfitLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    _sellProfitLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - sellProfitSize.width, STHeight(207), sellProfitSize.width, STHeight(20));
}

-(void)updateType{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.categoryDatas)){
        for(CategoryModel *model in _mViewModel.categoryDatas){
            [datas addObject:model.goodsClass];
        }
    }
    [_typeLayerView updateDatas:datas];
}


-(void)onScrollViewDidScroll:(UIScrollView *)scrollView{}


-(void)onAddImageViewItemClick:(NSInteger)position view:(nonnull id)view{
    [self resignAll];
    if(view == _photeView){
        if(position + 1 < _photeView.imageDatas.count){
            [self restorePhotoDatas];
            PreviewModel *model =  _mViewModel.photosImgDatas[position];
            model.isSelect = YES;
            [_mViewModel goPreviewPage:_mViewModel.photosImgDatas previewType:PreviewImageType_Photo];
        }else{
            [_mViewModel openPhotoDialog:PreviewImageType_Photo];
        }
    }else{
        if(position + 1 < _detailView.imageDatas.count){
            [self restoreDetailDatas];
            PreviewModel *model =  _mViewModel.detailImgDatas[position];
            model.isSelect = YES;
            [_mViewModel goPreviewPage:_mViewModel.detailImgDatas previewType:PreviewImageType_Detail];
        }else{
            [_mViewModel openPhotoDialog:PreviewImageType_Detail];
        }
    }
}

-(void)restorePhotoDatas{
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.photosImgDatas)){
        for(PreviewModel *model in _mViewModel.photosImgDatas){
            model.isSelect = NO;
        }
    }
}

-(void)restoreDetailDatas{
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.detailImgDatas)){
        for(PreviewModel *model in _mViewModel.detailImgDatas){
            model.isSelect = NO;
        }
    }
}

-(void)onTextFieldDidChange:(id)view{
    if(view == _priceView){
        [self updateConfig];
    }
    [self checkButtonStatu];
}

-(void)textViewDidChange:(UITextView *)textView{
    [self checkButtonStatu];
}

-(void)onSelectClicked:(id)selectInView{
    if(selectInView == _typeView){
        _typeLayerView.hidden = NO;
        _layerView.hidden = YES;
    }else{
        _typeLayerView.hidden = YES;
        _layerView.hidden = NO;
    }
    [self resignAll];
}

-(void)onSelectResult:(NSString *)result layerView:(UIView *)layerView position:(NSInteger)position{
    if(layerView == _layerView){
        [_reProfitView setContent:result];
        _mViewModel.addProductModel.repeatRatio = (int)position * 5;
        [self updateConfig];
    }else if(layerView == _typeLayerView){
        CategoryModel *model = [_mViewModel.categoryDatas objectAtIndex:position];
        _mViewModel.addProductModel.goodsClassId = model.categoryId;
        [_typeView setContent:result];
    }
    [self checkButtonStatu];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resignAll];
}

-(void)resignAll{
    [_nameView resign];
    [_priceView resign];
    [_firstProfitView resign];
    [_descriptTv resignFirstResponder];
}

-(void)checkButtonStatu{
    if(IS_NS_STRING_EMPTY([_nameView getContent])){ [_commitBtn setActive:NO]; return;}
    if(IS_NS_STRING_EMPTY([_typeView getContent])){ [_commitBtn setActive:NO]; return;}
    if(IS_NS_STRING_EMPTY([_priceView getContent])){ [_commitBtn setActive:NO]; return;}
    if(IS_NS_COLLECTION_EMPTY(_mViewModel.photosImgDatas)) { [_commitBtn setActive:NO]; return;}
    if(IS_NS_COLLECTION_EMPTY(_mViewModel.detailImgDatas)) { [_commitBtn setActive:NO]; return;}
    if(IS_NS_STRING_EMPTY([_firstProfitView getContent])){ [_commitBtn setActive:NO]; return;}
    if(IS_NS_STRING_EMPTY([_reProfitView getContent])){ [_commitBtn setActive:NO]; return;}
    if(IS_NS_STRING_EMPTY(_descriptTv.text)){ [_commitBtn setActive:NO]; return;}
    [_commitBtn setActive:YES];
}

-(void)onDefaultBtnClick{
    _mViewModel.addProductModel.spuName = [_nameView getContent];
    _mViewModel.addProductModel.sellPrice = [[_priceView getContent] doubleValue] * 100;
    _mViewModel.addProductModel.spuRemark = _descriptTv.text;
    
    NSMutableArray *picDatas = [[NSMutableArray alloc]init];
    for(PreviewModel *model in _mViewModel.photosImgDatas){
        [picDatas addObject:model.imgSrc];
    }
    _mViewModel.addProductModel.picUrlList = picDatas;
    
    NSMutableArray *detailDatas = [[NSMutableArray alloc]init];
    for(PreviewModel *model in _mViewModel.detailImgDatas){
        [detailDatas addObject:model.imgSrc];
    }
    _mViewModel.addProductModel.goodsDetailList = detailDatas;
    [_mViewModel commitProduct];
}

@end

