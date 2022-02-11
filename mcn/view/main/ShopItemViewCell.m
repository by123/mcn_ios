

#import "ShopItemViewCell.h"


@interface ShopItemViewCell()<UIScrollViewDelegate>

@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)UIImageView *showImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *priceLabel;
@property(strong, nonatomic)UILabel *firstLabel;
@property(strong, nonatomic)UILabel *reLabel;
@property(strong, nonatomic)UIImageView *selectImageView;
@property(strong, nonatomic)UILabel *reTagLabel;
@property(strong, nonatomic)UILabel *firstTagLabel;

@end

@implementation ShopItemViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    
    _shopItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, STWidth(345), STHeight(136))];
    [self.contentView addSubview:_shopItemView];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, STWidth(345), STHeight(136))];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [_shopItemView addSubview:_scrollView];
    
    [_scrollView setContentSize:CGSizeMake(STWidth(415), STHeight(136))];
    
    _delBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"删除" textColor:cwhite backgroundColor:c20 corner:0 borderWidth:0 borderColor:nil];
    _delBtn.frame = CGRectMake(STWidth(345), 0, STWidth(70), STHeight(136));
    [_scrollView addSubview:_delBtn];
    
    _selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(53), STHeight(15), STHeight(15))];
    _selectImageView.image = [UIImage imageNamed:IMAGE_NO_SELECT];
    _selectImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:_selectImageView];
    
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(45), STHeight(16), STHeight(90), STHeight(90))];
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    _showImageView.layer.masksToBounds = YES;
    _showImageView.layer.cornerRadius = 4;
    _showImageView.layer.borderColor = c03.CGColor;
    _showImageView.layer.borderWidth = 0.5;
    [_scrollView addSubview:_showImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    [_scrollView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    [_scrollView addSubview:_priceLabel];
    
    _firstTagLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(7)] text:@"首" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c16 multiLine:NO];
    _firstTagLabel.layer.masksToBounds = YES;
    _firstTagLabel.layer.cornerRadius = 2;
    [_scrollView addSubview:_firstTagLabel];
    
    _firstLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [_scrollView addSubview:_firstLabel];
    
    _reTagLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(7)] text:@"复" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c10 multiLine:NO];
    _reTagLabel.layer.cornerRadius = 2;
    _reTagLabel.layer.masksToBounds = YES;
    [_scrollView addSubview:_reTagLabel];
    
    _reLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [_scrollView addSubview:_reLabel];
}

-(void)updateData:(ShopSkuModel *)model{
    
    _nameLabel.text = model.spuName;
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:STWidth(180) font:STFont(14) fontName:FONT_REGULAR];
    if(nameSize.height > [self singLineHeight] * 2){
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _nameLabel.numberOfLines = 2;
        _nameLabel.frame = CGRectMake(STWidth(145), STHeight(15), STWidth(180),  [self singLineHeight] * 2);
        nameSize.height = [self singLineHeight] * 2;
    }else{
        _nameLabel.frame = CGRectMake(STWidth(145), STHeight(15), STWidth(180), nameSize.height);
    }
    
    
    _nameLabel.frame = CGRectMake(STWidth(145), STHeight(15), STWidth(180), nameSize.height);
    
    if(!IS_NS_STRING_EMPTY(model.picUrl)){
        [_showImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    }
    
    _priceLabel.text = [NSString stringWithFormat:@"%@%.2f",MSG_UNIT,model.sellPrice / 100];
    CGSize priceSize = [_priceLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _priceLabel.frame = CGRectMake(STWidth(145), nameSize.height + STHeight(19), priceSize.width, STHeight(17));
    
    
    _firstTagLabel.frame = CGRectMake(STWidth(145), nameSize.height + STHeight(43), STHeight(12), STHeight(12));
    _reTagLabel.frame = CGRectMake(STWidth(145), nameSize.height + STHeight(62), STHeight(12), STHeight(12));

    
    _firstLabel.text = [NSString stringWithFormat:@"首单分成：¥%.2f",model.firstPrice / 100];
    CGSize firstSize = [_firstLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
    _firstLabel.frame = CGRectMake(STWidth(163), nameSize.height + STHeight(41), firstSize.width, STHeight(16));
    
    _reLabel.text = [NSString stringWithFormat:@"复购分成：¥%.2f",model.rePrice / 100];
    CGSize reSize = [_reLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
    _reLabel.frame = CGRectMake(STWidth(163), nameSize.height + STHeight(60), reSize.width, STHeight(16));
    
    _selectImageView.image = [UIImage imageNamed:model.isSelect ? IMAGE_SELECT : IMAGE_NO_SELECT];
    
    [_scrollView setContentOffset:CGPointMake(0, 0)];
}

//投机取巧
-(CGFloat)singLineHeight{
    CGSize contentSize = [@"小红菇" sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    return contentSize.height;
}

+(NSString *)identify{
    return NSStringFromClass([ShopItemViewCell class]);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

@end

