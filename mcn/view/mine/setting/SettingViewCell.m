#import "SettingViewCell.h"


@interface SettingViewCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UIView *lineView;


@end

@implementation SettingViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    self.contentView.backgroundColor = cwhite;

    _titleLabel = [[UILabel alloc]initWithFont:STFont(15) text:@"" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_titleLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth -  STWidth(15) - STHeight(12.4), (STHeight(51)-STHeight(12.4))/2, STHeight(12.4), STHeight(12.4))];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    arrowImageView.image = [UIImage imageNamed:IMAGE_ARROW_RIGHT_GREY];
    [self.contentView addSubview:arrowImageView];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(50) - LineHeight, STWidth(345), LineHeight)];
    _lineView.backgroundColor = cline;
    _lineView.hidden = YES;
    [self.contentView addSubview:_lineView];
}

-(void)updateData:(NSString *)title lineHidden:(Boolean)hidden{
    _titleLabel.text = title;
    CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15)];
    _titleLabel.frame = CGRectMake(STWidth(15), 0, titleSize.width, STHeight(50));
    
    _lineView.hidden = hidden;
    
}

+(NSString *)identify{
    return NSStringFromClass([SettingViewCell class]);
}

@end

