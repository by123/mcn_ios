//
//  MutableFormsView.m
//  cigarette
//
//  Created by xiao ming on 2019/12/28.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "MutableFormsView.h"


@interface MutableFormsView()
@property(assign, nonatomic)NSInteger topCount;
@property(assign, nonatomic)NSInteger contentCount;
@end

@implementation MutableFormsView

- (instancetype)initWithFrame:(CGRect)frame topCount:(NSInteger)topCount contentCount:(NSInteger)contentCount {
    if(self == [super initWithFrame:frame]){
        self.backgroundColor = cwhite;
        self.layer.masksToBounds = true;
        self.topCount = topCount;
        self.contentCount = contentCount;
        [self initView];
    }
    return self;
}

- (void)initView {
    CGFloat viewWidth = self.width;
    
    _topFormsView = [[FormsView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 0) count:self.topCount];
    [_topFormsView showTopHighlightStyle];
    [self addSubview:_topFormsView];
    
    CGFloat pointY = [_topFormsView formsHeight];
    _formsView = [[FormsView alloc]initWithFrame:CGRectMake(0, pointY, viewWidth, 0) count:self.contentCount];
    _formsView.isTopLineHidden = false;
    [self addSubview:_formsView];
    
    [_formsView.rightBtn  addTarget:self action:@selector(onRightBtnClick) forControlEvents:UIControlEventTouchUpInside];

}

- (CGFloat)formsHeight {
    return [self.topFormsView formsHeight] + [self.formsView formsHeight];
}

//这里是暂时用于刷新topForms数量变化导致formsView的y值不对，应该在赋值top的时候去做。
- (void)refreshPosition {
    CGFloat pointY = [_topFormsView formsHeight];
    CGRect newFrame = _formsView.frame;
    newFrame.origin.y = pointY;
    _formsView.frame = newFrame;
}

-(void)onRightBtnClick{
    if(_delegate){
        [_delegate onFormViewRightBtnClick];
    }
}


@end
