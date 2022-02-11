

#import "STTitleTableViewCell.h"
#import "ZScrollLabel.h"


@interface STTitleTableViewCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)ZScrollLabel *contentLabel;
@property(strong, nonatomic)UIView *lineView;

@end

@implementation STTitleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    self.contentView.backgroundColor = cwhite;

    _titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_titleLabel];
    
    
    _contentLabel = [[ZScrollLabel alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(230),STHeight(15), STWidth(215), STHeight(20))];
    _contentLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)];
    _contentLabel.text = MSG_EMPTY;
    _contentLabel.textColor = c10;
    _contentLabel.labelAlignment = ZScrollLabelAlignmentRight;
    [self.contentView addSubview:_contentLabel];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(50)-LineHeight, STWidth(345), LineHeight)];
    _lineView.backgroundColor = cline;
    [self.contentView addSubview:_lineView];
}

-(void)updateData:(TitleContentModel *)model hiddenLine:(Boolean)hiddenLine{
    
    _titleLabel.text = model.title;
    CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14)];
    _titleLabel.frame = CGRectMake(STWidth(15), STHeight(15), titleSize.width, STHeight(20));
    
    _contentLabel.text = model.content;
//    CGSize contentSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_SEMIBOLD];
    
    _lineView.hidden = hiddenLine;
    
}

+(NSString *)identify{
    return NSStringFromClass([STTitleTableViewCell class]);
}

@end

