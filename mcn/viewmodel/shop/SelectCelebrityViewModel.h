//
//  SelectCelebrityViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CelebrityParamModel.h"
#import "CelebrityModel.h"

@protocol SelectCelebrityViewDelegate<BaseRequestDelegate>

-(void)onBackCooperationPage:(NSMutableArray *)celebrityDatas;

@end


@interface SelectCelebrityViewModel : NSObject

@property(strong, nonatomic)CelebrityParamModel *celebrityModel;
@property(weak, nonatomic)id<SelectCelebrityViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)requestList;
-(void)backCooperationPage:(NSMutableArray *)celebrityDatas;

@end



