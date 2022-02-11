//
//  BankView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "BankView.h"
#import "BankViewCell.h"

@interface BankView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)BankViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation BankView

-(instancetype)initWithViewModel:(BankViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initTableView];
    [self initBottomView];
}

-(void)initBottomView{
    
    CGFloat homeHeight = 0;
      if (@available(iOS 11.0, *)) {
          homeHeight = HomeIndicatorHeight;
      } else {
          homeHeight = 0;
      }
      
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0,ContentHeight - STHeight(80)-homeHeight,ScreenWidth,STHeight(80)+homeHeight);
    bottomView.backgroundColor = cwhite;
    bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    bottomView.layer.shadowOffset = CGSizeMake(0,2);
    bottomView.layer.shadowOpacity = 1;
    bottomView.layer.shadowRadius = 10;
    [self addSubview:bottomView];
    
    UIButton *addBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"添加收款账户" textColor:c20 backgroundColor:nil corner:4 borderWidth:LineHeight borderColor:c20];
    addBtn.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(50));
    [addBtn addTarget:self action:@selector(onAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addBtn];
}

/********************** tableview ****************************/
-(void)initTableView{
    CGFloat homeHeight = 0;
      if (@available(iOS 11.0, *)) {
          homeHeight = HomeIndicatorHeight;
      } else {
          homeHeight = 0;
      }
      
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(80)-homeHeight)];
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
    return STHeight(130);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BankViewCell identify]];
    if(!cell){
        cell = [[BankViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[BankViewCell identify]];
    }
    cell.delBtn.tag = indexPath.row;
    [cell.delBtn addTarget:self action:@selector(onDelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        [cell updateData:[_mViewModel.datas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_mViewModel.isSelect){
        BankModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
        [_mViewModel selectModel:model];
    }
}


-(void)updateView{
    [_tableView reloadData];
}



/********************** tableview ****************************/


-(void)onDelBtnClick:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    BankModel *model = [_mViewModel.datas objectAtIndex:tag];
    [_mViewModel delBankCard:model.bid];
}

-(void)onAddBtnClick{
    [_mViewModel goBankSelectPage];
}
@end

