//
//  STSheetView2.m
//  cigarette
//
//  Created by by.huang on 2019/9/12.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "STSheetView2.h"

@interface STSheetView2()

@property(strong, nonatomic)NSArray *titles;
@property(strong, nonatomic)NSArray *itemTitles;

@property(strong, nonatomic)UIView *lineView;

@property(strong, nonatomic)NSMutableArray *titleKeyLabels;
@property(strong, nonatomic)NSMutableArray *titleLabels;

@property(strong, nonatomic)NSMutableArray *contentKeyLabels;
@property(strong, nonatomic)NSMutableArray *contentLabels;

@property(assign, nonatomic)TitlStyle style;

@end

@implementation STSheetView2{
    CGFloat height;
}

-(instancetype)initWithTitles:(NSArray *)titles itemTitles:(NSArray *)itemTitles titleStyle:(TitlStyle)style{
    if(self == [super init]){
        _titles = titles;
        _itemTitles = itemTitles;
        _style = style;
        _titleKeyLabels = [[NSMutableArray alloc]init];
        _titleLabels = [[NSMutableArray alloc]init];
        _contentLabels = [[NSMutableArray alloc]init];
        _contentKeyLabels = [[NSMutableArray alloc]init];
        height = [self fixedHeight];
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, height);
    self.backgroundColor = cwhite;
        
    if(!IS_NS_COLLECTION_EMPTY(_titles)){
        for(int i = 0 ; i < _titles.count ; i ++){
            UILabel *titleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(14)] text:_titles[i] textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
            CGSize titleSize = [titleLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_SEMIBOLD];
            titleLabel.frame = CGRectMake(STWidth(15),STHeight(15) + STHeight(35) * i, titleSize.width, STHeight(20));
            [self addSubview:titleLabel];
            
            UILabel *tLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:(_style == TitlStyle_Semibold  ? FONT_SEMIBOLD : FONT_REGULAR) size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
            [self addSubview:tLabel];
            
            [_titleKeyLabels addObject:titleLabel];
            [_titleLabels addObject:tLabel];
        }
    }
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(15) + STHeight(35) * _titles.count -LineHeight, STWidth(345), LineHeight)];
    _lineView.backgroundColor = cline;
    [self addSubview:_lineView];
    
    if(!IS_NS_COLLECTION_EMPTY(_itemTitles)){
        for(int i = 0 ; i < _itemTitles.count ; i ++){
            UILabel *itemTitleLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:_itemTitles[i] textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
            CGSize itemTitleSize = [itemTitleLabel.text sizeWithMaxWidth:(ScreenWidth - STWidth(15)*2) font:STFont(14) fontName:FONT_REGULAR];
            itemTitleLabel.frame = CGRectMake(STWidth(15),STHeight(30) + STHeight(35) * _titles.count + STHeight(35) * i, itemTitleSize.width, STHeight(20));
            itemTitleLabel.numberOfLines = 0;
            itemTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [self addSubview:itemTitleLabel];
            [_contentKeyLabels addObject:itemTitleLabel];
            
            UILabel *cLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(14)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:(_style == TitlStyle_Semibold ? c11 : c10) backgroundColor:nil multiLine:NO];
            [self addSubview:cLabel];
            [_contentLabels addObject:cLabel];
        }
    }
    
}

-(void)updateView:(NSMutableArray *)titleDatas contentDatas:(NSMutableArray *)contentDatas{
    if(!IS_NS_COLLECTION_EMPTY(titleDatas) && titleDatas.count == _titleLabels.count){
        for(int i = 0; i < _titleLabels.count ; i ++){
            UILabel *tLabel = _titleLabels[i];
            tLabel.text = titleDatas[i];
            CGSize tSize = [tLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_SEMIBOLD];
            tLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - tSize.width,STHeight(15) + STHeight(35) * i, tSize.width, STHeight(20));
        }
    }
    
    if(!IS_NS_COLLECTION_EMPTY(contentDatas) && contentDatas.count == _contentLabels.count){
        for(int i = 0; i < _contentLabels.count ; i ++){
            UILabel *cLabel = _contentLabels[i];
            cLabel.text = contentDatas[i];
            CGSize cSize = [cLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(14) fontName:FONT_REGULAR];
            cLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - cSize.width,STHeight(30) + STHeight(35) * _titleLabels.count + STHeight(35) * i, cSize.width, STHeight(20));
        }
    }
}

-(CGFloat)getHeight{
    return height;
}

-(CGFloat)fixedHeight {
    return STHeight(30) + STHeight(35) * (_titles.count + _itemTitles.count);
}

#pragma mark - 新增
- (void)fixLineWidth:(CGFloat)width {
    CGRect lineFrame = _lineView.frame;
    lineFrame.size.width = width;
    _lineView.frame = lineFrame;
}

-(void)updateTitleKeyLabel:(NSArray *)titles {
    for (int i = 0; i<titles.count; i++) {
        NSString *title = titles[i];
        UILabel *label = self.titleKeyLabels[i];
        label.text = title;
    }
}

-(void)updateContentKeyLabel:(NSArray *)itemTitles {
    height = [self fixedHeight];
    for (int i = 0; i<itemTitles.count; i++) {
        NSString *title = itemTitles[i];
        UILabel *label = self.contentKeyLabels[i];
        label.text = title;
        
        CGSize cSize = [title sizeWithMaxWidth:(ScreenWidth - STWidth(15)*2) font:STFont(14) fontName:FONT_REGULAR];
        CGRect oldFrame = label.frame;
        oldFrame.size.width = cSize.width;
        
        CGFloat newHeight = ceil(cSize.height / STHeight(20)) * STHeight(20);
        oldFrame.size.height = newHeight;
        label.frame = oldFrame;
        
        height += (newHeight - STHeight(20));
    }
}

-(void)updateTitleLabels:(NSString *)fontName color:(UIColor *)textColor {
//    for (UILabel *label in _titleLabels) {
//        label.textColor = textColor;
//        label.font = [UIFont fontWithName:fontName size:STFont(14)];
//    }
    [self updateLabels:_titleLabels fontName:fontName color:textColor];
}

-(void)updateTitleKeyLabels:(NSString *)fontName color:(UIColor *)textColor {
    [self updateLabels:_titleKeyLabels fontName:fontName color:textColor];
}

-(void)updateAllContentLabels:(NSString *)fontName color:(UIColor *)textColor {
    [self updateLabels:_contentKeyLabels fontName:fontName color:textColor];
    [self updateLabels:_contentLabels fontName:fontName color:textColor];
}

- (void)updateLabels:(NSMutableArray *)labels fontName:(NSString *)fontName color:(UIColor *)textColor {
    for (UILabel *label in labels) {
        label.textColor = textColor;
        label.font = [UIFont fontWithName:fontName size:STFont(14)];
    }
}

@end
