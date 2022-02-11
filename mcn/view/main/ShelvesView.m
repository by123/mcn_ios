//
//  ShelvesView.m
//  mcn
//
//  Created by by.huang on 2020/8/20.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "ShelvesView.h"
#import "STPageView.h"
#import "ShelvesListView.h"

@interface ShelvesView()<STPageViewDelegate>
@property(strong, nonatomic)MainViewModel *mainVM;
@property(strong, nonatomic)STPageView *pageView;
@property(strong, nonatomic)ShelvesListView *groudingView; //上架
@property(strong, nonatomic)ShelvesListView *undercarriageView; //下架
@property(strong, nonatomic)ShelvesListView *examineView; //审核中

@end

@implementation ShelvesView

-(instancetype)initWithViewModel:(MainViewModel *)mainVM{
    if(self == [super init]){
        _mainVM = mainVM;
        [self initView];
    }
    return self;
}

-(void)initView{
    UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(25)] text:@"货架管理" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(25) fontName:FONT_SEMIBOLD];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(59), titleSize.width, STHeight(36));
    [self addSubview:titleLabel];
    
    UIButton *addBtn = [[UIButton alloc]initWithFont:STFont(12) text:@"添加商品" textColor:cwhite backgroundColor:c16 corner:4 borderWidth:0 borderColor:nil];
    addBtn.frame = CGRectMake(ScreenWidth - STWidth(85), STHeight(63), STWidth(70), STHeight(32));
    [addBtn addTarget:self action:@selector(onAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];

    CGFloat homeHeight = 0;
    if (@available(iOS 11.0, *)) {
        homeHeight = HomeIndicatorHeight;
    } else {
        homeHeight = 0;
    }
    
    
    CGFloat titleHeight = STHeight(107);
    CGFloat otherHeight = titleHeight + STHeight(62) + homeHeight;
    
    NSMutableArray *views = [[NSMutableArray alloc]init];
    _groudingView = [[ShelvesListView alloc]initWithType:ShelvesType_Grouding];
    _groudingView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - STHeight(38) - otherHeight);
    [views addObject:_groudingView];
    
    _undercarriageView = [[ShelvesListView alloc]initWithType:ShelvesType_Undercarriage];
      _undercarriageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - STHeight(38) - otherHeight);
     [views addObject:_undercarriageView];
    
    _examineView = [[ShelvesListView alloc]initWithType:ShelvesType_Examine];
     _examineView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - STHeight(38) - otherHeight);
    [views addObject:_examineView];
    
    _pageView = [[STPageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - otherHeight) views:views titles:@[@"已上架",@"未上架",@"审核中"] perLine:0.6F perWidth:STWidth(80)];
    _pageView.frame = CGRectMake(0, titleHeight, ScreenWidth, ScreenHeight - otherHeight);
    _pageView.delegate = self;
    [self addSubview:_pageView];
    
    
}

-(void)positionTab:(ShelvesType)shelvesType{
    if(shelvesType == ShelvesType_Grouding){
        [_pageView setCurrentTab:0];
    }else if(shelvesType == ShelvesType_Undercarriage){
        [_pageView setCurrentTab:1];
    }else{
        [_pageView setCurrentTab:2];
    }
}

-(void)onPageViewSelect:(NSInteger)position view:(id)view{
    if(position == 0){
        [_groudingView refreshNew];
    }else if(position == 1){
        [_undercarriageView refreshNew];
    }else{
        [_examineView refreshNew];
    }
}

-(void)onAddBtnClick{
    [_mainVM goAddProductPage];
}


@end
