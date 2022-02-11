
#import <UIKit/UIKit.h>
#import "AuthUserModel.h"

@interface PartnerMcnViewCell : UITableViewCell

-(void)updateData:(AuthUserModel *)model;
+(NSString *)identify;

@end
