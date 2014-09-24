//
//  ConstellationVC.h
//  ConstellationVC
//
//  Created by  on 14-9-20.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstellationRequest.h"

@interface ConstellationVC : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    UILabel *allLabel;
    UILabel *loveLabel;
    UILabel *workLabel;
    UILabel *moneyLabel;
    UILabel *luckColorLabel;
    UILabel *luckNumberLabel;
    UILabel *heathLabel;
    UILabel *suitLabel;
    UILabel *declareLabel;
    UITextView *txtField;
    UITableView *myTableView;
    UIView *myView;
    UILabel *ConsteName;
}

@property (strong, nonatomic) IBOutlet UILabel *ConsteName;

@property (nonatomic, strong) NSMutableArray *acceptArray;
@property (strong, nonatomic) IBOutlet UILabel *allLabel;
@property (strong, nonatomic) IBOutlet UILabel *loveLabel;
@property (strong, nonatomic) IBOutlet UILabel *workLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *luckColorLabel;
@property (strong, nonatomic) IBOutlet UILabel *luckNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *heathLabel;
@property (strong, nonatomic) IBOutlet UILabel *suitLabel;
@property (strong, nonatomic) IBOutlet UILabel *declareLabel;
@property (strong, nonatomic) IBOutlet UITextView *txtField;
@property (nonatomic, strong) NSString *selectstr;
@property (nonatomic, strong) NSArray *allArray;
@property (nonatomic, strong) NSString *number;

@end
