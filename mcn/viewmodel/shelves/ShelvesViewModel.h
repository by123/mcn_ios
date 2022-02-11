//
//  ShelvesViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShelvesModel.h"

@protocol ShelvesViewDelegate<BaseRequestDelegate>

-(void)onRequestNoDatas:(Boolean)isFirst;

@end


@interface ShelvesViewModel : NSObject

@property(weak, nonatomic)id<ShelvesViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
//0 已下架 1 已上架 2审核中
@property(assign, nonatomic)ShelvesType shelvesType;

-(void)requestShelvesList:(Boolean)isRefreshNew;
-(void)onShelf:(NSString *)skuId;
-(void)offShelf:(NSString *)skuId;


@end



