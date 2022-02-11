
#import <UIKit/UIKit.h>
#import "TitleContentModel.h"

@interface STTitleTableViewCell : UITableViewCell

-(void)updateData:(TitleContentModel *)model hiddenLine:(Boolean)hiddenLine;
+(NSString *)identify;

@end
