//
//  NSString+Extension.m
//  MYSlideViewController
//
//  Created by michael on 2017/6/27.
//  Copyright © 2017年 Michael. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth addributes:(NSDictionary *)attributes
{
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth font:(CGFloat)font
{
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:font];
    CGSize size = [self sizeWithMaxWidth:maxWidth addributes:attributes];
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    return size;
}

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth font:(CGFloat)font fontName:(NSString *)fontName
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont fontWithName:fontName size:font];
    return [self sizeWithMaxWidth:maxWidth addributes:attributes];
}

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth labelFont:(UIFont *)font {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = font;
    CGSize size = [self sizeWithMaxWidth:maxWidth addributes:attributes];
    return CGSizeMake(ceil(size.width), ceil(size.height));
}
@end
