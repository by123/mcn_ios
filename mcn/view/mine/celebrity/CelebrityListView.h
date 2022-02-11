//
//  CelebrityListView.h
//  mcn
//
//  Created by by.huang on 2020/8/31.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CelebrityViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelebrityListView : UIView

-(instancetype)initWithType:(int)type vm:(CelebrityViewModel *)celebrityVM;
-(void)refreshNew;

@end

NS_ASSUME_NONNULL_END
