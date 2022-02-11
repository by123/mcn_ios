//
//  ShopViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopModel.h"

@protocol ShopViewDelegate<BaseRequestDelegate>

-(void)onUpdateTableView:(NSInteger)position tag:(NSInteger)tag;

@end


@interface ShopViewModel : NSObject

@property(weak, nonatomic)id<ShopViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(void)reqeustList;
-(void)deleteSKu:(NSString *)skuId;
-(void)deleteMulSku:(NSMutableArray *)skuIds;
-(void)updateTableView:(NSInteger)position tag:(NSInteger)tag;

@end



