//
//  STNoDataView.m
//  cigarette
//
//  Created by by.huang on 2019/12/9.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "STNoDataView.h"
@interface STNoDataView()

@property(strong, nonatomic)UIImageView *tipImageView;
@property(strong, nonatomic)UILabel *tipLabel;


@end

@implementation STNoDataView

-(instancetype)initWithTitle:(NSString *)title image:(NSString *)imageSrc{
    if(self == [super init]){
        [self initView:title imageSrc:imageSrc];
    }
    return self;
}

-(void)initView:(NSString *)title imageSrc:(NSString *)imageSrc{
    _tipImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - STHeight(100))/2, STHeight(40), STHeight(100), STHeight(100))];
    _tipImageView.image = [UIImage imageNamed:imageSrc];
    _tipImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_tipImageView];
    
    _tipLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(15)] text:title textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:YES];
    CGSize tipSize = [_tipLabel.text sizeWithMaxWidth:STWidth(215) font:STFont(15) fontName:FONT_SEMIBOLD];
    _tipLabel.frame = CGRectMake((ScreenWidth - STWidth(215))/2, STHeight(150), STWidth(215), tipSize.height);
    [self addSubview:_tipLabel];
}


-(void)setImageHeight:(CGFloat)height{
    _tipImageView.frame = CGRectMake((ScreenWidth - STHeight(100))/2, height, STHeight(100), STHeight(100));
    CGSize tipSize = [_tipLabel.text sizeWithMaxWidth:STWidth(215) font:STFont(15) fontName:FONT_SEMIBOLD];
    _tipLabel.frame = CGRectMake((ScreenWidth - STWidth(215))/2, height + STHeight(110), STWidth(215), tipSize.height);
}
@end
