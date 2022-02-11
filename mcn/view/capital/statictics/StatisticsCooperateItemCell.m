

#import "StatisticsCooperateItemCell.h"
#import "StatisticsCooperateItemItemCell.h"

@interface StatisticsCooperateItemCell()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UILabel *productNameLabel;
@property(strong, nonatomic)UILabel *productTotalLabel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSMutableArray *celebrityDatas;
@property(strong, nonatomic)UIView *lineView;

@end

@implementation StatisticsCooperateItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _celebrityDatas = [[NSMutableArray alloc]init];
        [self initView];
    }
    return self;
}


-(void)initView{
  
    _productNameLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(15)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_productNameLabel];
    
    
    _productTotalLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_SEMIBOLD size:STFont(18)] text:MSG_EMPTY textAlignment:NSTextAlignmentCenter textColor:c45 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_productTotalLabel];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = cline;
    [self.contentView addSubview:_lineView];
    
    [self initTableView];
}

-(void)updateData:(CooperateSkuModel *)model hiddenLine:(Boolean)hiddenLine{
    _celebrityDatas = model.celebrityDatas;
    
    _productNameLabel.text = model.spuName;
    CGSize productNameSize = [_productNameLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(15) fontName:FONT_REGULAR];
    _productNameLabel.frame = CGRectMake(STWidth(15), STHeight(20), productNameSize.width, STHeight(21));
    
    _productTotalLabel.text = [NSString stringWithFormat:@"%.2f",model.total / 100];
    CGSize productTotalSize = [_productTotalLabel.text sizeWithMaxWidth:ScreenWidth font:STFont(18) fontName:FONT_SEMIBOLD];
    _productTotalLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - productTotalSize.width, STHeight(20), productTotalSize.width, STHeight(21));
    
    _lineView.frame = CGRectMake(STWidth(15), STHeight(41) + _celebrityDatas.count * STHeight(40) - LineHeight, STWidth(345), LineHeight);
    _lineView.hidden = hiddenLine;
    
    _tableView.frame = CGRectMake(0, STHeight(41), ScreenWidth, _celebrityDatas.count * STHeight(40));
    [_tableView reloadData];
}

/********************** tableview ****************************/
-(void)initTableView{
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [_tableView useDefaultProperty];
    
    [self.contentView addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_celebrityDatas count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(40);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatisticsCooperateItemItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[StatisticsCooperateItemItemCell identify]];
    if(!cell){
        cell = [[StatisticsCooperateItemItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[StatisticsCooperateItemItemCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_celebrityDatas)){
        [cell updateData:[_celebrityDatas objectAtIndex:indexPath.row]];
    }
    return cell;
}



-(void)updateView{
    [_tableView reloadData];
}


/********************** tableview ****************************/


+(NSString *)identify{
    return NSStringFromClass([StatisticsCooperateItemCell class]);
}

@end

