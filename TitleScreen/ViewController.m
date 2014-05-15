//
//  ViewController.m
//  TitleScreen
//
//  Created by Josh Anatalio on 4/30/14.
//  Copyright (c) 2014 JoshAnatalio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController
@synthesize dataArray;
@synthesize picNames;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 624)];
    scroller.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
    // Instantiante NSMutableArray for data
    dataArray = [[NSMutableArray alloc]initWithObjects:@"Cheeseburger",@"Hamburger", @"Hot Dog", nil];
    picNames = [[NSMutableArray alloc]initWithObjects:@"BJs.png",@"Bluefin.png",@"CPK.png",@"Cottage.png",@"DBar.png",@"Eureka.png",@"ExtraordinaryDesserts.png", @"MignonPho.png",@"SabELee.png",@"Tajima.png",@"Snooze.png",@"TGIF.png", nil];
    int i = 0;
    for(UIButton *b in self.restaurantButtons)
    {
        NSString *string = picNames[i];
        if(string != nil)
        {
        [b setBackgroundImage:[UIImage imageNamed:string] forState:UIControlStateNormal];
        [b setTitle:@"" forState:UIControlStateNormal];
            i++;
        }
        
    }
}

/* This method is used to remove the keyboard when you tap anywhere on the screen */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"Tried to hide search bar");
    [self.searchBar resignFirstResponder];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"MenuCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    
    return cell;
}
/*
#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
*/
@end
