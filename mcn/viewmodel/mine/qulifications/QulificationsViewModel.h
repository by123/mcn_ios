//
//  QulificationsViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QulificationsViewDelegate<BaseRequestDelegate>

-(void)onGoQulificationsEditPage:(RoleType)roleType;

@end


@interface QulificationsViewModel : NSObject

@property(weak, nonatomic)id<QulificationsViewDelegate> delegate;

-(void)goQulificationsEditPage:(RoleType)roleType;

@end



