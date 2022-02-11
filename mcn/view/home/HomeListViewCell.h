//
//  HomeListViewCell.h
//  mcn
//
//  Created by by.huang on 2020/8/19.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeListViewCell : UICollectionViewCell

@property(strong, nonatomic)UIButton *cooperationBtn;

-(void)updateData:(ProductModel *)model;

+(NSString *)identify;

@end

NS_ASSUME_NONNULL_END
