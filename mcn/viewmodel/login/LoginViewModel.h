//
//  LoginViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"


@protocol LoginViewDelegate <BaseRequestDelegate>

-(void)goNextPage;
-(void)onGoAgreementPage;
-(void)onGoVerifyCodePage:(NSString *)phoneNum;

@end

@interface LoginViewModel : NSObject

@property(weak, nonatomic)id<LoginViewDelegate> delegate;


-(void)doLogin:(NSString *)userName psw:(NSString *)password isMessgeLogin:(Boolean)isMessgeLogin;
-(void)goForgetPswPage;
-(void)goAgreementPage;

@end



