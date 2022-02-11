
#import <UIKit/UIKit.h>
#import "CelebrityModel.h"

@interface SelectCelebrityViewCell : UITableViewCell

-(void)updateData:(CelebrityModel *)model hiddenLine:(Boolean)hiddenLine;
+(NSString *)identify;

@end
