//
//  ProductDetailView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailViewModel.h"

@interface ProductDetailView : UIView

-(instancetype)initWithViewModel:(ProductDetailViewModel *)viewModel;
-(void)updateView;


@end

