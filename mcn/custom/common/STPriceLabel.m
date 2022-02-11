//
//  STPriceLabel.m
//  mcn
//
//  Created by by.huang on 2020/8/19.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "STPriceLabel.h"

@interface STPriceLabel()

@property(strong, nonatomic)UILabel *unitLabel;
@property(strong, nonatomic)UILabel *numberLabel;
@property(strong, nonatomic)UIColor *color;
@property(assign, nonatomic)CGFloat unitSize;
@property(assign, nonatomic)CGFloat numberSize;
@property(copy, nonatomic)NSString *unitFontFamily;
@property(copy, nonatomic)NSString *numberFontFamily;
@property(assign, nonatomic)double price;

@end

@implementation STPriceLabel

-(instancetype)initWithLabel:(double)price color:(UIColor *)color unitSize:(CGFloat)unitSize numberSize:(CGFloat)numberSize unitFontFamily:(NSString *)unitFontFamily numberFontFamily:(NSString *)numberFontFamily{
    if(self == [super init]){
        _price = price;
        _color = color;
        _unitSize = unitSize;
        _numberSize = numberSize;
        _unitFontFamily = unitFontFamily;
        _numberFontFamily = numberFontFamily;
        [self initView];
    }
    return self;
}

-(void)initView{
    _unitLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:_unitFontFamily size:_unitSize] text:MSG_UNIT textAlignment:NSTextAlignmentCenter textColor:_color backgroundColor:nil multiLine:NO];
    CGSize unitSize = [_unitLabel.text sizeWithMaxWidth:ScreenWidth font:_unitSize fontName:_unitFontFamily];
    _unitLabel.frame = CGRectMake(0, _numberSize - _unitSize -1, unitSize.width, _unitSize);
    [self addSubview:_unitLabel];
    
    _numberLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:_numberFontFamily size:_numberSize] text:[NSString stringWithFormat:@"%.2f",_price] textAlignment:NSTextAlignmentCenter textColor:_color backgroundColor:nil multiLine:NO];
    CGSize numberSize = [_numberLabel.text sizeWithMaxWidth:ScreenWidth font:_numberSize fontName:_numberFontFamily];
    _numberLabel.frame = CGRectMake(unitSize.width + STWidth(5), 0, numberSize.width, _numberSize);
    [self addSubview:_numberLabel];
    
    self.frame = CGRectMake(0, 0, unitSize.width + numberSize.width + STWidth(5), _numberSize);
}

-(void)updateLabel:(double)price{
    _price = price;
    _numberLabel.text = [NSString stringWithFormat:@"%.2f",_price / 100];
    CGSize unitSize = [_unitLabel.text sizeWithMaxWidth:ScreenWidth font:_unitSize fontName:_unitFontFamily];
    CGSize numberSize = [_numberLabel.text sizeWithMaxWidth:ScreenWidth font:_numberSize fontName:_numberFontFamily];
    _numberLabel.frame = CGRectMake(unitSize.width, 0, numberSize.width, _numberSize);

}

@end
