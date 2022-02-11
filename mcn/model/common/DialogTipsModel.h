//
//  DialogTipsModel.h
//  cigarette
//
//  Created by by.huang on 2020/6/23.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DialogTipsModel : NSObject

@property(copy, nonatomic)NSString *title;
@property(copy, nonatomic)NSString *content;
@property(assign, nonatomic)long expire;
@property(copy, nonatomic)NSString *btn_cancel;
@property(copy, nonatomic)NSString *btn_confirm;
@property(copy, nonatomic)NSString *ios;

@end

NS_ASSUME_NONNULL_END
