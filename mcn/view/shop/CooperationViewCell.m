

#import "CooperationViewCell.h"
#import "CooperationItemViewCell.h"
#import "AccountManager.h"

@interface CooperationViewCell()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UIView *cardView;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSMutableArray *skuModels;
@property(strong, nonatomic)UIView *lineView;
@property(assign, nonatomic)NSInteger posistion;
@property(strong, nonatomic)CooperationViewModel *vm;

@end

@implementation CooperationViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    _cardView = [[UIView alloc]init];
    _cardView.backgroundColor = cwhite;
    [self.contentView addSubview:_cardView];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(20), STHeight(25), STHeight(25))];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(12.5);
    [_cardView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    [_cardView addSubview:_nameLabel];
    
    _expandBtn = [[UIButton alloc]init];
    [_expandBtn setImage:[UIImage imageNamed:IMAGE_EXPAND] forState:UIControlStateNormal];
    _expandBtn.frame = CGRectMake( ScreenWidth - STWidth(15) - STHeight(25), STHeight(20), STHeight(25), STHeight(25));
    [_cardView addSubview:_expandBtn];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(65) - LineHeight, STWidth(345), LineHeight)];
    _lineView.backgroundColor = cline;
    [_cardView addSubview:_lineView];
    
    [self initTableView];
    
}

-(void)updateData:(ShopModel *)model position:(NSInteger)position vm:(CooperationViewModel *)vm{
    _vm = vm;
    ShopModel *shopModel = [_vm.datas objectAtIndex:0];
    [STLog print:@"updateData vm数量" content:LongStr(shopModel.skuModels.count)];
    _posistion = position;
    _skuModels = model.skuModels;
    
    if(!IS_NS_STRING_EMPTY(model.avatar)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
    _nameLabel.text = model.supplierName;
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _nameLabel.frame = CGRectMake(STWidth(25) + STHeight(25), 0, STWidth(240), STHeight(65));
    
    [_expandBtn setImage:[UIImage imageNamed:model.isExpand ? IMAGE_EXPAND : IMAGE_NARROW] forState:UIControlStateNormal];
    
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    CGFloat listHeight = model.isExpand ? 0 : (_skuModels.count * (userModel.roleType == RoleType_Celebrity ? STHeight(130) : STHeight(170)));
    _lineView.hidden = model.isExpand;
    
    _cardView.frame = CGRectMake(0, STHeight(15), ScreenWidth, STHeight(65) + listHeight);
    
    _tableView.frame = CGRectMake(0, STHeight(65), ScreenWidth, listHeight);
    [_tableView reloadData];
    
}




/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(65), ScreenWidth, 0)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = cwhite;
    _tableView.scrollEnabled = NO;
    [_tableView useDefaultProperty];
    [_cardView addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_skuModels count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    ShopModel *model = [_vm.datas objectAtIndex:_posistion];
    return model.isExpand ? 0 : (userModel.roleType == RoleType_Celebrity ? STHeight(130) : STHeight(170));
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CooperationItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CooperationItemViewCell identify]];
    if(!cell){
        cell = [[CooperationItemViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CooperationItemViewCell identify]];
    }
    cell.selectBtn.tag = indexPath.row;
    [cell.selectBtn addTarget:self action:@selector(onSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_skuModels)){
        [cell updateData:[_skuModels objectAtIndex:indexPath.row] hiddenLine:indexPath.row == _skuModels.count - 1];
    }
    return cell;
}

-(void)onSelectBtn:(id)sender{
    NSInteger tag = ((UIButton *)sender).tag;
    CelebrityParamModel *model = [[CelebrityParamModel alloc]init];
    model.position1 = _posistion;
    model.position2 = tag;
    ShopModel *shopMoel = [_vm.datas objectAtIndex:model.position1];
    ShopSkuModel *skuModel = [shopMoel.skuModels objectAtIndex:model.position2];
    model.datas = skuModel.celebrityDatas;
    model.allDatas = _vm.datas;
    [STLog print:@"第一层" content:LongStr(_posistion)];
    [STLog print:@"第一层" content:LongStr(tag)];
    [STLog print:@"商品数量" content:LongStr(shopMoel.skuModels.count)];
//    [STLog print:@"数据" content:[STConvertUtil dicToJson:model.datas]];
    [_vm goSelectCelebrityPage:model];
    
}

/********************** tableview ****************************/

+(NSString *)identify{
    return NSStringFromClass([CooperationViewCell class]);
}

@end

