//
//  SettingViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingModel.h"

@protocol SettingViewDelegate<BaseRequestDelegate>

-(void)onLogout;
-(void)onGoChangeAccountPage;
-(void)onGoNextPage:(NSInteger)position;

@end


@interface SettingViewModel : NSObject

@property(weak, nonatomic)id<SettingViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)logout;
-(void)goNextPage:(NSInteger)position;
-(void)goChangeAccountPage;

@end



