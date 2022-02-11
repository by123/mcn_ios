//
//  STCityPickerLayerView.m
//  cigarette
//
//  Created by by.huang on 2020/6/22.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "STCityPickerLayerView.h"
#import "UIPickerView+SelectView.h"
#import "CitySelectModel.h"
#import "STTimeUtil.h"
#import "STConvertUtil.h"
#import "STFileUtil.h"

@interface STCityPickerLayerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong, nonatomic)UIPickerView *provincePickerView;
@property(strong, nonatomic)UIPickerView *cityPickerView;
@property(strong, nonatomic)UIButton *confirmBtn;
@property(strong, nonatomic)UILabel *mainLabel;
@property(strong, nonatomic)NSMutableArray *mProvices;
@property(strong, nonatomic)NSMutableArray *mCitys;
@property(strong, nonatomic)UIView *dialogView;

@end

@implementation STCityPickerLayerView{
    NSInteger provincePosition;
    NSInteger cityPosition;
    NSInteger areaPosition;
    
}

-(instancetype)init{
    if(self == [super init]){
        _mProvices = [[NSMutableArray alloc]init];
        _mCitys = [[NSMutableArray alloc]init];
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self initView];
    }
    return self;
}

-(void)getAddressList{
    NSString *result = [STFileUtil loadFile:@"address.json"];
    [self updateView:result];
}



-(void)initView{
    
    self.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [self addGestureRecognizer:recognizer];
    
    
    _dialogView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - STHeight(400), ScreenWidth, STHeight(400))];
    _dialogView.backgroundColor = cwhite;
    
    CAShapeLayer *bodyLayer = [[CAShapeLayer alloc] init];
    bodyLayer.frame = _dialogView.bounds;
    bodyLayer.path = [UIBezierPath bezierPathWithRoundedRect:_dialogView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(STWidth(30), STWidth(30))].CGPath;
    _dialogView.layer.mask = bodyLayer;
    
    
    [self addSubview:_dialogView];
    
    [self getAddressList];
    
    
}


-(void)updateView:(NSString *)result{
    
    [STLog print:[NSString stringWithFormat:@"开始:%@",[STTimeUtil getCurrentTimeStamp]]];
    NSMutableArray *array = (NSMutableArray *)[STConvertUtil jsonToDic:result];
    if(!IS_NS_COLLECTION_EMPTY(array)){
        for(id item in array){
            CitySelectModel *model = [CitySelectModel mj_objectWithKeyValues:item];
            [_mProvices addObject:model];
        }
    }
    
    if(!IS_NS_COLLECTION_EMPTY(_mProvices)){
        CitySelectModel *model = [_mProvices objectAtIndex:0];
        if(!IS_NS_COLLECTION_EMPTY(model.children)){
            NSMutableArray *array = [CitySelectModel mj_objectArrayWithKeyValuesArray:model.children];
            for(id item in array){
                CitySelectModel *model = [CitySelectModel mj_objectWithKeyValues:item];
                [_mCitys addObject:model];
            }
        }
    }
    
    
    [_dialogView addSubview:[self provincePickerView]];
    [_dialogView addSubview:[self cityPickerView]];
    
    [_dialogView addSubview:[self mainLabel]];
    [_dialogView addSubview:[self confirmBtn]];
}


-(UIPickerView *)provincePickerView{
    if(_provincePickerView == nil){
        _provincePickerView = [[UIPickerView alloc]initWithDatas:_mProvices];
        _provincePickerView.frame = CGRectMake(0, 0, ScreenWidth/2, STHeight(400));
        _provincePickerView.showsSelectionIndicator = YES;
        _provincePickerView.backgroundColor = cwhite;
        _provincePickerView.delegate = self;
        _provincePickerView.dataSource = self;
    }
    return _provincePickerView;
}


-(UIPickerView *)cityPickerView{
    if(_cityPickerView == nil){
        _cityPickerView = [[UIPickerView alloc]initWithDatas:_mCitys];
        _cityPickerView.frame = CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, STHeight(400));
        _cityPickerView.showsSelectionIndicator = YES;
        _cityPickerView.backgroundColor = cwhite;
        _cityPickerView.delegate = self;
        _cityPickerView.dataSource = self;
    }
    return _cityPickerView;
}


-(UILabel *)mainLabel{
    if(_mainLabel == nil){
        _mainLabel = [[UILabel alloc]initWithFont:STFont(20) text:@"请选择" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
        _mainLabel.frame = CGRectMake(0, STHeight(20), ScreenWidth, STHeight(28));
        [_mainLabel setFont:[UIFont fontWithName:FONT_MIDDLE size:STFont(20)]];
    }
    return _mainLabel;
}


-(UIButton *)confirmBtn{
    if(_confirmBtn == nil){
        _confirmBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_CONFIRM textColor:c11 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
        _confirmBtn.frame = CGRectMake(ScreenWidth - STWidth(70), 0, STWidth(70), STWidth(70));
        [_confirmBtn addTarget:self action:@selector(OnClickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _confirmBtn;
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return STHeight(60);
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *selectLabel = [[UILabel alloc]init];
    selectLabel.textColor = c11;
    selectLabel.textAlignment = NSTextAlignmentCenter;
    selectLabel.font = [UIFont systemFontOfSize:STFont(16)];
    if(pickerView == _provincePickerView){
        CitySelectModel *model = [_mProvices objectAtIndex:row];
        selectLabel.text = model.label;
        if(provincePosition == row){
            selectLabel.textColor = c01;
            selectLabel.font = [UIFont fontWithName:FONT_MIDDLE size:STFont(18)];
        }
    }else if(pickerView == _cityPickerView){
        CitySelectModel *model = [_mCitys objectAtIndex:row];
        selectLabel.text = model.label;
        if(cityPosition == row){
            selectLabel.textColor = c01;
            selectLabel.font = [UIFont fontWithName:FONT_MIDDLE size:STFont(18)];
        }
    }
    
    return selectLabel;
    
}




-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView == _provincePickerView){
        return [_mProvices count];
    }
    return [_mCitys count];
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(IS_NS_COLLECTION_EMPTY(_mProvices) || IS_NS_COLLECTION_EMPTY(_mCitys)){
        return MSG_EMPTY;
    }
    if(pickerView == _provincePickerView){
        CitySelectModel *model = [_mProvices objectAtIndex:row];
        return model.label;
    }
    else{
        CitySelectModel *model = [_mCitys objectAtIndex:row];
        return model.label;
    }
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView == _provincePickerView){
        provincePosition = row;
        [self updateCitys:provincePosition];
    }else if(pickerView == _cityPickerView){
        cityPosition = row;
    }
    [pickerView reloadComponent:component];
}

-(void)updateCitys:(NSInteger)provincePosition{
    [_mCitys removeAllObjects];
    if(!IS_NS_COLLECTION_EMPTY(_mProvices)){
        CitySelectModel *model = [_mProvices objectAtIndex:provincePosition];
        if(!IS_NS_COLLECTION_EMPTY(model.children)){
            NSMutableArray *array = [CitySelectModel mj_objectArrayWithKeyValuesArray:model.children];
            for(id item in array){
                CitySelectModel *model = [CitySelectModel mj_objectWithKeyValues:item];
                [_mCitys addObject:model];
            }
        }
    }
    cityPosition = 0;
    [_cityPickerView reloadAllComponents];
    [_cityPickerView selectRow:cityPosition inComponent:0 animated:YES];
}


-(void)OnClickLayerView{
    self.hidden = YES;
}


-(void)OnClickConfirmBtn{
    self.hidden = YES;
    CitySelectModel *provinceModel = [_mProvices objectAtIndex:provincePosition];
    NSString *provinceStr = provinceModel.label;
    CitySelectModel *cityModel = [_mCitys objectAtIndex:cityPosition];
    NSString *cityStr = cityModel.label;
    if(_delegate){
        [_delegate onSelectResult:self province:provinceStr city:cityStr];
    }
}


-(CitySelectModel *)getCurrentModel{
    CitySelectModel *model = [[CitySelectModel alloc]init];
    CitySelectModel *provinceModel = [_mProvices objectAtIndex:provincePosition];
    NSString *provinceStr = provinceModel.label;
    CitySelectModel *cityModel = [_mCitys objectAtIndex:cityPosition];
    NSString *cityStr = cityModel.label;
    model.label = [NSString stringWithFormat:@"%@%@",provinceStr,cityStr];
    return model;
}



@end
