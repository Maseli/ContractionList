//
//  ViewController.m
//  ContractionList
//
//  Created by 许 忠洲 on 12-9-7.
//  Copyright (c) 2012年 eshore. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize ibTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // 读取资源文件地址
    NSString* path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    // 读取资源文件数据
    mNameArray = [[NSArray alloc] initWithContentsOfFile:path];
    // 根据列表个数初始化标记个数
    flag = (BOOL*)malloc([mNameArray count]*sizeof(BOOL));
    memset((void*)flag, NO, sizeof(flag));
}

- (void)viewDidUnload
{
    [self setIbTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [ibTableView release];
    [mNameArray release];
    free(flag);
    [super dealloc];
}

#pragma mark - Self Function

- (void)headerClicked:(id)sender
{
    int sectionIndex = ((UIButton*)sender).tag;
    flag[sectionIndex] = !flag[sectionIndex];
    [ibTableView reloadData];
}

#pragma mark - UITableViewDelegate
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
*/

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 30.0f)] autorelease];
    
    UIButton* sectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sectionBtn.frame = CGRectMake(0, 0, 320.0f, 30.0f);
    sectionBtn.backgroundColor = [UIColor grayColor];
    sectionBtn.tag = section;
    [sectionBtn addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView addSubview:sectionBtn];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 5.0f, 200.0f, 22.0f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = [NSString stringWithFormat:@"我是第%d个Section", section];
    [sectionView addSubview:titleLabel];
    [titleLabel release];
    
    UIView* seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 30.0f, 320.0f, 2.0f)];
    seperatorView.backgroundColor = [UIColor whiteColor];
    [sectionView addSubview:seperatorView];
    [seperatorView release];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32.0f;
}

#pragma mark - UITableViewDataSourceDelegate
//  必须实现的方法

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellId"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [[mNameArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (flag[section]) {
        return [[mNameArray objectAtIndex:section] count];
    }
    else {
        return 0;
    }
}

//  可选方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [mNameArray count];
}

@end
