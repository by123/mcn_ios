//
//  AboutView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "AboutView.h"

@interface AboutView()

@property(strong, nonatomic)AboutViewModel *mViewModel;

@end

@implementation AboutView

-(instancetype)initWithViewModel:(AboutViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - STWidth(100))/2, STHeight(100), STWidth(100), STWidth(100))];
     iconImageView.image = [UIImage imageNamed:IMAGE_ICON];
     iconImageView.contentMode = UIViewContentModeScaleAspectFill;
     [self addSubview:iconImageView];
     
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [NSString stringWithFormat:@"小红菇 v%@(%@)",[infoDict objectForKey:@"CFBundleShortVersionString"],[infoDict objectForKey:@"CFBundleVersion"]];
     UILabel *iconLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(18)] text:version textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
     iconLabel.frame = CGRectMake(0, STHeight(215) , ScreenWidth, STHeight(30));
     [self addSubview:iconLabel];
    
    
    UIButton *agreenmentBtn = [[UIButton alloc]init];
    agreenmentBtn.frame = CGRectMake(0,  STHeight(300), ScreenWidth, STHeight(50));
    [agreenmentBtn addTarget:self action:@selector(onAgreenmentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:agreenmentBtn];
    
    [self buildButton:agreenmentBtn title:@"用户协议"];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(350)-LineHeight, ScreenWidth, LineHeight)];
    lineView.backgroundColor = cline;
    [self addSubview:lineView];
    
    UIButton *contactBtn = [[UIButton alloc]init];
    contactBtn.frame = CGRectMake(0,  STHeight(350) + LineHeight, ScreenWidth, STHeight(50));
    [contactBtn addTarget:self action:@selector(onContactBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:contactBtn];
    
    [self buildButton:contactBtn title:@"联系客服"];

}

-(void)buildButton:(UIButton *)btn title:(NSString *)title{
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:title textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    titleLabel.frame = CGRectMake(STWidth(15), 0, titleSize.width, STHeight(50));
    [btn addSubview:titleLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STHeight(14) - STWidth(15), STHeight(18), STHeight(14), STHeight(14))];
    arrowImageView.image = [UIImage imageNamed:IMAGE_ARROW_RIGHT_GREY];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    [btn addSubview:arrowImageView];
}

-(void)onAgreenmentBtnClick{
    if(_mViewModel){
        [_mViewModel goAgressmentPage];
    }
}

-(void)onContactBtnClick{
    if(_mViewModel){
           [_mViewModel doCall];
    }
}

-(void)updateView{
    
}

@end

