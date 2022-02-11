//
//  CapitalViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CapitalModel.h"

@protocol CapitalViewDelegate<BaseRequestDelegate>

@end


@interface CapitalViewModel : NSObject

@property(weak, nonatomic)id<CapitalViewDelegate> delegate;
@property(strong, nonatomic)CapitalModel *model;
@property(strong, nonatomic)NSMutableArray *datas;
@property(assign, nonatomic)NSInteger current;

-(void)requestCapital;

@end



