//
//  ProductImageScrollView.h
//  mcn
//
//  Created by by.huang on 2020/9/2.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ProductImageViewDelegate

-(void)onProductImageLoaded:(CGFloat)height;

@end

@interface ProductImageView : UIView

@property(weak, nonatomic)id<ProductImageViewDelegate> delegate;

-(void)updateView:(NSMutableArray *)datas;

@end

NS_ASSUME_NONNULL_END
