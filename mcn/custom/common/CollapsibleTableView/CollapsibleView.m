//
//  CollapsibleView.m
//  TreasureChest
//
//  Created by xiao ming on 2019/12/19.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import "CollapsibleView.h"
#import "CollapsibleViewCell.h"
#import "CollapsibleViewModel.h"
#import "ReactiveObjC.h"
#import "UIView+Extension.h"
#import "CollapsibleTableView.h"

@interface CollapsibleView()<CollapsibleTableViewDelegate>

@property(strong, nonatomic)CollapsibleViewModel *viewModel;

@property(strong, nonatomic)UIButton *hideButton;
@property(strong, nonatomic)UIView *containerView;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)CollapsibleTableView *tableView;
@property(strong, nonatomic)UIButton *confirmButton;
@property(strong, nonatomic)UIButton *resetButton;
@property(assign, nonatomic)Boolean isOrder;

@end

@implementation CollapsibleView

- (instancetype)initWithSubMchType:(int)type isOrder:(Boolean)isOrder{
    if(self == [super init]){
        [self initView];
        
        _viewModel = [[CollapsibleViewModel alloc]init];
        _viewModel.subMchType = type;
        _viewModel.isOrder = isOrder;
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [_viewModel requestRootItemsData];
    
    @weakify(self);
    [[RACObserve(self.viewModel, rootItems) ignore:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.tableView.rootItems = self.viewModel.rootItems;
    }];
}

#pragma mark - < delegate >
- (void)requestSubDataForTargetModel:(CollapsibleModel *)targetModel {
    [_viewModel requestSubDataForTargetModel:targetModel];
}

#pragma mark - < button event >
- (void)hideBtnClick {
    [self startWithAnimation:false];
}

- (void)confirmBtnClick {
    if ([self.delegate respondsToSelector:@selector(collapsibleViewSelectedItem:)]) {
        [self.delegate collapsibleViewSelectedItem:self.tableView.selectedItem];
        [self hideBtnClick];
    }
}

- (void)resetBtnClick {
    if ([self.delegate respondsToSelector:@selector(collapsibleViewSelectedItem:)]) {
        [self.delegate collapsibleViewSelectedItem:nil];
        [self hideBtnClick];
    }
}

- (void)startWithAnimation:(BOOL)show {
    if (show) {
        self.hideButton.hidden = true;
        self.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        } completion:^(BOOL finished) {
            self.hideButton.hidden = false;
        }];
    }else {
        self.hideButton.hidden = true;
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
        }];
    }
}

- (void)congfigStockTypeBtnText:(NSString *)text {
    [self.resetButton setTitle:text forState:UIControlStateNormal];
}

#pragma mark - < init view >
- (void)initView {
    
    CGFloat rightViewWidth = ScreenWidth-STWidth(60);

    self.hideButton.frame = CGRectMake(0, 0, STWidth(60), ScreenHeight);
    self.containerView.frame = CGRectMake(STWidth(60), 0, rightViewWidth, ScreenHeight);
    
    //table area
    self.tableView.delegate = self;
    self.tableView.frame = CGRectMake(0, STHeight(80), rightViewWidth, CGRectGetHeight(_containerView.frame)-STHeight(80*2));
    
    
    //title area
    UIView *labelContainerView = [[UIView alloc]init];
    labelContainerView.backgroundColor = cwhite;
    labelContainerView.frame = CGRectMake(0, 0, rightViewWidth, STHeight(80));
    [self.containerView addSubview:labelContainerView];
    labelContainerView.layer.shadowOffset = CGSizeMake(0, 1);
    labelContainerView.layer.shadowRadius = 4;
    labelContainerView.layer.shadowOpacity = 0.1;
    labelContainerView.layer.shadowColor = c10.CGColor;
    
    [labelContainerView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(STWidth(20), STHeight(36), STWidth(80), STHeight(25));
    
    
    //button area
    UIView *buttonContainerView = [[UIView alloc]init];
    buttonContainerView.backgroundColor = cwhite;
    buttonContainerView.frame = CGRectMake(0, ScreenHeight - STHeight(80), rightViewWidth, STHeight(80));
    [self.containerView addSubview:buttonContainerView];
    buttonContainerView.layer.shadowOffset = CGSizeMake(0, 1);
    buttonContainerView.layer.shadowRadius = 4;
    buttonContainerView.layer.shadowOpacity = 0.2;
    buttonContainerView.layer.shadowColor = c10.CGColor;
    
    [buttonContainerView addSubview:self.resetButton];
    self.resetButton.frame = CGRectMake(0, 0, STWidth(103), STHeight(40));
    self.resetButton.right = buttonContainerView.width/2.0 - STWidth(7);
    self.resetButton.centerY = buttonContainerView.height/2.0;
    
    [buttonContainerView addSubview:self.confirmButton];
    self.confirmButton.frame = CGRectMake(0, 0, STWidth(103), STHeight(40));
    self.confirmButton.x = buttonContainerView.width/2.0 + STWidth(7);
    self.confirmButton.centerY = buttonContainerView.height/2.0;
}

- (UIButton *)hideButton {
    if (_hideButton == nil) {
        _hideButton = [[UIButton alloc]initWithFont:STFont(16) text:@"" textColor:c10 backgroundColor:[STColorUtil colorWithHexString:@"#181920" alpha:0.7] corner:0 borderWidth:0 borderColor:nil];
        [_hideButton addTarget:self action:@selector(hideBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_hideButton];
    }
    return _hideButton;
}

- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc]init];
        _containerView.backgroundColor = cwhite;
        [self addSubview:_containerView];
    }
    return _containerView;
}

- (CollapsibleTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[CollapsibleTableView alloc]init];
        [self.containerView addSubview:_tableView];
    }
    return _tableView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:@"选择下级" textAlignment:NSTextAlignmentLeft textColor:c10 backgroundColor:nil multiLine:NO];
    }
    return _titleLabel;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        _confirmButton = [[UIButton alloc]initWithFont:STFont(16) text:@"确定" textColor:cwhite backgroundColor:c10 corner:1 borderWidth:0 borderColor:nil];
        [_confirmButton addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)resetButton {
    if (_resetButton == nil) {
        _resetButton = [[UIButton alloc]initWithFont:STFont(16) text:@"全部下级" textColor:c10 backgroundColor:cwhite corner:1 borderWidth:0.5 borderColor:c10];
        [_resetButton addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}


@end
