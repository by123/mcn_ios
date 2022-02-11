//
//  STImageTipsView.h
//  cigarette
//
//  Created by by.huang on 2019/11/28.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STImageTipsView : UIView

@property(assign, nonatomic)CGFloat height;
@property(assign, nonatomic)CGFloat width;

-(instancetype)initWithTitle:(NSString *)titleStr top:(Boolean)top;
-(void)setTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
