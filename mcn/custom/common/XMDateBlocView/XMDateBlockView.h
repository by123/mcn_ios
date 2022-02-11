//
//  XMDateBlockView.h
//  cigarette
//
//  Created by xiao ming on 2019/12/26.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XMDateBlockViewDelegate<NSObject>

-(void)selectedDateInterval:(NSString *)startDate endDate:(NSString *)endDate;

@end

@interface XMDateBlockView : UIView

@property(weak, nonatomic)id<XMDateBlockViewDelegate> delegate;
@property(assign, nonatomic)NSUInteger maxDays;
@property(strong, nonatomic)NSString *textShowFormat;//文本显示的format
@property(strong, nonatomic)NSString *resultFormat;//返回结果的format

-(void)setDate:(NSUInteger)startDate endDate:(NSUInteger)endDate;

@end

NS_ASSUME_NONNULL_END
