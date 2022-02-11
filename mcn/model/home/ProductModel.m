
//
//  ProductModel.m
//  mcn
//
//  Created by by.huang on 2020/8/19.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductAuthModel


@end

@implementation ProductMchModel

-(ProductAuthModel *)authModel{
    return [ProductAuthModel mj_objectWithKeyValues:_authenticateDataRespVo];
}

@end

@implementation ProductModel


+(NSString *)getAttributeValue:(NSString *)attribute{
    NSString *result = MSG_EMPTY;
    id data = [STConvertUtil jsonToDic:attribute];
    NSMutableArray *datas = [NSMutableArray mj_objectArrayWithKeyValuesArray:data];
    if(!IS_NS_COLLECTION_EMPTY(datas)){
        for (id item in datas) {
            NSString *value = [item objectForKey:@"attributeValue"];
            result = [result stringByAppendingString:[NSString stringWithFormat:@"%@",value]];
        }
    }
    return result;
}

+(NSString *)getAttributeKeyValue:(NSString *)attribute {
    NSString *result = MSG_EMPTY;
    id data = [STConvertUtil jsonToDic:attribute];
    NSMutableArray *datas = [NSMutableArray mj_objectArrayWithKeyValuesArray:data];
    if(!IS_NS_COLLECTION_EMPTY(datas)){
        for (id item in datas) {
            NSString *key = [item objectForKey:@"attributeClass"];
            NSString *value = [item objectForKey:@"attributeValue"];
            result = [result stringByAppendingString:[NSString stringWithFormat:@"%@：%@",key,value]];
        }
    }
    return result;
}


-(ProductMchModel *)mchModel{
    return [ProductMchModel mj_objectWithKeyValues:_mchUserRespVo];
}

-(NSMutableArray *)celebrityModels{
    return [ProductCelebrityModel mj_objectArrayWithKeyValuesArray:_anchors];
}

@end

@implementation ProductCelebrityModel



@end
