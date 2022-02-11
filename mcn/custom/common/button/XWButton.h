//
//  XWButton.h
//  cigarette
//
//  Created by by.huang on 2020/1/10.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,XWButtonType){
    XWButtonType_Positive = 0,
    XWButtonType_Negative
};

NS_ASSUME_NONNULL_BEGIN

@interface XWButton : UIButton

-(instancetype)initWithTitle:(NSString *)titleStr type:(XWButtonType)type;
-(void)setDisable:(Boolean)disable;
-(void)setFontSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END


