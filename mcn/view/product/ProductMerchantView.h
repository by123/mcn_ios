//
//  ProductMerchantScrollView.h
//  mcn
//
//  Created by by.huang on 2020/9/2.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProductMerchantViewDelegate

-(void)onProductMerchantViewLoaded:(CGFloat)height;

@end

@interface ProductMerchantView : UIView

@property(weak, nonatomic)id<ProductMerchantViewDelegate> delegate;

-(void)updateView:(ProductModel *)model;

@end

NS_ASSUME_NONNULL_END
