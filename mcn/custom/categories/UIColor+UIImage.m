//
//  UIColor+UIImage.m
//  xiwu_mall
//
//  Created by xiao ming on 2020/3/20.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "UIColor+UIImage.h"

@implementation UIColor (UIImage)

- (UIImage *)imageWithSize:(CGSize)size {
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage *)imageWithRadius:(CGFloat)radius {
    CGRect rect = CGRectMake(0.0f, 0.0f, radius*2, radius*2);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //方式1
    CGContextAddEllipseInRect(context, rect);
    [self set];
    CGContextFillPath(context);//实心
    
    //方式2
//    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
//    CGContextSetFillColorWithColor(context, [self CGColor]);
//    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
