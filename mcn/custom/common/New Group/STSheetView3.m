//
//  STSheetView1.m
//  cigarette
//
//  Created by by.huang on 2019/9/12.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "STSheetView3.h"

@interface STSheetView3()

@property(strong, nonatomic)NSArray *titles;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)NSMutableArray *contentLabels;

@end

@implementation STSheetView3{
    CGFloat height;
}

-(instancetype)initWithTitles:(NSArray *)titles{
    if(self == [super init]){
        _titles = titles;
        _contentLabels = [[NSMutableArray alloc]init];
        height = STHeight(50) + STHeight(50)*_titles.count;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, height);
    self.backgroundColor = cwhite;
    _titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self addSubview:_titleLabel];
    
 
    
    if(!IS_NS_COLLECTION_EMPTY(_titles)){
        for(int i = 0 ; i < _titles.count ; i ++){
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(50)  * (i+1)-LineHeight, STWidth(345), LineHeight)];
             lineView.backgroundColor = cline;
             [self addSubview:lineView];
            
            UILabel *tLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:_titles[i] textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
            CGSize tSize = [tLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
            tLabel.frame = CGRectMake(STWidth(15),  STHeight(50) * (i+1) , tSize.width, STHeight(50));
            [self addSubview:tLabel];
            
            UILabel *cLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
            [self addSubview:cLabel];
            
            [_contentLabels addObject:cLabel];
        }
    }

}


-(void)updateView:(NSString *)title datas:(NSArray *)datas{
    
    _titleLabel.text = title;
    CGSize titleSize = [_titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_SEMIBOLD];
    _titleLabel.frame = CGRectMake(STWidth(15), 0, titleSize.width, STHeight(50));
    
    if(!IS_NS_COLLECTION_EMPTY(_contentLabels) && _contentLabels.count == datas.count){
        for(int i = 0 ; i < _contentLabels.count ; i ++){
            UILabel *cLabel = _contentLabels[i];
            cLabel.text = datas[i];
            CGSize cSize = [cLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
            cLabel.frame = CGRectMake(ScreenWidth -  STWidth(15) - cSize.width, STHeight(50) * (i+1) , cSize.width, STHeight(50));
        }
    }

}




-(CGFloat)getHeight{
    return height;
}

@end
