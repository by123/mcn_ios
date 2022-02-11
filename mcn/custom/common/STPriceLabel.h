//
//  STPriceLabel.h
//  mcn
//
//  Created by by.huang on 2020/8/19.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STPriceLabel : UIView

-(instancetype)initWithLabel:(double)price color:(UIColor *)color unitSize:(CGFloat)unitSize numberSize:(CGFloat)numberSize unitFontFamily:(NSString *)unitFontFamily numberFontFamily:(NSString *)numberFontFamily;

-(void)updateLabel:(double)price;

@end

NS_ASSUME_NONNULL_END
