//
//  PreviewViewCell.m
//  mcn
//
//  Created by by.huang on 2020/8/21.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "PreviewViewCell.h"

@interface PreviewViewCell()

@property(strong, nonatomic)UIImageView *showImageView;

@end

@implementation PreviewViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, STHeight(90), STHeight(90))];
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    _showImageView.clipsToBounds = YES;
    [self addSubview:_showImageView];

}

-(void)updateData:(PreviewModel *)model{
    if(!IS_NS_STRING_EMPTY(model.imgUrl)){
        [_showImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    }
    if(model.isSelect){
        _showImageView.layer.borderWidth = 2;
        _showImageView.layer.borderColor = c20.CGColor;
    }else{
        _showImageView.layer.borderWidth = 0;
    }
}


+(NSString *)identify{
    return NSStringFromClass([PreviewViewCell class]);
}
@end
