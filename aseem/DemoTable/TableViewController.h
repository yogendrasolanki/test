//
//  TableViewController.h
//  DemoTable
//
//  Created by alok patil on 02/07/13.
//  Copyright (c) 2013 Hiteshi . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *tableData;
    NSMutableArray *tableImage;
    NSMutableArray *prepTime;
}

@end
