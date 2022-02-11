
#import <UIKit/UIKit.h>
#import "ShopModel.h"

@interface CooperationItemViewCell : UITableViewCell

@property(strong, nonatomic)UIButton *selectBtn;

-(void)updateData:(ShopSkuModel *)model hiddenLine:(Boolean)hiddenLine;
+(NSString *)identify;

@end
