//
//  STAddImageViewCell.h
//  mcn
//
//  Created by by.huang on 2020/8/20.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreviewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface STAddImageViewCell : UICollectionViewCell

@property(strong, nonatomic)UIButton *addBtn;

-(void)updateData:(PreviewModel *)model;

+(NSString *)identify;

@end

NS_ASSUME_NONNULL_END
