//
//  UIColor+UIImage.h
//  xiwu_mall
//
//  Created by xiao ming on 2020/3/20.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (UIImage)

///矩形
- (UIImage *)imageWithSize:(CGSize)size;

///圆形
- (UIImage *)imageWithRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
