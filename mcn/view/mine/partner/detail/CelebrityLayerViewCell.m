

#import "CelebrityLayerViewCell.h"


@interface CelebrityLayerViewCell()

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *reLabel;
@property(strong, nonatomic)UILabel *firstLabel;
@property(strong, nonatomic)UILabel *firstTitleLabel;
@property(strong, nonatomic)UILabel *reTitleLabel;
@property(strong, nonatomic)UILabel *linkLabel;


@end

@implementation CelebrityLayerViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(20), STHeight(25), STHeight(25))];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(12.5);
    [self.contentView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    _nameLabel.frame = CGRectMake(STWidth(50), STHeight(20), STWidth(245), STHeight(21));
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_nameLabel];
    
    _firstTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(7)] text:@"首" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c20 multiLine:NO];
    _firstTitleLabel.layer.masksToBounds = YES;
    _firstTitleLabel.layer.cornerRadius = 2;
    [self.contentView addSubview:_firstTitleLabel];
    
    _firstLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_firstLabel];
    
    _reTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(7)] text:@"复" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c10 multiLine:NO];
    _reTitleLabel.layer.masksToBounds = YES;
    _reTitleLabel.layer.cornerRadius = 2;
    [self.contentView addSubview:_reTitleLabel];
    
    _reLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_reLabel];
    
    _linkLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    _linkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _linkLabel.frame = CGRectMake(STWidth(52), STHeight(100), STWidth(252), STHeight(20));
    [self.contentView addSubview:_linkLabel];
    
    _linkCopyBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"复制" textColor:c44 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    _linkCopyBtn.frame = CGRectMake(STWidth(315), STHeight(90), STWidth(60), STHeight(40));
    [self.contentView addSubview:_linkCopyBtn];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(STWidth(15), STHeight(140)-LineHeight, STWidth(345), LineHeight);
    lineView.backgroundColor = cline;
    [self.contentView addSubview:lineView];
}

-(void)updateData:(ProductCelebrityModel *)model{
    if(!IS_NS_STRING_EMPTY(model.avatar)){
          [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
      
      _nameLabel.text = model.mchName;
      
      
      _firstLabel.text = [NSString stringWithFormat:@"首单分成：¥%.2f",model.firstOrderProfit / 100];
      CGSize firstSize = [_firstLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
      _firstLabel.frame = CGRectMake(STWidth(70), STHeight(54), firstSize.width, STHeight(16));
      
      _reLabel.text = [NSString stringWithFormat:@"复购分成：¥%.2f",model.repeatProfit / 100];
      CGSize reSize = [_reLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
      _reLabel.frame = CGRectMake(STWidth(70), STHeight(73), reSize.width, STHeight(16));
      
      _firstTitleLabel.frame = CGRectMake(STWidth(52), STHeight(56), STHeight(12), STHeight(12));
      _reTitleLabel.frame = CGRectMake(STWidth(52), STHeight(75), STHeight(12), STHeight(12));
      
      _linkLabel.text = [NSString stringWithFormat:@"导购链接：%@",model.goodsLink];
}

+(NSString *)identify{
    return NSStringFromClass([CelebrityLayerViewCell class]);
}

@end

