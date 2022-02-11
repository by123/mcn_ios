
#import <UIKit/UIKit.h>
#import "TitleContentModel.h"

@interface STSideViewCell : UITableViewCell

-(void)updateData:(TitleContentModel *)model;
+(NSString *)identify;

@end
