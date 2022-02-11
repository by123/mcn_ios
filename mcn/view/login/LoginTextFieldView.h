//
//  LoginTextFieldView.h
//  cigarette
//
//  Created by by.huang on 2020/3/6.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginTextFieldViewDelegate

- (void)onTextFieldDidChange:(UITextField *)textField;
- (void)onClearBtnClick:(UIButton *)pswClearBtn;


@end

@interface LoginTextFieldView : UIView

@property(strong, nonatomic)UITextField *textField;
@property(strong, nonatomic)UIButton *pswClearBtn;
@property(weak, nonatomic)id<LoginTextFieldViewDelegate> delegate;


-(instancetype)initWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder;

@end

NS_ASSUME_NONNULL_END
