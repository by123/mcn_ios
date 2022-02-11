//
//  ResidentScrollView.m
//  TreasureChest
//
//  Created by ming on 2019/12/7.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import "ResidentScrollView.h"
#import <Masonry/Masonry.h>
#import "ReactiveObjC.h"

@interface ResidentScrollView()<UIScrollViewDelegate>

@property(strong, nonatomic)UIView *headerView;
@property(strong, nonatomic)UITableView *tableView;
@property(assign, nonatomic)CGFloat residentHeight;

@end

@implementation ResidentScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = true;
        self.scrollEnabled = false;
        self.delegate = self;
        [self initView];
    }
    return self;
}

- (void)showResident:(UITableView *)contentView headerView:(UIView *)headerView residentFromHeight:(CGFloat)height {

    self.headerView = headerView;
    self.tableView = contentView;
    self.residentHeight = height;
    
    [self addSubview:self.tableView];
    [self addSubview:self.headerView];
    
    //contentView的frame重新计算
    CGFloat contentViewHeight = CGRectGetHeight(self.frame) - CGRectGetHeight(headerView.frame) + height;
    contentView.frame = CGRectMake(0, CGRectGetHeight(headerView.frame), CGRectGetWidth(self.frame), contentViewHeight);

    CGFloat pointY = CGRectGetMaxY(contentView.frame);
    self.contentSize = CGSizeMake(self.frame.size.width, pointY);

    [self bindViewModel];
}

- (void)initView {
}

- (void)bindViewModel
{
    @weakify(self);
    [RACObserve(self.tableView, contentOffset) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        CGPoint newOffset = [x CGPointValue];
        if (newOffset.x == 0 && newOffset.y == 0) {
            return ;
        }
        
        if (self.contentOffset.y >= self.residentHeight) {
            if (newOffset.y > 0) {
            }else{
                self.tableView.contentOffset = CGPointZero;
                CGPoint offset = self.contentOffset;
                self.contentOffset = CGPointMake(offset.x, offset.y + newOffset.y);
            }
        }else {
            //偏移量【0~residentHeight】之间的区域
            CGPoint offset = self.contentOffset;
            CGFloat suitableY = offset.y + newOffset.y;
            suitableY = MIN(suitableY, self.residentHeight);
            suitableY = MAX(0, suitableY);
            self.contentOffset = CGPointMake(offset.x, suitableY);
            
            if ((self.contentOffset.y + newOffset.y) >= self.residentHeight) {
                
            }else {
                if (self.contentOffset.y == 0 && newOffset.y < 0) {
                    
                }else {
                    self.tableView.contentOffset = CGPointZero;
                }
            }
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f",scrollView.contentOffset.y);
}

-(void)setResidentHeight:(CGFloat)height{
    _residentHeight = height;
}
@end
