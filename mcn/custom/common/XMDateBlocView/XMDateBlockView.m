//
//  XMDateBlockView.m
//  cigarette
//
//  Created by xiao ming on 2019/12/26.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "XMDateBlockView.h"
#import "MSSCalendarViewController.h"
#import "MSSCalendarDefine.h"
#import "STTimeUtil.h"
#import "STWindowUtil.h"
#import "UIButton+Extension.h"

@interface XMDateBlockView()<MSSCalendarViewControllerDelegate>

@property(strong, nonatomic)UIButton *dateButton;
@property(assign, nonatomic)NSUInteger startDate;
@property(assign, nonatomic)NSUInteger endDate;

@end

@implementation XMDateBlockView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]){
        self.userInteractionEnabled = true;
        [self initView];
        self.maxDays = 60;
        _textShowFormat = @"yyyy年MM月dd日";
        _resultFormat = @"yyyy-MM-dd";
    }
    return self;
}

- (void)initView {
    self.dateButton.frame = self.bounds;
    [self.dateButton setImage:[UIImage imageNamed:IMAGE_REFRESH] forState:UIControlStateNormal];
    self.dateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

#pragma mark - < public method >
-(void)setDate:(NSUInteger)startDate endDate:(NSUInteger)endDate {
    self.startDate = startDate;
    self.endDate = endDate;
    NSString *dateString;
    if(startDate == 0 && endDate == 0){
        dateString = @"开始时间-结束时间";
    }else{
         dateString = [NSString stringWithFormat:@"%@-%@",[self dateStringWithInterval:startDate format:self.textShowFormat],[self dateStringWithInterval:endDate format:self.textShowFormat]];
    }
    [self.dateButton setTitle:dateString forState:UIControlStateNormal];
    [self.dateButton imageLayout:ImageLayoutRight centerPadding:5];
}

#pragma mark - < button event >
- (void)dateButtonClick {
    MSSCalendarViewController *cvc = [[MSSCalendarViewController alloc]init];
    cvc.limitMonth = 12 * 5;// 显示几个月的日历
    /*
     MSSCalendarViewControllerLastType 只显示当前月之前
     MSSCalendarViewControllerMiddleType 前后各显示一半
     MSSCalendarViewControllerNextType 只显示当前月之后
     */
    cvc.type = MSSCalendarViewControllerLastType;
    cvc.beforeTodayCanTouch = YES;// 今天之后的日期是否可以点击
    cvc.afterTodayCanTouch = NO;// 今天之前的日期是否可以点击
    cvc.startDate = self.startDate;// 选中开始时间
    cvc.endDate = self.endDate;// 选中结束时间
    /*以下两个属性设为YES,计算中国农历非常耗性能（在5s加载15年以内的数据没有影响）*/
    cvc.showChineseHoliday = YES;// 是否展示农历节日
    cvc.showChineseCalendar = YES;// 是否展示农历
    cvc.showHolidayDifferentColor = YES;// 节假日是否显示不同的颜色
    cvc.showHolidayDifferent = NO;// 节假日是否显示不同的颜色
    cvc.showAlertView = YES;// 是否显示提示弹窗
    cvc.delegate = self;
    cvc.modalPresentationStyle = UIModalPresentationFullScreen;
    [[STWindowUtil currentController] presentViewController:cvc animated:YES completion:nil];
}

#pragma mark - < calendar delegate >
-(void)calendarViewConfirmClickWithStartDate:(NSInteger)startDate endDate:(NSInteger)endDate {
    long currentDays = (endDate - startDate) / (3600 * 24);
    if(currentDays > self.maxDays){
        [LCProgressHUD showMessage:[NSString stringWithFormat:@"最多可选择%lu天内",(unsigned long)self.maxDays]];
        return;
    }
    
    //更新文本
    [self setDateWithInterval:startDate endDate:endDate];
    
    //call back
    if ([self.delegate respondsToSelector:@selector(selectedDateInterval:endDate:)]) {
        NSString *startDateString = [self dateStringWithInterval:startDate format:_resultFormat];
        NSString *endDateString = [self dateStringWithInterval:endDate format:_resultFormat];
        [self.delegate selectedDateInterval:startDateString endDate:endDateString];
    }
}

#pragma mark - < private method >
-(void)setDateWithInterval:(NSInteger)startDate endDate:(NSInteger)endDate {
    [self setDate:startDate endDate:endDate];
}

- (NSString *)dateStringWithInterval:(NSInteger)interval format:(NSString *)formatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat: formatString];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:interval]];
    return dateStr;
}

#pragma mark - < getter >
- (UIButton *)dateButton {
    if (_dateButton == nil) {
        _dateButton = [[UIButton alloc]init];
        [_dateButton setTitleColor:c10 forState:UIControlStateNormal];
        _dateButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(14)];
        [_dateButton addTarget:self action:@selector(dateButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_dateButton];
    }
    return _dateButton;
}

@end
