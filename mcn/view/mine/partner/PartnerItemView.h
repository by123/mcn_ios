//
//  PartnerItemView.h
//  mcn
//
//  Created by by.huang on 2020/9/6.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartnerViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PartnerItemView : UIView

-(instancetype)initWithType:(PartnerType)parterType vm:(PartnerViewModel *)vm;
-(void)refreshNew;

@end

NS_ASSUME_NONNULL_END
