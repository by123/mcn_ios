//
//  STDateBlockView.m
//  manage
//
//  Created by by.huang on 2019/6/18.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "STDateBlockView.h"
#import "MSSCalendarViewController.h"
#import "MSSCalendarDefine.h"
#import "STTimeUtil.h"

@interface STDateBlockView()<MSSCalendarViewControllerDelegate>

@property(strong, nonatomic)UILabel *startDateLabel;
@property(strong, nonatomic)UILabel *endDateLabel;
@property(strong, nonatomic)UILabel *tempLabel;
@property(strong, nonatomic)UIImageView *startDateImageView;
@property(strong, nonatomic)UIImageView *endDateImageView;

@property(strong, nonatomic)UIViewController *controller;
@property(assign, nonatomic)int maxDays;

@property(assign, nonatomic)long startDate;
@property(assign, nonatomic)long endDate;

@end

@implementation STDateBlockView


-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

-(void)initView{

    [self addTarget:self action:@selector(onDateBlockBtnClick) forControlEvents:UIControlEventTouchUpInside];

    _startDateLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self addSubview:_startDateLabel];
    
    _endDateLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)]  text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self addSubview:_endDateLabel];
    
    _tempLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)]  text:@"-" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self addSubview:_tempLabel];
    
    
//    _startDateImageView = [[UIImageView alloc]init];
//    _startDateImageView.image = [UIImage imageNamed:IMAGE_REFRESH];
//    _startDateImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self addSubview:_startDateImageView];
    
    _endDateImageView = [[UIImageView alloc]init];
    _endDateImageView.image = [UIImage imageNamed:IMAGE_REFRESH];
    _endDateImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_endDateImageView];
    
    NSString *startTime = [STTimeUtil getLastDates:7 format:[self getFormatString]];
    NSString *endTime = [STTimeUtil generateDate:[STTimeUtil getTimeStampWithDays:0] format:[self getFormatString]];

    _startDate = [STTimeUtil getTimeStamp:[STTimeUtil getLastDates:7 format:MSG_DATE_FORMAT] format:MSG_DATE_FORMAT];
    _endDate = [STTimeUtil getTimeStamp: [STTimeUtil generateDate:[STTimeUtil getCurrentTimeStamp] format:MSG_DATE_FORMAT] format:MSG_DATE_FORMAT];

    [self setDate:startTime endDate:endTime actualStartDate:_startDate actualeEndData:_endDate];
}

-(void)setDate:(NSString *)startDate endDate:(NSString *)endDate actualStartDate:(long)actualStartDate actualeEndData:(long)actualEndDate{
    _startDate = actualStartDate;
    _endDate = actualEndDate;
    
    CGFloat left = 0;
    _startDateLabel.text = startDate;
    
    CGSize startLabelSize = [_startDateLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_SEMIBOLD];
    left += startLabelSize.width;
    _startDateLabel.frame = CGRectMake(0, 0, startLabelSize.width, STHeight(50));
    
//    left += STWidth(5);
//    _startDateImageView.frame =CGRectMake(left, (STHeight(50) - STWidth(13))/2, STWidth(13), STWidth(13));
    
    left += STWidth(2);//STWidth(13) + STWidth(10);
    CGSize tempSize = [_tempLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
    _tempLabel.frame = CGRectMake(left, 0, tempSize.width, STHeight(50));
    
    left += STWidth(10);//STWidth(10) + tempSize.width;
    _endDateLabel.text = endDate;
    CGSize endLabelSize = [_endDateLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_SEMIBOLD];
    _endDateLabel.frame = CGRectMake(left, 0, endLabelSize.width, STHeight(50));

    left += STWidth(5) + endLabelSize.width;
    _endDateImageView.frame =CGRectMake(left, (STHeight(50) - STWidth(13))/2, STWidth(13), STWidth(13));
    
    self.frame = CGRectMake(STWidth(15), self.frame.origin.y, left + STWidth(13), STHeight(50));

}

-(void)setController:(UIViewController *)controller{
    _controller = controller;
}

-(void)onDateBlockBtnClick{
    if(_controller){
        [self onOpenCalendar:_controller];
    }
}


-(void)onOpenCalendar:(UIViewController *)controller{
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
    cvc.startDate = _startDate;// 选中开始时间
    cvc.endDate = _endDate;//  选中结束时间
    /*以下两个属性设为YES,计算中国农历非常耗性能（在5s加载15年以内的数据没有影响）*/
    cvc.showChineseHoliday = YES;// 是否展示农历节日
    cvc.showChineseCalendar = YES;// 是否展示农历
    cvc.showHolidayDifferentColor = YES;// 节假日是否显示不同的颜色
    cvc.showHolidayDifferent = NO;// 节假日是否显示不同的颜色
    cvc.showAlertView = YES;// 是否显示提示弹窗
    cvc.delegate = self;
    cvc.modalPresentationStyle = UIModalPresentationFullScreen;
    [controller presentViewController:cvc animated:YES completion:nil];
}


-(void)setMaxSelectDays:(int)days{
    _maxDays = days;
}

-(void)calendarViewConfirmClickWithStartDate:(NSInteger)startDate endDate:(NSInteger)endDate{
    if(_maxDays > 0){
        long tempData = (endDate - startDate) / (3600 * 24);
        if(tempData > _maxDays){
            [LCProgressHUD showMessage:@"最多可选择31天内"];
            return;
        }
    }
    if(_delegate){
        NSString *startDateStr = [self getDateStringWithInterval:startDate format:[self getFormatString]];
        NSString *endDateStr = [self getDateStringWithInterval:endDate format:[self getFormatString]];
        [self setDate:startDateStr endDate:endDateStr actualStartDate:startDate actualeEndData:endDate];

        startDateStr = [self getDateStringWithInterval:startDate format:@"yyyy-MM-dd"];
        endDateStr = [self getDateStringWithInterval:endDate format:@"yyyy-MM-dd"];
        [_delegate onDateBlockSelected:startDateStr endDate:endDateStr];
    }
}

- (NSString *)getFormatString {
    return @"MM月dd日";
}

- (NSString *)getDateStringWithInterval:(NSInteger)interval format:(NSString *)formatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat: formatString];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:interval]];
    return dateStr;
}
@end
