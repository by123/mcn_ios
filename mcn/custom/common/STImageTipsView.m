//
//  STImageTipsView.m
//  cigarette
//
//  Created by by.huang on 2019/11/28.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "STImageTipsView.h"

@interface STImageTipsView()

@property(strong, nonatomic)NSString *titleStr;
@property(assign, nonatomic)Boolean top;
@property(strong, nonatomic)UILabel *titleLabel;

@end

@implementation STImageTipsView

-(instancetype)initWithTitle:(NSString *)titleStr top:(Boolean)top{
    if(self == [super init]){
        _titleStr = titleStr;
        _top = top;
        [self initView];
    }
    return self;
}

-(void)initView{
    if(_top){
        self.frame = CGRectMake(0, 0, ScreenWidth, STHeight(50));
        UIImageView *tipsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(18), STHeight(14), STHeight(14))];
        tipsImageView.image = [UIImage imageNamed:IMAGE_TIPS];
        tipsImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:tipsImageView];
        
        _titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:_titleStr textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:YES];
        CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth - STWidth(49) font:STFont(12) fontName:FONT_REGULAR];
        _titleLabel.frame = CGRectMake(STWidth(34), 0, titleSize.width, STHeight(50));
        [self addSubview:_titleLabel];
        
    }else{
        
        UIImageView *tipsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(13.5), STHeight(14), STHeight(14))];
        tipsImageView.image = [UIImage imageNamed:IMAGE_TIPS];
        tipsImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:tipsImageView];
        
        _titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:_titleStr textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:YES];
        _width = ScreenWidth - STWidth(30) - STHeight(34);
        CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:_width font:STFont(12) fontName:FONT_REGULAR];
        _titleLabel.frame = CGRectMake(STWidth(34), STHeight(12),_width, titleSize.height);
        [self addSubview:_titleLabel];
        
        _height = titleSize.height + STHeight(25);
        
        self.frame = CGRectMake(0, 0, ScreenWidth, _height);
        
    }
}

-(void)setTitle:(NSString *)title{
    _titleLabel.text = title;
    if(_top){
         CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth - STWidth(49) font:STFont(12) fontName:FONT_REGULAR];
         _titleLabel.frame = CGRectMake(STWidth(34), 0, titleSize.width, STHeight(50));
         
     }else{
         CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:_width font:STFont(12) fontName:FONT_REGULAR];
              _titleLabel.frame = CGRectMake(STWidth(34), STHeight(10),_width, titleSize.height);
         _titleLabel.frame = CGRectMake(STWidth(34), STHeight(10),_width, titleSize.height);
     }
}

@end
