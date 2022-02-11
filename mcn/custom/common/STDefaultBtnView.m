//
//  STDefaultBtnView.m
//  cigarette
//
//  Created by by.huang on 2019/9/9.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "STDefaultBtnView.h"

@interface STDefaultBtnView()

@property(copy, nonatomic)NSString *titleStr;
@property(strong, nonatomic)UIButton *defaultBtn;


@end

@implementation STDefaultBtnView


-(instancetype)initWithTitle:(NSString *)title{
    if(self == [super init]){
        self.titleStr = title;
        self.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
        self.backgroundColor = cwhite;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 13;
        self.layer.cornerRadius = 2;
        self.layer.shadowOpacity = 0.06;
        self.layer.shadowColor = c10.CGColor;
        [self initView];
    }
    return self;
}

-(void)initView{
    _defaultBtn = [[UIButton alloc]initWithFont:STFont(18) text:_titleStr textColor:cwhite backgroundColor:c16_d corner:4 borderWidth:0 borderColor:nil];
    _defaultBtn.frame = CGRectMake(STWidth(30), STHeight(15), STWidth(315), STHeight(50));
    [_defaultBtn addTarget:self action:@selector(onDefaultBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _defaultBtn.enabled = NO;
    [self addSubview:_defaultBtn];
}

-(void)setTitle:(NSString *)title{
    [_defaultBtn setTitle:title forState:UIControlStateNormal];
}

-(void)onDefaultBtnClick{
    if(_delegate){
        [_delegate onDefaultBtnClick];
    }
}

-(void)setActive:(Boolean)active{
    if(active){
        [_defaultBtn setBackgroundColor:c16 forState:UIControlStateNormal];
        _defaultBtn.enabled = YES;
    }else{
        [_defaultBtn setBackgroundColor:c16_d forState:UIControlStateNormal];
        _defaultBtn.enabled = NO;
    }
}

-(Boolean)getActive{
    return _defaultBtn.isEnabled;
}

@end
