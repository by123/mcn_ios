//
//  STBlankInView.h
//  manage
//
//  Created by by.huang on 2018/11/30.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STBlankInViewDelegate<NSObject>

- (void)onTextFieldDidChange:(id)view;

@end

@interface STBlankInView : UIView

@property(weak, nonatomic)id<STBlankInViewDelegate> delegate;
@property(strong, nonatomic)UITextField *contentTF;

-(instancetype)initWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder;

-(instancetype)initWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder frame:(CGRect)frame;

-(void)setContent:(NSString *)content;

-(NSString *)getContent;

-(void)inputDecimalNumber;

-(void)inputNumber;

-(void)setMaxLength:(int)maxLength;

-(BOOL)resign;

-(void)hiddenLine;

@end

