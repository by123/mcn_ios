//
//  LoginModel.h
//  cigarette
//
//  Created by by.huang on 2019/9/3.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoginModel : NSObject

@property(copy, nonatomic)NSString *Login;
@property(assign, nonatomic)int num;
@property(strong, nonatomic)NSMutableArray *datas;

@end


