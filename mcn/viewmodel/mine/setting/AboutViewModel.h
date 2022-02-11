//
//  AboutViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AboutViewDelegate<BaseRequestDelegate>

-(void)onGoAgressmentPage;

@end


@interface AboutViewModel : NSObject

@property(weak, nonatomic)id<AboutViewDelegate> delegate;

-(void)goAgressmentPage;
-(void)doCall;

@end



