//
//  STNoDataView.h
//  cigarette
//
//  Created by by.huang on 2019/12/9.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STNoDataView : UIView

-(instancetype)initWithTitle:(NSString *)title image:(NSString *)imageSrc;
-(void)setImageHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
