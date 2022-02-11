
#import <UIKit/UIKit.h>
#import "PartnerDetailModel.h"


@interface PartnerDetailViewCell : UITableViewCell

-(void)updateData:(ProductModel *)model;
+(NSString *)identify;

@end
