//
//  StatisticsChannelItemCell.m
//  mcn
//
//  Created by by.huang on 2020/9/11.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "StatisticsChannelItemCell.h"

@interface StatisticsChannelItemCell()

@property(strong, nonatomic)UILabel *productNameLabel;
@property(strong, nonatomic)UILabel *productTotalLabel;

@end

@implementation StatisticsChannelItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{
  
    _productNameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_productNameLabel];
    
    
    _productTotalLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c45 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_productTotalLabel];
    

}

-(void)updateData:(CooperateSkuModel *)model{
    
    _productNameLabel.text = model.spuName;
    CGSize productNameSize = [_productNameLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _productNameLabel.frame = CGRectMake(STWidth(15), 0, productNameSize.width, STHeight(21));
    
    _productTotalLabel.text = [NSString stringWithFormat:@"%.2f",model.total / 100];
    CGSize productTotalSize = [_productTotalLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _productTotalLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - productTotalSize.width, 0, productTotalSize.width, STHeight(21));
 
}


+(NSString *)identify{
    return NSStringFromClass([StatisticsChannelItemCell class]);
}

@end


