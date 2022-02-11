

#import "ShelvesListViewCell.h"


@interface ShelvesListViewCell()<UIScrollViewDelegate>

@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)UIImageView *showImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *priceLabel;
@property(strong, nonatomic)UILabel *firstLabel;
@property(strong, nonatomic)UILabel *reLabel;

@end

@implementation ShelvesListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    
    _shelvesView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(143))];
    _shelvesView.backgroundColor = cwhite;
    _shelvesView.layer.cornerRadius = 4;
    _shelvesView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _shelvesView.layer.shadowOffset = CGSizeMake(0,2);
    _shelvesView.layer.shadowOpacity = 1;
    _shelvesView.layer.shadowRadius = 10;
    
    [self.contentView addSubview:_shelvesView];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, STWidth(345), STHeight(143))];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [_shelvesView addSubview:_scrollView];
    
    _shelvesBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"上架" textColor:cwhite backgroundColor:c36 corner:0 borderWidth:0 borderColor:nil];
    _shelvesBtn.frame = CGRectMake(STWidth(345), 0, STWidth(70), STHeight(143));
    [_scrollView addSubview:_shelvesBtn];
    
    [_scrollView setContentSize:CGSizeMake(STWidth(415), STHeight(143))];
    
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(20), STHeight(100), STHeight(100))];
    _showImageView.clipsToBounds = YES;
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    _showImageView.layer.masksToBounds = YES;
    _showImageView.layer.cornerRadius = 4;
    [_scrollView addSubview:_showImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    [_scrollView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    [_scrollView addSubview:_priceLabel];
    
    UILabel *firstTagLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(7)] text:@"首" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c16 multiLine:NO];
    firstTagLabel.frame = CGRectMake(STWidth(130), STHeight(88), STHeight(12), STHeight(12));
    firstTagLabel.layer.masksToBounds = YES;
    firstTagLabel.layer.cornerRadius = 2;
    [_scrollView addSubview:firstTagLabel];
    
    _firstLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [_scrollView addSubview:_firstLabel];
    
    UILabel *reTagLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(7)] text:@"复" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c10 multiLine:NO];
    reTagLabel.frame = CGRectMake(STWidth(130), STHeight(107), STHeight(12), STHeight(12));
    reTagLabel.layer.cornerRadius = 2;
    reTagLabel.layer.masksToBounds = YES;
    [_scrollView addSubview:reTagLabel];
    
    _reLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [_scrollView addSubview:_reLabel];
    
}

-(void)updateData:(ShelvesModel *)model type:(ShelvesType)type{
    
    if(!IS_NS_STRING_EMPTY(model.skuPicOssUrl)){
        [_showImageView sd_setImageWithURL:[NSURL URLWithString:model.skuPicOssUrl]];
    }
    
    _nameLabel.text = [NSString stringWithFormat:@"%@%@",model.spuName,[ProductModel getAttributeValue:model.attribute]];
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:STWidth(200) font:STFont(14) fontName:FONT_REGULAR];
    if(nameSize.height > [self singLineHeight] * 2){
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _nameLabel.numberOfLines = 2;
        _nameLabel.frame = CGRectMake(STWidth(130), STHeight(20), STWidth(200), [self singLineHeight] * 2);
    }else{
        _nameLabel.frame = CGRectMake(STWidth(130), STHeight(20), STWidth(200), nameSize.height);
    }
    
    
    _priceLabel.text = [NSString stringWithFormat:@"%@%.2f",MSG_UNIT,model.sellPrice / 100];
    CGSize priceSize = [_priceLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _priceLabel.frame = CGRectMake(STWidth(130), STHeight(64), priceSize.width, STHeight(17));
    
    
    _firstLabel.text = [NSString stringWithFormat:@"首单分成：¥%.2f",model.firstOrderProfit / 100];
    CGSize firstSize = [_firstLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
    _firstLabel.frame = CGRectMake(STWidth(148), STHeight(86), firstSize.width, STHeight(16));
    
    _reLabel.text = [NSString stringWithFormat:@"复购分成：¥%.2f",model.repeatProfit / 100];
    CGSize reSize = [_reLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
    _reLabel.frame = CGRectMake(STWidth(148), STHeight(105), reSize.width, STHeight(16));
    
    if(type == ShelvesType_Grouding){
        _scrollView.scrollEnabled = YES;
        [_shelvesBtn setTitle:@"下架" forState:UIControlStateNormal];
        [_shelvesBtn setBackgroundColor:c03 forState:UIControlStateNormal];
    }else if(type == ShelvesType_Undercarriage){
        _scrollView.scrollEnabled = YES;
        [_shelvesBtn setTitle:@"上架" forState:UIControlStateNormal];
        [_shelvesBtn setBackgroundColor:c36 forState:UIControlStateNormal];
    }else{
        _scrollView.scrollEnabled = NO;
    }
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    
}

//投机取巧
-(CGFloat)singLineHeight{
    CGSize contentSize = [@"小红菇" sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    return contentSize.height;
}

+(NSString *)identify{
    return NSStringFromClass([ShelvesListViewCell class]);
}

@end

