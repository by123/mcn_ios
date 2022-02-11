//
//  PartnerCelebrityDetailViewCell.h
//  mcn
//
//  Created by by.huang on 2020/9/8.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PartnerCelebrityDetailViewCell : UITableViewCell

@property(strong, nonatomic)UIButton *linkCopyBtn;

-(void)updateData:(ProductModel *)model showLinkView:(Boolean)showLinkView;
+(NSString *)identify;
@end

NS_ASSUME_NONNULL_END
