

#import "PartnerItemViewCell.h"
#import "PartnerProductViewCell.h"

@interface PartnerItemViewCell()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UIView *cardView;
@property(strong, nonatomic)UILabel *cooperationIdLabel;
@property(strong, nonatomic)UILabel *statuLabel;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSMutableArray *skuModels;
@property(strong, nonatomic)PartnerViewModel *vm;


@end

@implementation PartnerItemViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    _cardView = [[UIView alloc]init];
    _cardView.backgroundColor = cwhite;
    _cardView.layer.cornerRadius = 4;
    _cardView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _cardView.layer.shadowOffset = CGSizeMake(0,2);
    _cardView.layer.shadowOpacity = 1;
    _cardView.layer.shadowRadius = 10;
    [self.contentView addSubview:_cardView];
    
    _cooperationIdLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [_cardView addSubview:_cooperationIdLabel];
    
    _statuLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    [_cardView addSubview:_statuLabel];
    
    _merchantBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STHeight(40), ScreenWidth, STHeight(60))];
    [_cardView addSubview:_merchantBtn];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(16), STHeight(25), STHeight(25))];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(12.5);
    [_merchantBtn addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    [_merchantBtn addSubview:_nameLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(330) - STHeight(14), STHeight(18), STHeight(14), STHeight(14))];
    arrowImageView.image = [UIImage imageNamed:IMAGE_ARROW_RIGHT_GREY];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_merchantBtn addSubview:arrowImageView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(100) - LineHeight, STWidth(345), LineHeight)];
    lineView.backgroundColor = cline;
    [_cardView addSubview:lineView];
    
    [self initTableView];
}

-(void)updateData:(PartnerModel *)model vm:(PartnerViewModel *)vm{
    _vm = vm;
    _skuModels = model.skuModels;
    _cardView.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(100) + STHeight(125) * _skuModels.count);
    
    _cooperationIdLabel.text = model.cooperationId;
    CGSize cooperationIdSize = [_cooperationIdLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _cooperationIdLabel.frame = CGRectMake(STWidth(15), STHeight(20), cooperationIdSize.width, STHeight(21));

    _statuLabel.text = [PartnerModel getStatuStr:model.projectState];
    CGSize statuSize = [_statuLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _statuLabel.frame = CGRectMake(STWidth(330) - statuSize.width, STHeight(15), statuSize.width, STHeight(21));
    
    if(!IS_NS_STRING_EMPTY(model.avatar)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
    
    _nameLabel.text = model.supplierName;
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _nameLabel.frame = CGRectMake(STWidth(50), STHeight(18), STWidth(245), STHeight(21));
    
    _tableView.frame = CGRectMake(0, STHeight(100), STWidth(345), STHeight(125) * _skuModels.count);
    [_tableView reloadData];
}



/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    return STHeight(125);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PartnerProductViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PartnerProductViewCell identify]];
    if(!cell){
        cell = [[PartnerProductViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PartnerProductViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_skuModels)){
        [cell updateData:[_skuModels objectAtIndex:indexPath.row]];
    }
    return cell;
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ProductModel *model = [_skuModels objectAtIndex:indexPath.row];
//    [_vm goProductDetailPage:model.skuId];
//}


-(void)updateView{
    [_tableView reloadData];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return self;
}
/********************** tableview ****************************/


+(NSString *)identify{
    return NSStringFromClass([PartnerItemViewCell class]);
}

@end

