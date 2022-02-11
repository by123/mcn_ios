
#import <UIKit/UIKit.h>
#import "StatisticsCelebrityModel.h"


@interface StatisticsCelebrityCell : UITableViewCell

-(void)updateData:(StatisticsCelebrityModel *)model hiddenLine:(Boolean)hiddenLine;
+(NSString *)identify;

@end
