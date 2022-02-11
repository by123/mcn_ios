//
//  VerifyCodeViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VerifyCodeViewDelegate<BaseRequestDelegate>

@end


@interface VerifyCodeViewModel : NSObject

@property(weak, nonatomic)id<VerifyCodeViewDelegate> delegate;
@property(copy, nonatomic)NSString *phoneNum;
@property(assign, nonatomic)Boolean updatePhone;

-(void)sendVerifyCode;
-(void)verifyCode:(NSString *)verifyCode;

-(void)updateSendVerifyCode;
-(void)updateVerifyCode:(NSString *)verifyCode;

@end



