//
//  XWBottomButton.h
//  cigarette
//
//  Created by by.huang on 2020/1/13.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWBottomButton : UIView

- (instancetype)initWithTitle:(NSString *)titleStr;
- (void)setDisable:(Boolean)disable;
- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)setButtonFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
