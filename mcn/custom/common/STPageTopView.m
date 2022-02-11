//
//  STPageTopView.m
//  mcn
//
//  Created by by.huang on 2020/9/2.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "STPageTopView.h"

@interface STPageTopView()

@property(strong, nonatomic)NSArray *titles;
@property(assign, nonatomic)CGFloat middleWidth;
@property(assign, nonatomic)CGFloat perWidth;
@property(strong, nonatomic)UIView *lineView;
@property(assign, nonatomic)NSInteger current;
@property(strong, nonatomic)NSMutableArray *buttons;

@end

@implementation STPageTopView

-(instancetype)initWithTitles:(NSArray *)titles middleWidth:(CGFloat)middleWidth perWidth:(CGFloat)perWidth{
    if(self == [super init]){
        _titles = titles;
        _middleWidth = middleWidth;
        _perWidth = perWidth;
        _current = 0;
        _buttons = [[NSMutableArray alloc]init];
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, STHeight(50));
    self.backgroundColor = cwhite;
    CGFloat left  = (ScreenWidth - _middleWidth * (_titles.count - 1)  - _perWidth * _titles.count) / 2;
    if(!IS_NS_COLLECTION_EMPTY(_titles)){
        for(int i = 0 ; i < _titles.count ; i++){
            UIButton *titleBtn = [[UIButton alloc]initWithFont:STFont(15) text:_titles[i] textColor:c11 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
            titleBtn.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(15)];
            titleBtn.frame = CGRectMake(left + (_perWidth + _middleWidth ) * i, 0, _perWidth, STHeight(50));
            titleBtn.tag = i;
            [titleBtn addTarget:self action:@selector(onTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:titleBtn];
            if(i == _current){
                [titleBtn setTitleColor:c10 forState:UIControlStateNormal];
                titleBtn.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)];
            }
            [_buttons addObject:titleBtn];
        }
    }
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(left + (_perWidth - STWidth(20))/2, STHeight(45), STWidth(20), STHeight(4))];
    _lineView.backgroundColor = c10;
    [self addSubview:_lineView];
}


-(void)onTitleBtnClick:(id)sender{
    [self restoreButton];
    NSInteger position = ((UIButton *)sender).tag;
    [self changeItem:position];
    if(_delegate){
        [_delegate onPageTopViewItemClick:position];
    }
}

-(void)changeItem:(NSInteger)position{
    if(_current == position) return;
    [self restoreButton];
    _current = position;
    UIButton *selectBtn = [_buttons objectAtIndex:_current];
    [selectBtn setTitleColor:c10 forState:UIControlStateNormal];
    selectBtn.titleLabel.font = [UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)];
    
    CGFloat left  = (ScreenWidth - _middleWidth * (_titles.count - 1)  - _perWidth * _titles.count) / 2;
    WS(weakSelf)
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.lineView.frame = CGRectMake(left + (weakSelf.perWidth - STWidth(20))/2 + (weakSelf.perWidth + weakSelf.middleWidth) * weakSelf.current, STHeight(45), STWidth(20), STHeight(4));
    }];
}

-(void)restoreButton{
    if(!IS_NS_COLLECTION_EMPTY(_buttons)){
        for(UIButton *button in _buttons){
            [button setTitleColor:c11 forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(15)];
        }
    }
}
@end
