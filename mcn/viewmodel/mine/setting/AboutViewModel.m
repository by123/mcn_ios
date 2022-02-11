
//
//  AboutViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AboutViewModel.h"

@interface AboutViewModel()


@end

@implementation AboutViewModel : NSObject


-(void)goAgressmentPage{
    if(_delegate){
        [_delegate onGoAgressmentPage];
    }
}

-(void)doCall{
    NSString *callPhone =  [NSString stringWithFormat:@"telprompt://%@",@"4000128000"];
      if (@available(iOS 10.0, *)) {
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
      } else {
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
      }
}



@end



