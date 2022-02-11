

#import "PartnerMcnViewCell.h"


@interface PartnerMcnViewCell()

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UIImageView *genderImageView;
@property(strong, nonatomic)UILabel *remarkLabel;

@end

@implementation PartnerMcnViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(122))];
    view.backgroundColor = cwhite;
    view.layer.cornerRadius = 4;
    view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,2);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 10;
    [self.contentView addSubview:view];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(30), STHeight(62), STHeight(62))];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(31);
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [view addSubview:_nameLabel];
    
    _genderImageView = [[UIImageView alloc]init];
    _genderImageView.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:_genderImageView];
    
    _remarkLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:YES];
    [view addSubview:_remarkLabel];
    
}

-(void)updateData:(AuthUserModel *)model{
    if(!IS_NS_STRING_EMPTY(model.picFullUrl)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.picFullUrl]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
    
    _nameLabel.text = model.mchName;
    CGSize nameSize = [_nameLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _nameLabel.frame = CGRectMake(STWidth(92), STHeight(30), nameSize.width, STHeight(21));
    
    _genderImageView.frame = CGRectMake(STWidth(97) + nameSize.width, STHeight(34), STHeight(14), STHeight(14));
    [_genderImageView setImage:[UIImage imageNamed:model.sex == 0 ? IMAGE_GENDER_MALE : IMAGE_GENDER_FEMALE]];
    
    _remarkLabel.text = model.baseModel.remark;
    CGSize remarkSize = [_remarkLabel.text sizeWithMaxWidth:STWidth(230) font:STFont(14) fontName:FONT_REGULAR];
    _remarkLabel.frame = CGRectMake(STWidth(92), STHeight(56), STWidth(230), remarkSize.height);
}

+(NSString *)identify{
    return NSStringFromClass([PartnerMcnViewCell class]);
}

@end

