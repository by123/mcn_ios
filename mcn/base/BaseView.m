//
//  BaseView.m
//  cigarette
//
//  Created by by.huang on 2019/12/2.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "BaseView.h"

@interface BaseView()

@property(strong, nonatomic)UITextField *firstResponderTF;
@property(assign, nonatomic)CGFloat y;

@end

@implementation BaseView


- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}



- (void)dealloc{
    //移除键盘通知监听者
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma maek UITextFieldDelegate
-(void)setFirstResponderTF:(UITextField *)textField{
    _firstResponderTF = textField;//当将要开始编辑的时候，获取当前的textField
}

- (void)keyboardWillShow:(NSNotification *)notification{
    _y = self.frame.origin.y;
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGRect rect = [weakSelf.firstResponderTF.superview convertRect:weakSelf.firstResponderTF.frame toView:weakSelf];//获取相对于self的位置
        NSDictionary *userInfo = [notification userInfo];
        NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];//获取弹出键盘的fame的value值
        CGRect keyboardRect = [aValue CGRectValue];
        keyboardRect = [weakSelf convertRect:keyboardRect fromView:weakSelf.window];//获取键盘相对于self的frame ，传window和传nil是一样的
        CGFloat keyboardTop = keyboardRect.origin.y;
        NSNumber * animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];//获取键盘弹出动画时间值
        NSTimeInterval animationDuration = [animationDurationValue doubleValue];
        if (keyboardTop < CGRectGetMaxY(rect)) {//如果键盘盖住了输入框
            CGFloat gap = keyboardTop - CGRectGetMaxY(rect) - 10;//计算需要网上移动的偏移量（输入框底部离键盘顶部为10的间距）
            [UIView animateWithDuration:animationDuration animations:^{
                weakSelf.frame = CGRectMake(weakSelf.frame.origin.x, gap, weakSelf.frame.size.width, weakSelf.frame.size.height);
            }];
        }
    });
}


- (void)keyboardWillHide:(NSNotification *)notification{
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *userInfo = [notification userInfo];
        NSNumber * animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];//获取键盘隐藏动画时间值
        NSTimeInterval animationDuration = [animationDurationValue doubleValue];
        [UIView animateWithDuration:animationDuration animations:^{
            weakSelf.frame = CGRectMake(weakSelf.frame.origin.x, weakSelf.y, weakSelf.frame.size.width, weakSelf.frame.size.height);
        }];
    });

}

@end
