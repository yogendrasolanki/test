//
//  TableViewController.m
//  DemoTable
//
//  Created by alok patil on 02/07/13.
//  Copyright (c) 2013 Hiteshi . All rights reserved.
//

#import "TableViewController.h"

#import "CustomCell.h"
@implementation TableViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"Table Demo";
        

    tableData =[[NSMutableArray alloc]initWithObjects:@"AAA",@"BBB",@"CCC",@"DDD",@"EEE",@"FFF", nil];
    tableImage=[[NSMutableArray alloc]initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"index.jpg", nil];;
    prepTime = [NSMutableArray arrayWithObjects:@"30 min", @"30 min", @"20 min", @"30 min", @"10 min",@"1 hour",nil];



/********************
 //Code for plist access data
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Recepee" ofType:@"plist"];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    tableData=[dict objectForKey:@"RecipeName"];
    tableImage=[dict objectForKey:@"Thumbnail"];
    prepTime=[dict objectForKey:@"PrepTime"];
 *****************/
 }
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"SimpleTableCell";
    CustomCell *cell=(CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    cell.nameLabel.text=[tableData objectAtIndex:indexPath.row];
    cell.thumbnailImageView.image=[UIImage imageNamed:[tableImage objectAtIndex:indexPath.row]];
    cell.prepTimeLabel.text=[prepTime objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *objAlert=[[UIAlertView alloc]initWithTitle:@"Row Slected" message:[tableData objectAtIndex:indexPath.row] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [objAlert show];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableData removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
