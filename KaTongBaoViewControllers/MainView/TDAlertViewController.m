//
//  TDAlertViewController.m
//  YiFuKa
//
//  Created by yanlinhong on 14-3-5.
//  Copyright (c) 2014年 TangDi. All rights reserved.
//

#import "TDAlertViewController.h"
#import "UIView+SDAutoLayout.h"
@interface TDAlertViewController ()

@end

@implementation TDAlertViewController
@synthesize contentTable;
@synthesize alertTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contentArray:(NSArray *)array titleStr:(NSString *)titleStr tag:(int)myTag
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        contentArray = [[NSArray alloc] initWithArray:array];
        //contentArray=array;
        titleString=titleStr;
        mTag=myTag;
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    alertTitle.text=titleString;
    contentTable.delegate=self;
    contentTable.dataSource=self;
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        [contentTable  setSeparatorInset:UIEdgeInsetsZero];

    }
    // Do any additional setup after loading the view from its nib.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (mTag == 3) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];

        }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    if (mTag != 3) {
        NSString *string=[contentArray objectAtIndex:indexPath.row];
        cell.textLabel.text =string;
    }
    if (mTag == 3) {
        if (indexPath.row < contentArray.count) {
            //cell.textLabel.text = [[contentArray objectAtIndex:indexPath.row] objectForKey:@"cardNo"];
            UILabel *bankLab = [[UILabel alloc] init];
            bankLab.font = [UIFont systemFontOfSize:16];
            bankLab.text = [[contentArray objectAtIndex:indexPath.row] objectForKey:@"bankName"];
            [cell.contentView addSubview:bankLab];
            bankLab.sd_layout.leftSpaceToView(cell.contentView,12.8).topSpaceToView(cell.contentView,14.4).widthIs(71).heightIs(18);
            
            UILabel *bankNumberLab = [[UILabel alloc] init];
            bankNumberLab.font = [UIFont systemFontOfSize:16];
            bankNumberLab.text = [self rePlaceString:[[contentArray objectAtIndex:indexPath.row] objectForKey:@"bankNo"]];
            bankNumberLab.adjustsFontSizeToFitWidth = YES;
            [cell.contentView addSubview:bankNumberLab];
            bankNumberLab.sd_layout.leftSpaceToView(bankLab,10).topSpaceToView(cell.contentView,14.4).rightSpaceToView(cell.contentView,12.8).heightIs(17.5);
        }else if (indexPath.row == contentArray.count){
            
            UIImageView *AddImg = [[UIImageView alloc] init];
            AddImg.image = [UIImage imageNamed:@"Line + Line Copy 4.png"];
            [cell.contentView addSubview:AddImg];
            AddImg.sd_layout.leftSpaceToView(cell.contentView,10.5).topSpaceToView(cell.contentView,16.7).widthIs(23).heightIs(23);
            UILabel *AddLab = [[UILabel alloc] init];
            AddLab.text = @"添加其他银行卡";
            AddLab.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:AddLab];
            AddLab.sd_layout.leftSpaceToView(AddImg,20).topSpaceToView(cell.contentView,19).widthIs(116.5).heightIs(17.5);
        }
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (mTag == 3) {
        return [contentArray count] + 1;
    }else {
        return [contentArray count];
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewSelect:tag:selectNum:)]) {
        [self.delegate tableViewSelect:self tag:mTag selectNum:indexPath.row];
    }
    
}

-(NSString*)rePlaceString:(NSString*)string{
    if (![string isKindOfClass:[NSString class]]) {
        return @"";
    }else{
        NSMutableString *mutString = [NSMutableString stringWithString:string];
        NSInteger length = [mutString length];
        if (length>=6) {
            [mutString replaceCharactersInRange:NSMakeRange(3, length-6) withString:@"********"];
        }else{
            
        }
        
        return (NSString*)mutString;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [alertTitle release];
    [contentTable release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAlertTitle:nil];
    [self setContentTable:nil];
    [super viewDidUnload];
}
@end
