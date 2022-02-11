//
//  STSheetView1.h
//  cigarette
//
//  Created by by.huang on 2019/9/12.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STSheetView3 : UIView

-(instancetype)initWithTitles:(NSArray *)titles;
-(void)updateView:(NSString *)title datas:(NSArray *)datas;
-(CGFloat)getHeight;

@end

NS_ASSUME_NONNULL_END
