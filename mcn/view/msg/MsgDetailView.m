//
//  MsgDetailView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "MsgDetailView.h"
#import "STTimeUtil.h"

@interface MsgDetailView()

@property(strong, nonatomic)MsgDetailViewModel *mViewModel;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *createTimeLabel;
@property(strong, nonatomic)UILabel *contentLabel;
@property(strong, nonatomic)UIButton *rejectBtn;
@property(strong, nonatomic)UIButton *agreeBtn;
@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)UIView *bottomView;

@end

@implementation MsgDetailView

-(instancetype)initWithViewModel:(MsgDetailViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
        [self updateView];
    }
    return self;
}

-(void)initView{
    _titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self addSubview:_titleLabel];
    
    _createTimeLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(12)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c05 backgroundColor:nil multiLine:NO];
    [self addSubview:_createTimeLabel];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, STHeight(82), ScreenWidth, ContentHeight - STHeight(80) - STHeight(82))];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    _contentLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:YES];
      [_scrollView addSubview:_contentLabel];
    
    [self initBottomView];
}

-(void)initBottomView{
    _bottomView = [[UIView alloc] init];
    _bottomView.frame = CGRectMake(0, ContentHeight - STHeight(80), ScreenWidth, STHeight(80));
    _bottomView.layer.backgroundColor = cwhite.CGColor;
    _bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _bottomView.layer.shadowOffset = CGSizeMake(0,2);
    _bottomView.layer.shadowOpacity = 1;
    _bottomView.layer.shadowRadius = 10;
    [self addSubview:_bottomView];
    
    _rejectBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"拒绝" textColor:c20 backgroundColor:cwhite corner:4 borderWidth:LineHeight borderColor:c20];
    _rejectBtn.frame = CGRectMake(STWidth(15), STHeight(15), STWidth(165), STHeight(50));
    [_rejectBtn addTarget:self action:@selector(onRejectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_rejectBtn];
    
    _agreeBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"同意" textColor:cwhite backgroundColor:c20 corner:4 borderWidth:0 borderColor:nil];
    _agreeBtn.frame = CGRectMake(STWidth(195), STHeight(15), STWidth(165), STHeight(50));
    [_agreeBtn addTarget:self action:@selector(onAgreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_agreeBtn];
}

-(void)updateView{
    MsgModel *model = _mViewModel.model;
    if(model.messageType == MessageType_Express || model.messageType == MessageType_Agree || model.optState == 1){
        _bottomView.hidden = YES;
    }else{
        _bottomView.hidden = NO;
    }
    _titleLabel.text = model.title;
    CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _titleLabel.frame = CGRectMake(STWidth(15), STHeight(15), titleSize.width, STHeight(25));
    
    _createTimeLabel.text = [STTimeUtil generateDate:model.createTime format:MSG_DATE_FORMAT_ALL];
    CGSize createTimeSize = [_createTimeLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(12) fontName:FONT_REGULAR];
    _createTimeLabel.frame = CGRectMake(STWidth(15), STHeight(45), createTimeSize.width, STHeight(17));
    
    _contentLabel.text = model.text;
    CGSize contentSize = [_contentLabel.text sizeWithMaxWidth:STWidth(345) font:STFont(14) fontName:FONT_REGULAR];
    _contentLabel.frame = CGRectMake(STWidth(15), 0, STWidth(345), contentSize.height);
    
    [_scrollView setContentSize:CGSizeMake(ScreenWidth, contentSize.height + STHeight(30))];
    
}

-(void)onRejectBtnClick{
    [_mViewModel requestAgree:NO];
}

-(void)onAgreeBtnClick{
    [_mViewModel requestAgree:YES];
}

@end

