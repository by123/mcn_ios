//
//  EasyAlertView.m
//  TreasureChest
//
//  Created by xiao ming on 2020/3/27.
//  Copyright © 2020 xiao ming. All rights reserved.
//

#import "EasyAlertView.h"
#import "UIImageView+LBBlurredImage.h"

@interface EasyAlertView ()

@property(nonatomic, strong)UIButton *blackViewButton;

@end

@implementation EasyAlertView

- (instancetype)init {
    if(self == [super init]){
        self.userInteractionEnabled = true;
        [self addSubview:self.blackViewButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.blackViewButton.frame = self.bounds;
}

- (void)showBlurView:(UIView *)view {
    UIImage *image = [self imageFromView:view];
    [self setImageToBlur:image blurRadius:1 completionBlock:nil];
}

#pragma mark - < event >
- (void)backButtonEvent {
    [self removeFromSuperview];
}

#pragma mark - < init >
- (UIButton *)blackViewButton {
    if (_blackViewButton == nil) {
        _blackViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _blackViewButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [_blackViewButton addTarget:self action:@selector(backButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_blackViewButton];
    }
    return _blackViewButton;
}

-(UIImage *)imageFromView:(UIView *)view{
    CGSize size = view.bounds.size;
    //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
