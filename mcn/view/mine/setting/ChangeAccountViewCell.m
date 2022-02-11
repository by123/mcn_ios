

#import "ChangeAccountViewCell.h"
#import "AccountManager.h"

@interface ChangeAccountViewCell()

@property(strong, nonatomic)UIView *view;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *userIdLabel;
@property(strong, nonatomic)UIImageView *arrowImageView;
@property(strong, nonatomic)UILabel *currentLabel;

@end

@implementation ChangeAccountViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
    _view = [[UIView alloc]init];
    _view.backgroundColor = cwhite;
    _view.layer.cornerRadius = 2;
    _view.layer.shadowColor = [UIColor colorWithRed:53/255.0 green:54/255.0 blue:72/255.0 alpha:0.06].CGColor;
    _view.layer.shadowOffset = CGSizeMake(0,0);
    _view.layer.shadowOpacity = 1;
    _view.layer.shadowRadius = 13;
    [self.contentView addSubview:_view];
    
    _userIdLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [_view addSubview:_userIdLabel];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    [_view addSubview:_nameLabel];
    
    _currentLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:@"当前账号" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c16 multiLine:NO];
    _currentLabel.layer.masksToBounds = YES;
    _currentLabel.layer.cornerRadius = 2;
    _currentLabel.frame = CGRectMake(STWidth(20), STHeight(77), STWidth(70), STHeight(30));
    [_view addSubview:_currentLabel];
    

    _arrowImageView = [[UIImageView alloc]init];
    _arrowImageView.image = [UIImage imageNamed:IMAGE_ARROW_RIGHT_GREY];
    _arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_view addSubview:_arrowImageView];
    
    _clearBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"清除记录" textColor:c20 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    _clearBtn.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)];
    CGSize clearSize = [_clearBtn.titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14)];
    _clearBtn.frame = CGRectMake(STWidth(345) - STWidth(20) - clearSize.width, STHeight(20), clearSize.width, STHeight(22));
    [_view addSubview:_clearBtn];
}

-(void)updateData:(UserModel *)model clearStatu:(Boolean)clearStatu{
    _userIdLabel.text = model.userId;
    CGSize userIdSize = [_userIdLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _userIdLabel.frame = CGRectMake(STWidth(20), STHeight(20), userIdSize.width, STHeight(22));
    
    _nameLabel.text = model.name;
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _nameLabel.frame = CGRectMake(STWidth(20), STHeight(47), STWidth(300), STHeight(20));
    
    _clearBtn.hidden = !clearStatu;
    
    UserModel *currentModel = [[AccountManager sharedAccountManager] getUserModel];
    if([currentModel.userId isEqualToString:model.userId]){
        _clearBtn.hidden = YES;
        _currentLabel.hidden = NO;
        _arrowImageView.frame = CGRectMake(STWidth(345) - STWidth(20) - STHeight(13),STHeight(85) , STHeight(13), STHeight(13));
        _view.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(124));
    }else{
        _currentLabel.hidden = YES;
        _arrowImageView.frame = CGRectMake(STWidth(345) - STWidth(20) - STHeight(13),STHeight(72) , STHeight(13), STHeight(13));
        _view.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(345), STHeight(105));

    }
    
}

+(NSString *)identify{
    return NSStringFromClass([ChangeAccountViewCell class]);
}

@end

