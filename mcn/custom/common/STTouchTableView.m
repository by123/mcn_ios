//
//  STTouchTableView.m
//  cigarette
//
//  Created by by.huang on 2019/12/5.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "STTouchTableView.h"

@implementation STTouchTableView



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.superview touchesBegan:touches withEvent:event];
}

@end
