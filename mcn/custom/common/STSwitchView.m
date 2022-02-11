//
//  STSwitchView.m
//  framework
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STSwitchView.h"

@interface STSwitchView()

@property(strong, nonatomic)UIView *pointView;

@end

@implementation STSwitchView

-(instancetype)init{
    if(self == [super init]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, STWidth(50), STHeight(25));
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = STHeight(12.5);
    self.backgroundColor = c27;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTouchSwitchView)];
    [self addGestureRecognizer:recognizer];
    
    _pointView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, STHeight(25), STHeight(25))];
    _pointView.backgroundColor = cwhite;
    _pointView.layer.masksToBounds = NO;
    _pointView.layer.cornerRadius = STHeight(12.5);
    _pointView.layer.shadowOffset = CGSizeMake(1, 2);
    _pointView.layer.shadowOpacity = 0.4;
    _pointView.layer.shadowColor = c10.CGColor;
    _pointView.layer.borderWidth = 0.5;
    _pointView.layer.borderColor = c03.CGColor;

    
    [self addSubview:_pointView];
    
    [self setOn:_on];
    
}


-(void)onTouchSwitchView{
    _on = !_on;
    WS(weakSelf)
    if(_on){
        [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            weakSelf.pointView.frame = CGRectMake(STWidth(25) ,0, STHeight(25), STHeight(25));
            weakSelf.backgroundColor = c16;
            weakSelf.pointView.layer.shadowColor = c28.CGColor;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            weakSelf.pointView.frame = CGRectMake(0, 0, STHeight(25), STHeight(25));
            weakSelf.backgroundColor = c27;
            weakSelf.pointView.layer.shadowColor = c10.CGColor;
        } completion:^(BOOL finished) {
            
        }];
    }
    if(_delegate){
        [_delegate onSwitchStatuChange:_on tag:self.tag view:self];
    }
}


-(void)setOn:(Boolean)on{
    _on = on;
    if(_on){
        _pointView.frame = CGRectMake(STWidth(25), 0, STHeight(25), STHeight(25));
        self.backgroundColor = c16;
        self.pointView.layer.shadowColor = c28.CGColor;
    }else{
        _pointView.frame = CGRectMake(0, 0, STHeight(25), STHeight(25));
        self.backgroundColor = c27;
        self.pointView.layer.shadowColor = c10.CGColor;
    }
}


@end
