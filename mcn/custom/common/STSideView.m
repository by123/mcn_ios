//
//  STSideView.m
//  cigarette
//
//  Created by by.huang on 2019/12/20.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "STSideView.h"
#import "STSideViewCell.h"

@interface STSideView()<UITableViewDelegate,UITableViewDataSource>

@property(copy, nonatomic)NSString *title;
@property(strong, nonatomic)UIView *contentView;
@property(strong, nonatomic)UILabel *titleLabel;
//@property(strong, nonatomic)UIButton *resetBtn;
@property(strong, nonatomic)UIButton *confirmBtn;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSMutableArray *datas;
@property(assign, nonatomic)NSInteger position;

@end

@implementation STSideView

-(instancetype)initWithTitle:(NSString *)title{
    if(self == [super init]){
        _title = title;
        _datas = [[NSMutableArray alloc]init];
        [self initView];
    }
    return self;
}

-(void)initView{
    self.hidden = YES;
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = [STColorUtil colorWithHexString:@"#181920" alpha:0.7];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, STWidth(60), ScreenHeight)];
    [self addSubview:leftView];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)];
    [leftView addGestureRecognizer:recognizer];
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, STWidth(315), ScreenHeight)];
    _contentView.backgroundColor = cwhite;
    [self addSubview:_contentView];
    
    _titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:_title textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _titleLabel.frame = CGRectMake(STWidth(20), STHeight(40), titleSize.width, STHeight(25));
    [_contentView addSubview:_titleLabel];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - STHeight(80) , STWidth(315), STHeight(80) )];
    bottomView.backgroundColor = cwhite;
    bottomView.layer.shadowOffset = CGSizeMake(0, 0);
    bottomView.layer.shadowOpacity = 0.2;
    bottomView.layer.shadowRadius = 2;
    bottomView.layer.shadowColor = c10.CGColor;
    [_contentView addSubview:bottomView];
    
//    _resetBtn = [[UIButton alloc]initWithFont:STFont(16) text:@"重置" textColor:c10 backgroundColor:nil corner:4 borderWidth:LineHeight borderColor:c10];
//    _resetBtn.frame = CGRectMake(STWidth(47), ScreenHeight - STHeight(60) - HomeIndicatorHeight, STWidth(103), STHeight(40));
//    [_resetBtn addTarget:self action:@selector(onResetBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_contentView addSubview:_resetBtn];
    
    _confirmBtn = [[UIButton alloc]initWithFont:STFont(16) text:@"确定" textColor:cwhite backgroundColor:c10 corner:4 borderWidth:0 borderColor:nil];
    _confirmBtn.frame = CGRectMake(STWidth(25), STHeight(15), STWidth(265), STHeight(50));
    [_confirmBtn addTarget:self action:@selector(onConfirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_confirmBtn];
    
    [self initTableView];
    
}


/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(80), ScreenWidth, ScreenHeight - STHeight(80) - STHeight(90))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView useDefaultProperty];
    
//    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNew)];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    _tableView.mj_header = header;
//
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(uploadMore)];
//    _tableView.mj_footer = footer;
    
    [_contentView addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(60);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    STSideViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[STSideViewCell identify]];
    if(!cell){
        cell = [[STSideViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[STSideViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_datas)){
        [cell updateData:[_datas objectAtIndex:indexPath.row]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _position = indexPath.row;
    if(_position == 0){
         if(!IS_NS_COLLECTION_EMPTY(_datas)){
               [_datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   ((TitleContentModel *)obj).isSelect = YES;
               }];
           }
     }else{
         if(!IS_NS_COLLECTION_EMPTY(_datas)){
             [_datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 ((TitleContentModel *)obj).isSelect = NO;
             }];
         }
         TitleContentModel *model = [_datas objectAtIndex:_position];
         model.isSelect = YES;
     }
     [self updateView];
}


-(void)updateView{
    [_tableView reloadData];
}


//-(void)refreshNew{
//    [_tableView.mj_header endRefreshing];
//
//}
//
//-(void)uploadMore{
//    [_tableView.mj_footer endRefreshingWithNoMoreData];
//}

/********************** tableview ****************************/


//-(void)onResetBtnClick{
//    if(!IS_NS_COLLECTION_EMPTY(_datas)){
//           [_datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//               ((TitleContentModel *)obj).isSelect = NO;
//           }];
//       }
//    [self updateView];
//}

-(void)onConfirmBtnClick{
    if(_delegate){
        [_delegate onSideViewSelect:_position];
        [self hidden];
    }
}

-(void)setDatas:(NSMutableArray *)datas{
    _datas = datas;
    [self updateView];
}


-(void)show{
    self.hidden = NO;
    WS(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.contentView.frame = CGRectMake(STWidth(60), 0, STWidth(315), ScreenHeight);
    }];
}

-(void)hidden{
    WS(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.contentView.frame = CGRectMake(ScreenWidth, 0, STWidth(315), ScreenHeight);
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}
@end
