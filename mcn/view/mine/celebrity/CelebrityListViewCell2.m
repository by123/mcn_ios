

#import "CelebrityListViewCell2.h"


@interface CelebrityListViewCell2()

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *mobileLabel;

@end

@implementation CelebrityListViewCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    
    self.contentView.backgroundColor = cbg2;
    UIView *cardView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(133))];
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
    
    _rejectBtn = [[UIButton alloc]initWithFont:STFont(12) text:@"拒绝" textColor:c20 backgroundColor:nil corner:4 borderWidth:1 borderColor:c20];
    _rejectBtn.frame = CGRectMake(STWidth(230), STHeight(88), STWidth(45), STHeight(25));
    [cardView addSubview:_rejectBtn];
    
    _agreeBtn = [[UIButton alloc]initWithFont:STFont(12) text:@"同意" textColor:cwhite backgroundColor:c20 corner:4 borderWidth:0 borderColor:nil];
    _agreeBtn.frame = CGRectMake(STWidth(285), STHeight(88), STWidth(45), STHeight(25));
    [cardView addSubview:_agreeBtn];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [cardView addSubview:_nameLabel];
    
    _mobileLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [cardView addSubview:_mobileLabel];
    

}

-(void)updateData:(CelebrityModel *)model{
    
    if(!IS_NS_STRING_EMPTY(model.picFullUrl)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.picFullUrl]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
    
    _nameLabel.text = model.anchorName;
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _nameLabel.frame = CGRectMake(STWidth(92), STHeight(29), nameSize.width, STHeight(21));

    _mobileLabel.text = model.anchorMobile;
    CGSize mobileSize = [_mobileLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    _mobileLabel.frame = CGRectMake(STWidth(92), STHeight(55), mobileSize.width, STHeight(20));


}

+(NSString *)identify{
    return NSStringFromClass([CelebrityListViewCell2 class]);
}

@end

