//
//  XWButton.m
//  cigarette
//
//  Created by by.huang on 2020/1/10.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "XWButton.h"

@interface XWButton()

@property(copy, nonatomic)NSString *titleStr;
@property(assign, nonatomic)XWButtonType type;

@end

@implementation XWButton

-(instancetype)initWithTitle:(NSString *)titleStr type:(XWButtonType)type{
    if(self == [super init]){
        _titleStr = titleStr;
        _type = type;
        [self initView];
    }
    return self;
}

-(void)initView{
    if(_type == XWButtonType_Positive){
        [self setTitleColor:cwhite forState:UIControlStateNormal];
        [self setBackgroundColor:c16 forState:UIControlStateNormal];
        [self setBackgroundColor:c16_p forState:UIControlStateHighlighted];
    }else{
        [self setTitleColor:c10 forState:UIControlStateNormal];
        [self setBackgroundColor:cwhite forState:UIControlStateNormal];
        [self setBackgroundColor:cbg2 forState:UIControlStateHighlighted];
        self.layer.borderWidth = LineHeight;
        self.layer.borderColor = c10.CGColor;
    }
    self.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(18)];
    [self setTitle:_titleStr forState:UIControlStateNormal];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2;
}


-(void)setDisable:(Boolean)disable{
    self.enabled = !disable;
    if(_type == XWButtonType_Positive){
        [self setBackgroundColor:disable ? c16_d : c16 forState:UIControlStateNormal];
    }else{
        [self setTitleColor:disable ? c05 : c10 forState:UIControlStateNormal];
        self.layer.borderColor = disable ? c03.CGColor : c10.CGColor;
        [self setBackgroundColor:disable ? c03 : cwhite forState:UIControlStateNormal];
    }
}

-(void)setFontSize:(CGFloat)fontSize{
    self.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:fontSize];
}

@end
