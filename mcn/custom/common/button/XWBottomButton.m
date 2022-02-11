//
//  XWBottomButton.m
//  cigarette
//
//  Created by by.huang on 2020/1/13.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "XWBottomButton.h"

@interface XWBottomButton()

@property(copy, nonatomic)NSString *titleStr;
@property(strong, nonatomic)UIButton *button;

@end

@implementation XWBottomButton

-(instancetype)initWithTitle:(NSString *)titleStr{
    if(self == [super init]){
        _titleStr = titleStr;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = cwhite;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowColor = c03.CGColor;
    
    if(!IS_NS_STRING_EMPTY(_titleStr)){
        _button = [[UIButton alloc]initWithFont:STFont(18) text:_titleStr textColor:cwhite backgroundColor:c16 corner:4 borderWidth:0 borderColor:nil];
        _button.frame = CGRectMake(STWidth(30), STHeight(15), STWidth(315), STHeight(50));
        [_button setTitleColor:cwhite forState:UIControlStateNormal];
        [_button setBackgroundColor:c16 forState:UIControlStateNormal];
        [_button setBackgroundColor:c16_p forState:UIControlStateHighlighted];
        [self addSubview:_button];
    }
    
}


-(void)setDisable:(Boolean)disable{
    if(!IS_NS_STRING_EMPTY(_titleStr)){
        _button.enabled = !disable;
        [_button setBackgroundColor:disable ? c16_d : c16 forState:UIControlStateNormal];
    }
}

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    if(!IS_NS_STRING_EMPTY(_titleStr)){
        [_button addTarget:target action:action forControlEvents:controlEvents];
    }
}

- (void)setButtonFrame:(CGRect)frame{
    if(!IS_NS_STRING_EMPTY(_titleStr)){
        _button.frame = frame;
    }
}

@end
