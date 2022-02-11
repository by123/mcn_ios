//
//  ProductImageScrollView.m
//  mcn
//
//  Created by by.huang on 2020/9/2.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "ProductImageView.h"

@interface ProductImageView()

@property(assign, nonatomic)CGFloat dynamicHeight;

@end

@implementation ProductImageView

-(instancetype)init{
    if(self == [super init]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = cwhite;
}

-(void)updateView:(NSMutableArray *)datas{
    if(!IS_NS_COLLECTION_EMPTY(datas)){
        for(int i = 0 ; i < datas.count; i ++){
            UIImageView *showImageView = [[UIImageView alloc]init];
            WS(weakSelf)
            [showImageView sd_setImageWithURL:[NSURL URLWithString:datas[i]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                CGSize imageSize = image.size;
                CGFloat imageHeight = STWidth(345) * imageSize.height / imageSize.width;
                showImageView.frame = CGRectMake(STWidth(15),weakSelf.dynamicHeight + STHeight(20), STWidth(345), imageHeight);
                weakSelf.dynamicHeight += (imageHeight + STHeight(20));
                [STLog print:DoubleStr(weakSelf.dynamicHeight)];
                if(i == datas.count - 1 && weakSelf.delegate){
                    weakSelf.dynamicHeight += STHeight(20);
                    weakSelf.frame = CGRectMake(0, 0, ScreenWidth, weakSelf.dynamicHeight);
                    [weakSelf.delegate onProductImageLoaded:weakSelf.dynamicHeight];
                }
            }];
            showImageView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:showImageView];
        }
    }
}



@end
