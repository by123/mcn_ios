//
//  SelectCelebrityView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "SelectCelebrityView.h"
#import "SelectCelebrityViewCell.h"
#import "STDefaultBtnView.h"

@interface SelectCelebrityView()<UITableViewDelegate,UITableViewDataSource,STDefaultBtnViewDelegate>

@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)SelectCelebrityViewModel *mViewModel;
@property(strong, nonatomic)STDefaultBtnView *confirmBtn;

@end

@implementation SelectCelebrityView

-(instancetype)initWithViewModel:(SelectCelebrityViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initTableView];
    
    _confirmBtn = [[STDefaultBtnView alloc]initWithTitle:@"确定"];
    _confirmBtn.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
    _confirmBtn.delegate = self;
    [_confirmBtn setActive:YES];
    [self addSubview:_confirmBtn];
}


/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(80))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    return STHeight(80);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCelebrityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SelectCelebrityViewCell identify]];
    if(!cell){
        cell = [[SelectCelebrityViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SelectCelebrityViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row] hiddenLine:indexPath.row == _mViewModel.datas.count - 1];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CelebrityModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    model.isSelect = !model.isSelect;
    [self updateView];
}


-(void)updateView{
    [_tableView reloadData];
}


-(void)onDefaultBtnClick{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        for(CelebrityModel *model in _mViewModel.datas){
            if(model.isSelect){
                [datas addObject:model];
            }
        }
    }
    [_mViewModel backCooperationPage:datas];
}


@end

