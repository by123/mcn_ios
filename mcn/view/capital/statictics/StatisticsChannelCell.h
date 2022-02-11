
#import <UIKit/UIKit.h>
#import "StatisticsCooperateModel.h"

@interface StatisticsChannelCell : UITableViewCell

@property(strong, nonatomic)UIButton *mchBtn;

-(void)updateData:(StatisticsCooperateModel *)model;
+(NSString *)identify;

@end
