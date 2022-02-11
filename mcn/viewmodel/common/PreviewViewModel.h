//
//  PreviewViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PreviewModel.h"

@protocol PreviewViewDelegate<BaseRequestDelegate>

@end


@interface PreviewViewModel : NSObject

@property(weak, nonatomic)id<PreviewViewDelegate> delegate;
@property(assign, nonatomic)PreviewImageType previewType;
@property(strong, nonatomic)NSMutableArray *datas;

@end



