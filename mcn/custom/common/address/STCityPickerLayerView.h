//
//  STCityPickerLayerView.h
//  cigarette
//
//  Created by by.huang on 2020/6/22.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CitySelectModel.h"

@protocol STCityPickerLayerViewDelegate

-(void)onSelectResult:(id)layerView province:(NSString *)provinceStr city:(NSString *)cityStr;

@end


@interface STCityPickerLayerView : UIView

@property(weak, nonatomic)id<STCityPickerLayerViewDelegate> delegate;

-(CitySelectModel *)getCurrentModel;

@end
