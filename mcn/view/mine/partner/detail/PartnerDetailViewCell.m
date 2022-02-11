

#import "PartnerDetailViewCell.h"

@interface PartnerDetailViewCell()

@property(strong, nonatomic)UIImageView *showImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *priceLabel;
@property(strong, nonatomic)UILabel *sellLabel;
@property(strong, nonatomic)NSMutableArray *celebrityDatas;
@property(strong, nonatomic)UIView *lineView;
@property(strong, nonatomic)UIScrollView *celebrityView;

@end

@implementation PartnerDetailViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _celebrityDatas = [[NSMutableArray alloc]init];
        [self initView];
    }
    return self;
}


-(void)initView{
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(16), STHeight(20), STHeight(90), STHeight(90))];
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    _showImageView.layer.masksToBounds = YES;
    _showImageView.layer.cornerRadius = 4;
    [self.contentView addSubview:_showImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    [self.contentView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_priceLabel];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:@"合作主播" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(125), titleSize.width, STHeight(20));
    [self.contentView addSubview:titleLabel];
    
    _celebrityView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, STHeight(145), ScreenWidth, STHeight(45))];
    _celebrityView.showsVerticalScrollIndicator = NO;
    _celebrityView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_celebrityView];
    
    _lineView = [[UIView alloc]init];
    _lineView.frame = CGRectMake(STWidth(15), STHeight(200)-LineHeight, STWidth(345), LineHeight);
    _lineView.backgroundColor = cline;
    [self.contentView addSubview:_lineView];
    
}

-(void)updateData:(ProductModel *)model{
    
    _celebrityDatas = model.celebrityModels;

    if(!IS_NS_STRING_EMPTY(model.picUrl)){
        [_showImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    }
    
    _nameLabel.text = [NSString stringWithFormat:@"%@%@",model.spuName,[ProductModel getAttributeValue:model.attribute]];
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:STWidth(244) font:STFont(14) fontName:FONT_REGULAR];
    _nameLabel.frame = CGRectMake(STWidth(116), STHeight(20), STWidth(244), nameSize.height);
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%.2f",model.sellPrice / 100];
    CGSize priceSize = [_priceLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _priceLabel.frame = CGRectMake(STWidth(116), STHeight(93), priceSize.width, STHeight(20));
    
    if(!IS_NS_COLLECTION_EMPTY(_celebrityDatas)){
        [self addCelebrity];
    }
    
}

-(void)addCelebrity{
    CGFloat dynamicWidth = 0;
    for(int i = 0 ; i < _celebrityDatas.count ; i ++){
        ProductCelebrityModel *model = _celebrityDatas[i];
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15) + dynamicWidth, STHeight(10), STWidth(25), STWidth(25))];
        headImageView.layer.masksToBounds = YES;
        headImageView.layer.cornerRadius = STHeight(12.5);
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_celebrityView addSubview:headImageView];
        
        if(!IS_NS_STRING_EMPTY(model.avatar)){
            [headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
        }else{
            headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
        }
        
        UILabel *nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:model.mchName textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
        nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        nameLabel.frame = CGRectMake(STWidth(50) + dynamicWidth , STHeight(12), STWidth(108), STHeight(21));
        [_celebrityView addSubview:nameLabel];
        
        dynamicWidth += STWidth(158);

    }
    
    [_celebrityView setContentSize:CGSizeMake(dynamicWidth, STHeight(45))];
}


+(NSString *)identify{
    return NSStringFromClass([PartnerDetailViewCell class]);
}

@end
