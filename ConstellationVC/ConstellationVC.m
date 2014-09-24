//
//  ConstellationVC.m
//  ConstellationVC
//
//  Created by  on 14-9-20.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ConstellationVC.h"

@implementation ConstellationVC

@synthesize ConsteName;
@synthesize acceptArray = _acceptArray;
@synthesize allLabel;
@synthesize loveLabel;
@synthesize workLabel;
@synthesize moneyLabel;
@synthesize luckColorLabel;
@synthesize luckNumberLabel;
@synthesize heathLabel;
@synthesize suitLabel;
@synthesize declareLabel;
@synthesize txtField;
@synthesize selectstr;
@synthesize allArray;
@synthesize number;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    myTableView.backgroundColor = [UIColor colorWithRed:73/255.f green:186/255.f blue:235/255.f alpha:0.7];
    
    ConstellationRequest *request = [[ConstellationRequest alloc]init];
    if(number == NULL){
        number = @"11";
    }
    [request startRequest:number];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passValueNotification:) name:@"passValueNotification" object:nil];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"星座" style:UIBarButtonItemStylePlain target:self action:@selector(onClick)];
    txtField.editable = NO;
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"Conste" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    allArray = [dict allKeys];
    if(selectstr == NULL){
        selectstr = @"双鱼座";
    }
    ConsteName.text = selectstr;
}

- (void)passValueNotification:(NSNotification *)notification
{
    _acceptArray = [notification object];
//    NSLog(@"_acceptArray %@",_acceptArray);
    
    //综合运势
    NSString *str0 = [[_acceptArray objectAtIndex:0] objectForKey:@"title"];
    NSString *str1 = [[_acceptArray objectAtIndex:0] objectForKey:@"rank"];
    allLabel.text = [str0 stringByAppendingFormat:@":  %@ 星",str1];
    //爱情
    NSString *str2 = [[_acceptArray objectAtIndex:1] objectForKey:@"title"];
    NSString *str3 = [[_acceptArray objectAtIndex:1] objectForKey:@"rank"];
    loveLabel.text = [str2 stringByAppendingFormat:@":  %@ 星",str3];
    //工作
    NSString *str4 = [[_acceptArray objectAtIndex:2] objectForKey:@"title"];
    NSString *str5 = [[_acceptArray objectAtIndex:2] objectForKey:@"rank"];
    workLabel.text = [str4 stringByAppendingFormat:@":  %@ 星",str5];
    //理财投资
    NSString *str6 = [[_acceptArray objectAtIndex:3] objectForKey:@"title"];
    NSString *str7 = [[_acceptArray objectAtIndex:3] objectForKey:@"rank"];
    moneyLabel.text = [str6 stringByAppendingFormat:@":  %@ 星",str7];
    //健康指数
    NSString *str8 = [[_acceptArray objectAtIndex:4] objectForKey:@"title"];
    NSString *str9 = [[_acceptArray objectAtIndex:4] objectForKey:@"value"];
    heathLabel.text = [str8 stringByAppendingFormat:@":  %@",str9];
    //幸运颜色
    NSString *str10 = [[_acceptArray objectAtIndex:6] objectForKey:@"title"];
    NSString *str11 = [[_acceptArray objectAtIndex:6] objectForKey:@"value"];
    luckColorLabel.text = [str10 stringByAppendingFormat:@":  %@",str11];
    //幸运数字
    NSString *str12 = [[_acceptArray objectAtIndex:7] objectForKey:@"title"];
    NSString *str13 = [[_acceptArray objectAtIndex:7] objectForKey:@"value"];
    luckNumberLabel.text = [str12 stringByAppendingFormat:@":  %@",str13];
    //速配星座
    NSString *str14 = [[_acceptArray objectAtIndex:8] objectForKey:@"title"];
    NSString *str15 = [[_acceptArray objectAtIndex:8] objectForKey:@"value"];
    suitLabel.text = [str14 stringByAppendingFormat:@":  %@",str15];
    //解读和解读
    declareLabel.text = [[_acceptArray objectAtIndex:9] objectForKey:@"title"];
    txtField.text = [[_acceptArray objectAtIndex:9] objectForKey:@"value"];
}

- (void)viewDidUnload
{
    [self setAllLabel:nil];
    [self setLoveLabel:nil];
    [self setWorkLabel:nil];
    [self setMoneyLabel:nil];
    [self setLuckColorLabel:nil];
    [self setLuckNumberLabel:nil];
    [self setHeathLabel:nil];
    [self setSuitLabel:nil];
    [self setDeclareLabel:nil];
    [self setTxtField:nil];
    [self setConsteName:nil];
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)onClick
{
    myView = [[UIView alloc]initWithFrame:CGRectMake(30, 140, 260, 100)];
    myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myView];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 260, 100)];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [myView addSubview:myTableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allArray.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [allArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectstr = [allArray objectAtIndex:indexPath.row];
    if([selectstr isEqualToString:@"白羊座"]){
        number = @"0";
    }else if([selectstr isEqualToString:@"金牛座"]){
        number = @"1";
    }else if([selectstr isEqualToString:@"双子座"]){
        number = @"2";
    }else if([selectstr isEqualToString:@"巨蟹座"]){
        number = @"3";
    }else if([selectstr isEqualToString:@"狮子座"]){
        number = @"4";
    }else if([selectstr isEqualToString:@"处女座"]){
        number = @"5";
    }else if([selectstr isEqualToString:@"天秤座"]){
        number = @"6";
    }else if([selectstr isEqualToString:@"天蝎座"]){
        number = @"7";
    }else if([selectstr isEqualToString:@"射手座"]){
        number = @"8";
    }else if([selectstr isEqualToString:@"摩羯座"]){
        number = @"9";
    }else if([selectstr isEqualToString:@"水瓶座"]){
        number = @"10";
    }else if([selectstr isEqualToString:@"双鱼座"]){
        number = @"11";
    }
    [myView removeFromSuperview];
    [self viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
