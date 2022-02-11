
#import <UIKit/UIKit.h>
#import "CapitalListModel.h"

@interface CapitalListViewCell : UITableViewCell

-(void)updateData:(CapitalListModel *)model hiddenLine:(Boolean)hiddenLine;
+(NSString *)identify;

@end
