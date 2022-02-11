
//
//  PreviewModel.m
//  mcn
//
//  Created by by.huang on 2020/8/21.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "PreviewModel.h"

@implementation PreviewModel

+(PreviewModel *)build:(NSString *)imgUrl imgSrc:(NSString *)imgSrc isSelect:(Boolean)isSelect{
    PreviewModel *model = [[PreviewModel alloc]init];
    model.imgUrl = imgUrl;
    model.imgSrc = imgSrc;
    model.isSelect = isSelect;
    return model;
}

+(PreviewModel *)build:(NSString *)imgUrl imgSrc:(NSString *)imgSrc isSelect:(Boolean)isSelect position:(NSInteger)position{
    PreviewModel *model = [[PreviewModel alloc]init];
    model.imgUrl = imgUrl;
    model.imgSrc = imgSrc;
    model.isSelect = isSelect;
    model.position = position;
    return model;
}
@end
