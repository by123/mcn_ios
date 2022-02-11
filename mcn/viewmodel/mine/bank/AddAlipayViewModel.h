//
//  AddAlipayViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddAlipayViewDelegate<BaseRequestDelegate>

@end


@interface AddAlipayViewModel : NSObject

@property(weak, nonatomic)id<AddAlipayViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)addAlipay:(NSString *)account name:(NSString *)name;

@end



