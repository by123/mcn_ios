
#import <UIKit/UIKit.h>
#import "ProductModel.h"

@interface PartnerProductViewCell : UITableViewCell

-(void)updateData:(ProductModel *)model;
+(NSString *)identify;

@end
