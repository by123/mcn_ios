
#import <UIKit/UIKit.h>
#import "StatisticsCooperateModel.h"

@interface StatisticsCooperateItemCell : UITableViewCell

-(void)updateData:(CooperateSkuModel *)model hiddenLine:(Boolean)hiddenLine;
+(NSString *)identify;

@end
