
#import <UIKit/UIKit.h>
#import "StatisticsProductModel.h"

@interface StatisticsProductCell : UITableViewCell

-(void)updateData:(StatisticsProductModel *)model hiddenLine:(Boolean)hiddenLine;
+(NSString *)identify;

@end
