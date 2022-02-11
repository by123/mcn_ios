

#import "CooperationItemViewCell.h"
#import "UIButton+Extension.h"
#import "CelebrityModel.h"
#import "AccountManager.h"
@interface CooperationItemViewCell()

@property(strong, nonatomic)UIImageView *showImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UIView *lineView;
@property(strong, nonatomic)UILabel *priceLabel;
@property(strong, nonatomic)UILabel *firstLabel;
@property(strong, nonatomic)UILabel *firstTagLabel;
@property(strong, nonatomic)UILabel *reLabel;
@property(strong, nonatomic)UILabel *reTagLabel;
@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)NSMutableArray *imageViews;


@end

@implementation CooperationItemViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _imageViews = [[NSMutableArray alloc]init];
        [self initView];
    }
    return self;
}


-(void)initView{
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(20), STHeight(90), STHeight(90))];
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    _showImageView.layer.masksToBounds = YES;
    _showImageView.layer.cornerRadius = 4;
    [self.contentView addSubview:_showImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:YES];
    [self.contentView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_priceLabel];
    
    _firstTagLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(7)] text:@"首" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c16 multiLine:NO];
    _firstTagLabel.layer.masksToBounds = YES;
    _firstTagLabel.layer.cornerRadius = 2;
    [self.contentView addSubview:_firstTagLabel];
    
    _firstLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_firstLabel];
    
    _reTagLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(7)] text:@"复" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c10 multiLine:NO];
    _reTagLabel.layer.cornerRadius = 2;
    _reTagLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:_reTagLabel];
    
    _reLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_reLabel];
    
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), userModel.roleType == RoleType_Celebrity ? STHeight(130) : STHeight(170) - LineHeight, STWidth(345), LineHeight)];
    _lineView.backgroundColor = cline;
    [self.contentView addSubview:_lineView];
    
    if(userModel.roleType == RoleType_Mcn){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(130), STWidth(250), STHeight(40))];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_scrollView];
        
        _selectBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"选择主播" textColor:c10 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
        [_selectBtn setImage:[UIImage imageNamed:IMAGE_ARROW_RIGHT_GREY] forState:UIControlStateNormal];
        _selectBtn.frame = CGRectMake(ScreenWidth - STWidth(95), STHeight(125), STWidth(80), STHeight(40));
        [self.contentView addSubview:_selectBtn];
        
        [_selectBtn imageLayout:ImageLayoutRight centerPadding:0];
    }
    
}

-(void)updateData:(ShopSkuModel *)model hiddenLine:(Boolean)hiddenLine{
    [_showImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    
    _nameLabel.text = [NSString stringWithFormat:@"%@%@",model.spuName,[ProductModel getAttributeValue:model.attribute]];
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:STWidth(244) font:STFont(14) fontName:FONT_SEMIBOLD];
    if(nameSize.height > [self singLineHeight] * 2){
        nameSize.height = [self singLineHeight] * 2;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _nameLabel.numberOfLines = 2;
        _nameLabel.frame = CGRectMake(STWidth(116), STHeight(20), STWidth(244), [self singLineHeight] * 2);
    }else{
        _nameLabel.frame = CGRectMake(STWidth(116), STHeight(20), STWidth(244), nameSize.height);
    }
    
    _priceLabel.text = [NSString stringWithFormat:@"%@%.2f",MSG_UNIT,model.sellPrice / 100];
    CGSize priceSize = [_priceLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _priceLabel.frame = CGRectMake(STWidth(116), STHeight(24) + nameSize.height, priceSize.width, STHeight(17));
    
    
    _firstLabel.text = [NSString stringWithFormat:@"首单分成：¥%.2f",model.firstPrice / 100];
    CGSize firstSize = [_firstLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
    _firstLabel.frame = CGRectMake(STWidth(134), STHeight(46) + nameSize.height, firstSize.width, STHeight(16));
    
    _reLabel.text = [NSString stringWithFormat:@"复购分成：¥%.2f",model.rePrice / 100];
    CGSize reSize = [_reLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
    _reLabel.frame = CGRectMake(STWidth(134), STHeight(65) + nameSize.height, reSize.width, STHeight(16));
    
    
    _firstTagLabel.frame = CGRectMake(STWidth(116), STHeight(48) + nameSize.height, STHeight(12), STHeight(12));
    _reTagLabel.frame = CGRectMake(STWidth(116), STHeight(67) + nameSize.height, STHeight(12), STHeight(12));
    
    _lineView.hidden = hiddenLine;
    
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if(userModel.roleType == RoleType_Mcn){
        if(!IS_NS_COLLECTION_EMPTY(model.celebrityDatas)){
            [self removeImageViews];
            for(int i = 0 ; i < model.celebrityDatas.count; i ++){
                CelebrityModel *celebrityModel = [model.celebrityDatas objectAtIndex:i];
                UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * STHeight(33), 0, STHeight(30), STHeight(30))];
                [headImageView sd_setImageWithURL:[NSURL URLWithString:celebrityModel.picFullUrl]];
                headImageView.layer.masksToBounds = YES;
                headImageView.layer.cornerRadius = STHeight(15);
                headImageView.contentMode = UIViewContentModeScaleAspectFill;
                [_scrollView addSubview:headImageView];
                [_imageViews addObject:headImageView];
            }
            
        }else{
            [self removeImageViews];
        }
        [_scrollView setContentSize:CGSizeMake(model.celebrityDatas.count * STHeight(33), STHeight(30))];
        
    }
}

//投机取巧
-(CGFloat)singLineHeight{
    CGSize contentSize = [@"小红菇" sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    return contentSize.height;
}


-(void)removeImageViews{
    if(!IS_NS_COLLECTION_EMPTY(_imageViews)){
        for(UIImageView *imageView in _imageViews){
            [imageView removeFromSuperview];
        }
        [_imageViews removeAllObjects];
    }
}

+(NSString *)identify{
    return NSStringFromClass([CooperationItemViewCell class]);
}

@end

