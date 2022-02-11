//
//  AddProductView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProductViewModel.h"


@interface AddProductView : UIView

-(instancetype)initWithViewModel:(AddProductViewModel *)viewModel;
-(void)updateView;
-(void)updatePhotoView;
-(void)updateDetailView;
-(void)updateConfig;
-(void)updateType;

@end

