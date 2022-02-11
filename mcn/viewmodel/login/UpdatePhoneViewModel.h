//
//  UpdatePhoneViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UpdatePhoneViewDelegate<BaseRequestDelegate>

@end


@interface UpdatePhoneViewModel : NSObject

@property(weak, nonatomic)id<UpdatePhoneViewDelegate> delegate;
@property(copy, nonatomic)NSString *phoneNum;

-(void)updateSendVerifyCode;
-(void)updatePhone:(NSString *)verifyCode;
@end



