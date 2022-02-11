//
//  StatisticsItemView.m
//  mcn
//
//  Created by by.huang on 2020/9/11.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "StatisticsItemView.h"
#import "StatisticsItemViewModel.h"
#import "StatisticsCooperateCell.h"
#import "StatisticsProductCell.h"
#import "StatisticsChannelCell.h"
#import "StatisticsCelebrityCell.h"

@interface StatisticsItemView()<StatisticsItemViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)StatisticsItemViewModel *mViewModel;
@property(strong, nonatomic)UILabel *totalLabel;
@property(strong, nonatomic)UILabel *natureTotalLabel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)StaticticsViewModel *vm;

@end

@implementation StatisticsItemView

-(instancetype)initWithType:(StaticticsItemType)type statisticsType:(StaticticsType)statisticsType startTime:(NSString *)startTime endTime:(NSString *)endTime vm:(StaticticsViewModel *)vm{
    if(self == [super init]){
        _vm = vm;
        _mViewModel = [[StatisticsItemViewModel alloc]init];
        _mViewModel.statisticsType = statisticsType;
        _mViewModel.type = type;
        _mViewModel.startTime = startTime;
        _mViewModel.endTime = endTime;
        _mViewModel.delegate = self;
        [self initView];
        [self refreshData:type];
    }
    return self;
}


-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(82));
    
    _totalLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c45 backgroundColor:nil multiLine:NO];
    [self addSubview:_totalLabel];
    
    _natureTotalLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c45 backgroundColor:nil multiLine:NO];
    [self addSubview:_natureTotalLabel];
    
    NSArray *titles = @[@"总计(元)"];
    if(_mViewModel.type == StaticticsItemType_Channel){
        titles = @[@"合作总计(元)",@"自然总计(元)"];
        _natureTotalLabel.hidden = NO;
    }else{
        _natureTotalLabel.hidden = YES;
    }
    for(int i = 0; i < titles.count; i ++){
        UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:titles[i] textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
        CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
        titleLabel.frame = CGRectMake(STWidth(15)+ i * STWidth(108), STHeight(15), titleSize.width, STHeight(21));
        [self addSubview:titleLabel];
    }
    
    [self initTableView];
}


/********************** tableview ****************************/
-(void)initTableView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(77), ScreenWidth, STHeight(15))];
    view.backgroundColor = cbg2;
    [self addSubview:view];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(92), ScreenWidth, ContentHeight - STHeight(175))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = cbg2;
    [_tableView useDefaultProperty];
    
    [self addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_mViewModel.type == StaticticsItemType_Cooperate){
        return [self getCooperateTableViewHeight:indexPath.row];
    }else if(_mViewModel.type == StaticticsItemType_Channel){
        return [self getChannelTableViewHeight:indexPath.row];
    }
    return STHeight(60);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_mViewModel.type == StaticticsItemType_Cooperate){
        StatisticsCooperateCell *cell = [tableView dequeueReusableCellWithIdentifier:[StatisticsCooperateCell identify]];
        if(!cell){
            cell = [[StatisticsCooperateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[StatisticsCooperateCell identify]];
        }
        cell.mchBtn.tag = indexPath.row;
        [cell.mchBtn addTarget:self action:@selector(onMchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
            [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row]];
        }
        return cell;
    }else if(_mViewModel.type == StaticticsItemType_Product){
        StatisticsProductCell *cell = [tableView dequeueReusableCellWithIdentifier:[StatisticsProductCell identify]];
        if(!cell){
            cell = [[StatisticsProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[StatisticsProductCell identify]];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
            [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row] hiddenLine:_mViewModel.datas.count - 1 == indexPath.row];
        }
        return cell;
    }else if(_mViewModel.type == StaticticsItemType_Celebrity){
        StatisticsCelebrityCell *cell = [tableView dequeueReusableCellWithIdentifier:[StatisticsCelebrityCell identify]];
        if(!cell){
            cell = [[StatisticsCelebrityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[StatisticsCelebrityCell identify]];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
            [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row] hiddenLine:_mViewModel.datas.count - 1 == indexPath.row];
        }
        return cell;
    }else{
        StatisticsChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:[StatisticsChannelCell identify]];
        if(!cell){
            cell = [[StatisticsChannelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[StatisticsChannelCell identify]];
        }
        cell.mchBtn.tag = indexPath.row;
        [cell.mchBtn addTarget:self action:@selector(onMchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
            [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row]];
        }
        return cell;
    }
}



/********************** tableview ****************************/



-(void)updateView{
    
    _totalLabel.text = [NSString stringWithFormat:@"%.2f",_mViewModel.total / 100];
    CGSize totalSize = [_totalLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _totalLabel.frame = CGRectMake(STWidth(15), STHeight(36), totalSize.width, STHeight(21));
    
    if(_mViewModel.type  == StaticticsItemType_Channel){
        _natureTotalLabel.text = [NSString stringWithFormat:@"%.2f",_mViewModel.natureIncome];
        CGSize natureTotalSize = [_natureTotalLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
        _natureTotalLabel.frame = CGRectMake(STWidth(123), STHeight(36), natureTotalSize.width, STHeight(21));
    }
    [_tableView reloadData];
}

-(void)onRequestBegin{}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if([respondModel.requestUrl isEqualToString:URL_STATISTICS_COOPRETA]){
        [self updateView];
    }else if([respondModel.requestUrl isEqualToString:URL_STATISTICS_PRODUCT]){
        [self updateView];
    }else if([respondModel.requestUrl isEqualToString:URL_STATISTICS_CELEBRITY]){
        [self updateView];
    }
}

-(void)onRequestFail:(NSString *)msg{}



-(CGFloat)getCooperateTableViewHeight:(NSInteger)position{
    if(IS_NS_COLLECTION_EMPTY(_mViewModel.datas)) return 0;
    CGFloat height = 0;
    StatisticsCooperateModel *model = _mViewModel.datas[position];
    height += STHeight(60);
    if(!IS_NS_COLLECTION_EMPTY(model.skuDatas)){
        for(CooperateSkuModel *skuModel in model.skuDatas){
            height += STHeight(61);
            if(!IS_NS_COLLECTION_EMPTY(skuModel.celebrityDatas)){
                height += STHeight(40) * skuModel.celebrityDatas.count;
            }
        }
    }
    
    return height;
}

-(CGFloat)getChannelTableViewHeight:(NSInteger)position{
    if(IS_NS_COLLECTION_EMPTY(_mViewModel.datas)) return 0;
    CGFloat height = 0;
    StatisticsCooperateModel *model =  _mViewModel.datas[position];
    height += STHeight(60);
    if(!IS_NS_COLLECTION_EMPTY(model.skuDatas)){
        height += STHeight(40) + model.skuDatas.count * STHeight(21) + (model.skuDatas.count - 1) * STHeight(15);
    }
    return height;
}

-(void)refreshData:(StaticticsItemType)type{
    if(type == StaticticsItemType_Cooperate || type == StaticticsItemType_Channel){
        [_mViewModel requestCooperateList];
    }else if(type == StaticticsItemType_Product){
        [_mViewModel requestProductList];
    }else if(type == StaticticsItemType_Celebrity){
        [_mViewModel requestCelebrityList];
    }
}

-(void)updateTime:(NSString *)startTime endTime:(NSString *)endTime{
    _mViewModel.startTime = startTime;
    _mViewModel.endTime = endTime;
}

-(void)onMchBtnClicked:(id)sender{
    UIButton *button = (UIButton *)sender;
    NSInteger position = button.tag;
    StatisticsCooperateModel *model =  _mViewModel.datas[position];
    [_vm goPartnerDetailPage:model.cooperationId];
}
@end
