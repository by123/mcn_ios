
#import <UIKit/UIKit.h>
#import "ProductModel.h"

@interface CelebrityLayerViewCell : UITableViewCell

@property(strong, nonatomic)UIButton *linkCopyBtn;

-(void)updateData:(ProductCelebrityModel *)model;
+(NSString *)identify;

@end
