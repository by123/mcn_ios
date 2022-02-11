

#import "CelebrityListViewCell.h"


@interface CelebrityListViewCell()

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *mobileLabel;
@property(strong, nonatomic)UILabel *profitLabel;
@property(strong, nonatomic)UILabel *statuLabel;

@end

@implementation CelebrityListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    
    self.contentView.backgroundColor = cbg2;
    UIView *cardView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(115))];
    cardView.backgroundColor = cwhite;
    cardView.layer.cornerRadius = 4;
    cardView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    cardView.layer.shadowOffset = CGSizeMake(0,2);
    cardView.layer.shadowOpacity = 1;
    cardView.layer.shadowRadius = 10;
    [self.contentView addSubview:cardView];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(21), STHeight(62), STHeight(62))];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(31);
    [cardView addSubview:_headImageView];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(330) - STHeight(20),STHeight(24), STHeight(20), STHeight(20))];
    arrowImageView.image = [UIImage imageNamed:IMAGE_ARROW_RIGHT_GREY];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [cardView addSubview:arrowImageView];
    
//    _removeBtn = [[UIButton alloc]initWithFont:STFont(12) text:@"移除" textColor:c20 backgroundColor:nil corner:4 borderWidth:1 borderColor:c20];
//    _removeBtn.frame = CGRectMake(STWidth(285), STHeight(69), STWidth(45), STHeight(25));
//    [cardView addSubview:_removeBtn];
    _statuLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c16 backgroundColor:nil multiLine:NO];
    [cardView addSubview:_statuLabel];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    [cardView addSubview:_nameLabel];
    
    _mobileLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [cardView addSubview:_mobileLabel];
    
    UIView *view = [[UIView alloc]init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(STWidth(92), STHeight(71), STWidth(70), STHeight(20));
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:220/255.0 blue:0/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:206/255.0 blue:0/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@(0), @(1.0f)];
    view.layer.cornerRadius = 2;
    [view.layer addSublayer:gradientLayer];
    [cardView addSubview:view];
    
    _profitLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(9)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _profitLabel.frame = CGRectMake(STWidth(92), STHeight(71), STWidth(70), STHeight(20));
    [view addSubview:_profitLabel];

}

-(void)updateData:(CelebrityModel *)model type:(int)type{
    
    if(!IS_NS_STRING_EMPTY(model.picFullUrl)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.picFullUrl]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
    
    
    _nameLabel.text = type == 0 ? model.mchName : model.anchorName;
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _nameLabel.frame = CGRectMake(STWidth(92), STHeight(21), STWidth(200), STHeight(21));

    _mobileLabel.text = type == 0? model.contactPhone : model.anchorMobile;
    CGSize mobileSize = [_mobileLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    _mobileLabel.frame = CGRectMake(STWidth(92), STHeight(47), mobileSize.width, STHeight(20));

    
    _profitLabel.text = [NSString stringWithFormat:@"分成比例:%d%%",model.allocateRatio];
    
    NSString *statuStr = @"待处理";
    _statuLabel.textColor = c11;
    if(model.operateState == 1){
        statuStr = @"同意";
        _statuLabel.textColor = c45;
    }else if(model.operateState == 2){
        statuStr = @"不同意";
        _statuLabel.textColor = c16;
    }
    _statuLabel.text = statuStr;
    CGSize statuSize = [_statuLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_SEMIBOLD];
    _statuLabel.frame = CGRectMake(STWidth(330) - statuSize.width, STHeight(69), statuSize.width, STHeight(20));
    
    _statuLabel.hidden = (type == 0);

}

+(NSString *)identify{
    return NSStringFromClass([CelebrityListViewCell class]);
}

@end

