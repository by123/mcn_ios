//
//  MineView.m
//  mcn
//
//  Created by by.huang on 2020/8/18.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "MineView.h"
#import "UIButton+Extension.h"
#import "AccountManager.h"
#import "LoginPage.h"
@interface MineView()

@property(strong, nonatomic)MainViewModel *mainVM;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *idLabel;
@property(strong, nonatomic)UILabel *mcnLabel;

@end

@implementation MineView{
    NSArray *titles;
    NSArray *images;
    NSArray *toolsTitles;
    NSArray *toolsImages;
}

-(instancetype)initWithViewModel:(MainViewModel *)mainVM{
    if(self == [super init]){
        _mainVM = mainVM;
        [self initView];
        [self updateView];
    }
    return self;
}

-(void)initView{
    titles = @[@"待发货",@"待确认",@"已合作",@"已取消",@"全部合作"];
    images = @[IMAGE_MINE_RECEIVE,IMAGE_MINE_CONFIRM,IMAGE_MINE_PARTNER,IMAGE_MINE_CANCEL,IMAGE_MINE_ALL];
    toolsTitles = @[MSG_MINE_BUSINESS,MSG_MINE_QUALIFICATIONS,MSG_MINE_CAPITAL_ACCOUNT,MSG_MINE_ADDRESS];
    toolsImages = @[IMAGE_MINE_BUSINESS,IMAGE_MINE_QUALIFICATIONS,IMAGE_MINE_CAPITAL_ACCOUNT,IMAGE_MINE_ADDRESS];
    
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    if(model.authenticateState == AuthenticateState_Success){
        if(model.roleType == RoleType_Merchant){
            toolsTitles = @[MSG_MINE_BUSINESS,MSG_MINE_QUALIFICATIONS,MSG_MINE_CAPITAL_ACCOUNT];
            toolsImages = @[IMAGE_MINE_BUSINESS,IMAGE_MINE_QUALIFICATIONS,IMAGE_MINE_CAPITAL_ACCOUNT];
        }else if(model.roleType == RoleType_Mcn){
            toolsTitles = @[MSG_MINE_BUSINESS,MSG_MINE_CELEBRITY_MANAGE,MSG_MINE_QUALIFICATIONS,MSG_MINE_CAPITAL_ACCOUNT,MSG_MINE_ADDRESS];
            toolsImages = @[IMAGE_MINE_BUSINESS,IMAGE_MINE_CELEBRITY_MANAGE,IMAGE_MINE_QUALIFICATIONS,IMAGE_MINE_CAPITAL_ACCOUNT,IMAGE_MINE_ADDRESS];
            
        }
    }else{
        toolsTitles = @[MSG_MINE_BUSINESS,MSG_MINE_QUALIFICATIONS,MSG_MINE_ADDRESS];
        toolsImages = @[IMAGE_MINE_BUSINESS,IMAGE_MINE_QUALIFICATIONS,IMAGE_MINE_ADDRESS];
        
    }
    
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    if([userModel.mchId isEqualToString:@"m202009220000163"]){
        toolsTitles = @[MSG_MINE_BUSINESS,MSG_MINE_CELEBRITY_MANAGE,MSG_MINE_QUALIFICATIONS,MSG_MINE_ADDRESS];
        toolsImages = @[IMAGE_MINE_BUSINESS,IMAGE_MINE_CELEBRITY_MANAGE,IMAGE_MINE_QUALIFICATIONS,IMAGE_MINE_ADDRESS];
    }
    
    [self initTopView];
    [self initStatuView];
    [self initToolView];
}

-(void)initTopView{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(216))];
    CAGradientLayer *bgLayer = [CAGradientLayer layer];
    bgLayer.frame = CGRectMake(0,0,ScreenWidth,STHeight(216));
    bgLayer.startPoint = CGPointMake(1, 0);
    bgLayer.endPoint = CGPointMake(0.5, 1);
    bgLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:132/255.0 blue:112/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:39/255.0 blue:44/255.0 alpha:1.0].CGColor];
    bgLayer.locations = @[@(0), @(1.0f)];
    [bgView.layer addSublayer:bgLayer];
    [self addSubview:bgView];
    
    UIView *headBgView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(81), STHeight(70), STHeight(70))];
    headBgView.backgroundColor = cwhite;
    headBgView.layer.masksToBounds = YES;
    headBgView.layer.cornerRadius = STHeight(35);
    [self addSubview:headBgView];
    
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(17), STHeight(83), STWidth(66), STWidth(66))];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = STHeight(33);
    [self addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_nameLabel];
    
    _idLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(11)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    [self addSubview:_idLabel];
    
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    if(model.authenticateState == AuthenticateState_Success){
        if(model.roleType == RoleType_Celebrity){
            UIImageView *mcnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(100), STHeight(130), STWidth(50), STWidth(17))];
            mcnImageView.image = [UIImage imageNamed:IMAGE_MINE_MCN];
            mcnImageView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:mcnImageView];
            
            _mcnLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:cwhite backgroundColor:nil multiLine:NO];
            [self addSubview:_mcnLabel];
        }
    }
    
    UIImageView *authImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(60), STHeight(90), STWidth(60), STWidth(27))];
    if(model.authenticateState == AuthenticateState_Success){
        authImageView.image = [UIImage imageNamed:IMAGE_MINE_AUTH];
    }else{
        authImageView.image = [UIImage imageNamed:IMAGE_MINE_NOT_AUTH];
    }
    authImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:authImageView];
    
    UIButton *settingBtn = [[UIButton alloc]init];
    settingBtn.frame = CGRectMake(ScreenWidth - STHeight(24) - STWidth(15), STHeight(46), STHeight(24), STHeight(24));
    [settingBtn setImage:[UIImage imageNamed:IMAGE_MINE_SETTING] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(onSettingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingBtn];
}

-(void)initStatuView{
    UIView *statuView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(180), STWidth(345), STHeight(93))];
    statuView.backgroundColor = cwhite;
    statuView.layer.cornerRadius = 4;
    statuView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    statuView.layer.shadowOffset = CGSizeMake(0,2);
    statuView.layer.shadowOpacity = 1;
    statuView.layer.shadowRadius = 10;
    [self addSubview:statuView];
    
    for(int i = 0 ; i < titles.count ; i ++){
        UIButton *statuBtn = [[UIButton alloc]init];
        statuBtn.frame = CGRectMake(STWidth(15) + STWidth(65) * i, STHeight(20), STWidth(50), STHeight(53));
        [statuBtn setTitle:titles[i] forState:UIControlStateNormal];
        [statuBtn setTitleColor:c10 forState:UIControlStateNormal];
        statuBtn.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(12)];
        [statuBtn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        statuBtn.tag = i;
        [statuBtn addTarget:self action:@selector(onStatuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        CGSize imageSize = statuBtn.imageView.frame.size;
        CGSize titleSize = statuBtn.titleLabel.frame.size;
        CGSize textSize = [statuBtn.titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
        
        CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
        if (titleSize.width + 0.5 < frameSize.width) {
            titleSize.width = frameSize.width;
        }
        CGFloat totalHeight = (imageSize.height + titleSize.height + STHeight(5));
        statuBtn.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width);
        statuBtn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
        [statuView addSubview:statuBtn];
    }
}


-(void)initToolView{
    CGFloat homeHeight = 0;
    if (@available(iOS 11.0, *)) {
        homeHeight = HomeIndicatorHeight;
    } else {
        homeHeight = 0;
    }
    
    UIView *toolsView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(290), STWidth(345), ScreenHeight - STHeight(290) - STHeight(62) - homeHeight)];
    toolsView.backgroundColor = cwhite;
    toolsView.layer.cornerRadius = 4;
    toolsView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    toolsView.layer.shadowOffset = CGSizeMake(0,2);
    toolsView.layer.shadowOpacity = 1;
    toolsView.layer.shadowRadius = 10;
    [self addSubview:toolsView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:@"我的工具" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(15), titleSize.width, STHeight(25));
    [toolsView addSubview:titleLabel];
    
    
    for(int i = 0 ; i < toolsTitles.count ; i ++){
        UIButton *toolBtn = [[UIButton alloc]init];
        toolBtn.frame = CGRectMake(STWidth(20) + STWidth(85) * (i % 4), STHeight(50) + (i / 4) * STHeight(85), STWidth(50), STHeight(70));
        [toolBtn setTitle:toolsTitles[i] forState:UIControlStateNormal];
        [toolBtn setTitleColor:c10 forState:UIControlStateNormal];
        toolBtn.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(12)];
        [toolBtn setImage:[UIImage imageNamed:toolsImages[i]] forState:UIControlStateNormal];
        toolBtn.tag = i;
        [toolBtn addTarget:self action:@selector(onToolsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        CGSize imageSize = toolBtn.imageView.frame.size;
        CGSize titleSize = toolBtn.titleLabel.frame.size;
        CGSize textSize = [toolBtn.titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
        
        CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
        if (titleSize.width + 0.5 < frameSize.width) {
            titleSize.width = frameSize.width;
        }
        CGFloat totalHeight = (imageSize.height + titleSize.height + STHeight(5));
        toolBtn.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width);
        toolBtn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
        [toolsView addSubview:toolBtn];
    }
}


-(void)updateView{
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    
    if(!IS_NS_STRING_EMPTY(userModel.avatar)){
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar]];
    }else{
        _headImageView.image = [UIImage imageNamed:IMAGE_DEFAULT];
    }
    
    _nameLabel.text = userModel.name;
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _nameLabel.frame = CGRectMake(STWidth(100), STHeight(83), STWidth(150) , STHeight(25));
    
    _idLabel.text = userModel.mchId;
    CGSize idSize = [_idLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(11) fontName:FONT_REGULAR];
    _idLabel.frame = CGRectMake(STWidth(100), STHeight(110), idSize.width, STHeight(16));
    
    if(userModel.roleType == RoleType_Celebrity){
        if(!IS_NS_STRING_EMPTY(userModel.parentMchName)){
            _mcnLabel.text = userModel.parentMchName;
        }
        _mcnLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _mcnLabel.frame = CGRectMake(STWidth(152), STHeight(130), STWidth(150), STHeight(17));
    }
}

-(void)onSettingBtnClick{
    [_mainVM goSettingPage];
}

-(void)onStatuBtnClick:(id)sender{
    UIButton *button = sender;
    NSInteger tag = button.tag;
    switch (tag) {
        case 0:
            [_mainVM goPartnerPage:PartnerType_WaitSend];
            break;
        case 1:
            [_mainVM goPartnerPage:PartnerType_WaitConfirm];
            break;
        case 2:
            [_mainVM goPartnerPage:PartnerType_Cooperative];
            break;
        case 3:
            [_mainVM goPartnerPage:PartnerType_Cancel];
            break;
        case 4:
            [_mainVM goPartnerPage:PartnerType_All];
            break;
        default:
            break;
    }
}

-(void)onToolsBtnClick:(id)sender{
    UIButton *button = sender;
    NSInteger tag = button.tag;
    NSString *titleStr = toolsTitles[tag];
    
    if([MSG_MINE_BUSINESS isEqualToString:titleStr]){
        [_mainVM goBusinessPage:nil isEdit:YES];
    }else if([MSG_MINE_CELEBRITY_MANAGE isEqualToString:titleStr]){
        [_mainVM goCelebrityPage];
    }else if([MSG_MINE_QUALIFICATIONS isEqualToString:titleStr]){
        [_mainVM goQualificationsPage];
    }else if([MSG_MINE_CAPITAL_ACCOUNT isEqualToString:titleStr]){
        [_mainVM goBankPage];
    }else if([MSG_MINE_ADDRESS isEqualToString:titleStr]){
        [_mainVM goAddressPage];
    }
}

@end
