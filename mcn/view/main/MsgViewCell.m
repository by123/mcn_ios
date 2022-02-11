

#import "MsgViewCell.h"
#import "STTimeUtil.h"

@interface MsgViewCell()<UIScrollViewDelegate>

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *contentLabel;
@property(strong, nonatomic)UILabel *createTimeLabel;
@property(strong, nonatomic)UIView *pointView;
@property(strong, nonatomic)UIScrollView *scrollView;

@end

@implementation MsgViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    
    _msgView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(150))];
    _msgView.backgroundColor = cwhite;
    _msgView.layer.cornerRadius = 4;
    _msgView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _msgView.layer.shadowOffset = CGSizeMake(0,2);
    _msgView.layer.shadowOpacity = 1;
    _msgView.layer.shadowRadius = 10;
    
    [self.contentView addSubview:_msgView];
    
    _titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [_msgView addSubview:_titleLabel];
    
    _pointView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(330) - STHeight(21), STHeight(15), STHeight(10), STHeight(10))];
    _pointView.layer.masksToBounds =
    YES;
    _pointView.layer.cornerRadius = STHeight(5);
    _pointView.backgroundColor = c20;
    [_msgView addSubview:_pointView];
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, STHeight(50), STWidth(345), STHeight(100))];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [_msgView addSubview:_scrollView];
    
    _delBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"删除" textColor:cwhite backgroundColor:c20 corner:0 borderWidth:0 borderColor:nil];
    _delBtn.frame = CGRectMake(STWidth(345), 0, STWidth(70), STHeight(100));
    [_scrollView addSubview:_delBtn];
    
    [_scrollView setContentSize:CGSizeMake(STWidth(415), STHeight(100))];
    
    
    _contentLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:YES];
    [_scrollView addSubview:_contentLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(50), STWidth(315), LineHeight)];
    lineView.backgroundColor = cline;
    [_scrollView addSubview:lineView];
    
    _createTimeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c05 backgroundColor:nil multiLine:NO];
    [_scrollView addSubview:_createTimeLabel];
    
    UILabel *seeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:@"立即查看" textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    CGSize seeSize = [seeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    seeLabel.frame = CGRectMake(STWidth(330) - seeSize.width , STHeight(68), seeSize.width, STHeight(20));
    [_scrollView addSubview:seeLabel];
    
    
}

-(void)updateData:(MsgModel *)model{
    _titleLabel.text = model.title;
    CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_SEMIBOLD];
    _titleLabel.frame = CGRectMake(STWidth(15), STHeight(15), titleSize.width, STHeight(21));
    
    _contentLabel.text = model.text;
    CGSize contentSize = [_contentLabel.text sizeWithMaxWidth:STWidth(315) font:STFont(14) fontName:FONT_REGULAR];
    if(contentSize.height > [self singLineHeight] * 2){
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.numberOfLines = 2;
        _contentLabel.frame = CGRectMake(STWidth(15), 0, STWidth(315), [self singLineHeight] * 2);
    }else{
        _contentLabel.frame = CGRectMake(STWidth(15), 0, STWidth(315), contentSize.height);
    }
    
    _createTimeLabel.text = [STTimeUtil generateDate:model.createTime format:MSG_DATE_FORMAT_ALL];
    CGSize createTimeSize = [_createTimeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    _createTimeLabel.frame = CGRectMake(STWidth(15),STHeight(68), createTimeSize.width, STHeight(17));
    
    _pointView.hidden = (model.readState == 1);
    
    [_scrollView setContentOffset:CGPointMake(0, 0)];
}


//投机取巧
-(CGFloat)singLineHeight{
    CGSize contentSize = [@"小红菇" sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    return contentSize.height;
}

+(NSString *)identify{
    return NSStringFromClass([MsgViewCell class]);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    //    if( x >= STWidth(70)){
    //            scrollView.contentOffset = CGPointMake(STWidth(70), 0);
    //    }
    //    else{
    //            scrollView.contentOffset = CGPointMake(0, 0);
    //    }
}

@end

