//
//  PwdTextfieldView.h
//  cigarette
//
//  Created by xiao ming on 2019/12/16.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PwdTextfieldView : UIView
@property(strong, nonatomic)NSString *text;
- (instancetype)initWithTitle:(NSString *)title placehold:(NSString *)placehold;
@end

NS_ASSUME_NONNULL_END
