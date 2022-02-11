
//
//  STAddImageViewCell.m
//  mcn
//
//  Created by by.huang on 2020/8/20.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "STAddImageViewCell.h"

@interface STAddImageViewCell()

@property(strong, nonatomic)UIImageView *addImageView;
@property(strong, nonatomic)UIImageView *showImageView;

@end

@implementation STAddImageViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, STHeight(90), STHeight(90))];
    _addBtn.backgroundColor = cwhite;
    _addBtn.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.09].CGColor;
    _addBtn.layer.shadowOffset = CGSizeMake(0,2);
    _addBtn.layer.shadowOpacity = 1;
    _addBtn.layer.shadowRadius = 10;
    [self addSubview:_addBtn];
    
    _showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, STHeight(90), STHeight(90))];
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    _showImageView.clipsToBounds = YES;
    [_addBtn addSubview:_showImageView];
    
    _addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STHeight(31), STHeight(31), STHeight(28), STHeight(28))];
    _addImageView.image = [UIImage imageNamed:IMAGE_IDETIFY_ADD];
    _addImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_addBtn addSubview:_addImageView];
}

-(void)updateData:(PreviewModel *)model{
    if(IS_NS_STRING_EMPTY(model.imgUrl)){
        _addImageView.hidden = NO;
        _showImageView.hidden = YES;
    }else{
        _addImageView.hidden = YES;
        _showImageView.hidden = NO;
        [_showImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    }
}


+(NSString *)identify{
    return NSStringFromClass([STAddImageViewCell class]);
}
@end
