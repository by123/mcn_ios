

#import "ShopViewCell.h"
#import "ShopItemViewCell.h"
#import "STDialog.h"
@interface ShopViewCell()<UITableViewDelegate,UITableViewDataSource,STDialogDelegate>

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)ShopModel *shopModel;
@property(strong, nonatomic)ShopViewModel *shopVM;
@property(assign, nonatomic)NSInteger position;
@property(strong, nonatomic)STDialog *dialog;
@property(strong, nonatomic)ShopSkuModel *delSkuModel;

@end

@implementation ShopViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    _cardView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), 0, STWidth(345), 0)];
    _cardView.backgroundColor = cwhite;
    _cardView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _cardView.layer.shadowOffset = CGSizeMake(0,2);
    _cardView.layer.shadowOpacity = 1;
    _cardView.layer.shadowRadius = 4;
    _cardView.layer.cornerRadius = 4;
    [self.contentView addSubview:_cardView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, STWidth(345), STHeight(60))];
    [_cardView addSubview:topView];
    
    _allSelectBtn = [[UIButton alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(25), STHeight(15), STHeight(15))];
    [_allSelectBtn setImage:[UIImage imageNamed:IMAGE_NO_SELECT] forState:UIControlStateNormal];
    [topView addSubview:_allSelectBtn];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(45), STHeight(20), STHeight(25), STHeight(25))];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(12.5);
    [topView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    [topView addSubview:_nameLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(60) - LineHeight, STWidth(345), LineHeight)];
    lineView.backgroundColor = cline;
    [topView addSubview:lineView];
    
    _detailBtn = [[UIButton alloc]init];
    _detailBtn.frame = CGRectMake(STWidth(345) - STWidth(11) - STHeight(20), STHeight(23), STHeight(20), STHeight(20));
    [_detailBtn setImage:[UIImage imageNamed:IMAGE_LIGHT_NEXT] forState:UIControlStateNormal];
    [topView addSubview:_detailBtn];
    
    [self initTableView];
}

-(void)updateData:(ShopViewModel *)shopVM position:(NSInteger)position{
    _shopVM = shopVM;
    _position = position;
    _shopModel = [_shopVM.datas objectAtIndex:position];
    if(!IS_NS_STRING_EMPTY(_shopModel.avatar)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_shopModel.avatar]];
    }
    
    _nameLabel.text = _shopModel.supplierName;
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _nameLabel.frame = CGRectMake(STWidth(80), STHeight(22), STWidth(210), STHeight(21));
    
    [_allSelectBtn setImage:[UIImage imageNamed:_shopModel.isAllSelect ? IMAGE_SELECT : IMAGE_NO_SELECT] forState:UIControlStateNormal];

    [self updateView];
}


/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(60), STWidth(345), 0)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.layer.masksToBounds = YES;
    _tableView.layer.cornerRadius = 4;
    [_tableView useDefaultProperty];
    
    [_cardView addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _shopModel.skuModels.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(136);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShopItemViewCell identify]];
    if(!cell){
        cell = [[ShopItemViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ShopItemViewCell identify]];
    }
    cell.shopItemView.tag = indexPath.row;
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onShopItemViewClick:)];
    recongnizer.numberOfTouchesRequired = 1;
    [cell.shopItemView addGestureRecognizer:recongnizer];
    cell.delBtn.tag = indexPath.row;
    [cell.delBtn addTarget:self action:@selector(onDelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_shopModel.skuModels)){
        [cell updateData:[_shopModel.skuModels objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)updateView{
    _cardView.frame = CGRectMake(STWidth(15), 0, STWidth(345), STHeight(136) *  _shopModel.skuModels.count + STHeight(60));
    _tableView.frame = CGRectMake(0, STHeight(60), STWidth(345), STHeight(136) * _shopModel.skuModels.count);
    [_tableView reloadData];
}


/********************** tableview ****************************/


+(NSString *)identify{
    return NSStringFromClass([ShopViewCell class]);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

-(void)onDelBtnClick:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    _delSkuModel = [_shopModel.skuModels objectAtIndex:tag];
    [STLog print:@"要删除的商品" content:_delSkuModel.spuName];
    if(_dialog != nil){
        [STWindowUtil removeWindowView:_dialog];
    }
    _dialog = [[STDialog alloc]initWithTitle:@"删除商品" content:@"确认删除该条商品吗？" subContent:nil size:CGSizeMake(STWidth(315), STHeight(200))];
     _dialog.delegate = self;
     [_dialog showConfirmBtn:YES cancelBtn:YES];
     [_dialog setConfirmBtnStr:@"确认" cancelStr:@"取消"];
     [STWindowUtil addWindowView:_dialog];
}

-(void)onCancelBtnClicked:(id)dialog{
    _dialog.hidden = YES;
}

-(void)onConfirmBtnClicked:(id)dialog{
    [_shopVM deleteSKu:_delSkuModel.skuId];
    _dialog.hidden = YES;
}

-(void)onShopItemViewClick:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *recognizer = sender;
    UIView *view = (UIView *)recognizer.view;
    [STLog print:@"选择的商户" content:LongStr(_position)];
    [STLog print:@"选择的产品" content:LongStr(view.tag)];
    
    [_shopVM updateTableView:_position tag:view.tag];
}


@end

