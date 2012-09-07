//
//  ViewController.h
//  ContractionList
//
//  Created by 许 忠洲 on 12-9-7.
//  Copyright (c) 2012年 eshore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray* mNameArray;    //  存储列表数据
    BOOL* flag;     //  标记展开
}

@property (retain, nonatomic) IBOutlet UITableView *ibTableView;

- (void)headerClicked:(id)sender;

@end
