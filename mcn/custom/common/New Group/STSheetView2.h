//
//  STSheetView2.h
//  cigarette
//
//  Created by by.huang on 2019/9/12.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STSheetView2 : UIView

-(instancetype)initWithTitles:(NSArray *)titles itemTitles:(NSArray *)itemTitles titleStyle:(TitlStyle)style;
-(void)updateView:(NSMutableArray *)titleDatas contentDatas:(NSMutableArray *)contentDatas;
-(CGFloat)getHeight;

- (void)fixLineWidth:(CGFloat)width;

-(void)updateTitleKeyLabel:(NSArray *)titles;
-(void)updateContentKeyLabel:(NSArray *)itemTitles;

-(void)updateTitleKeyLabels:(NSString *)fontName color:(UIColor *)textColor;
-(void)updateTitleLabels:(NSString *)fontName color:(UIColor *)textColor;//分割线以上，右侧

-(void)updateAllContentLabels:(NSString *)fontName color:(UIColor *)textColor;//分割线以下
@end

NS_ASSUME_NONNULL_END
