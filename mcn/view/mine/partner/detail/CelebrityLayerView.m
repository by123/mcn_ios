//
//  CelebrityLayerView.m
//  mcn
//
//  Created by by.huang on 2020/9/8.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "CelebrityLayerView.h"
#import "CelebrityLayerViewCell.h"
@interface CelebrityLayerView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)NSMutableArray *datas;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIView *cardView;

@end
@implementation CelebrityLayerView


-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = [cblack colorWithAlphaComponent:0.6f];
    
    _cardView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(50), ScreenWidth, ScreenHeight - STHeight(50))];
    _cardView.backgroundColor = cwhite;
    CAShapeLayer *cardLayer = [[CAShapeLayer alloc] init];
    cardLayer.frame = _cardView.bounds;
    cardLayer.path = [UIBezierPath bezierPathWithRoundedRect:_cardView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)].CGPath;
    _cardView.layer.mask = cardLayer;
    [self addSubview:_cardView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:@"合作主播" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(20), titleSize.width, STHeight(25));
    [_cardView addSubview:titleLabel];
    
    [self initTableView];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    closeBtn.frame = CGRectMake(ScreenWidth - STWidth(15) - STHeight(24), STHeight(20), STHeight(24), STHeight(24));
    [closeBtn setImage:[UIImage imageNamed:IMAGE_LAYER_CLOSE] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(onCloseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_cardView addSubview:closeBtn];
    
}



/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(45), ScreenWidth, ScreenHeight - STHeight(95))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView useDefaultProperty];
    [_cardView addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_datas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(140);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CelebrityLayerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CelebrityLayerViewCell identify]];
    if(!cell){
        cell = [[CelebrityLayerViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CelebrityLayerViewCell identify]];
    }
    cell.linkCopyBtn.tag = indexPath.row;
    [cell.linkCopyBtn addTarget:self action:@selector(onLinkCopyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_datas)){
        [cell updateData:[_datas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)onLinkCopyBtnClick:(id)sender{
    NSInteger tag = ((UIButton *) sender).tag;
    ProductCelebrityModel *model =  [_datas objectAtIndex:tag];
    if(IS_NS_STRING_EMPTY(model.goodsLink)){
        [STShowToast show:@"导购链接不存在!"];
    }else{
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = model.goodsLink;
        [STShowToast show:@"导购链接复制成功!"];
    }
}

-(void)updateView{
    [_tableView reloadData];
}

/********************** tableview ****************************/



-(void)updateDatas:(NSMutableArray *)datas{
    _datas = datas;
    [_tableView reloadData];
}

-(void)onCloseBtnClick{
    if(_delegate){
        [_delegate onCelebrityLayerCloseBtnClick];
    }
}

@end
