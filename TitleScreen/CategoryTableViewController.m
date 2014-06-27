//
//  CategoryTableViewController.m
//  HIMYMdb
//
//  Created by Angelique De Castro on 4/29/14.
//  Copyright (c) 2014 ifearcompilererrors. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "CategoryMenuItemViewController.h"
#import <Parse/Parse.h>
#import "MenuPictureViewController.h"
#import "ViewController.h"

@interface CategoryTableViewController ()

@end

@implementation CategoryTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Categories";
        
        // The key of the PFObject to display in the label of the default cell style
        self.imageKey = @"category";
        
        // The title for this table in the Navigation Controller.
        //self.title = @"Categories";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
        // The number of objects to show per page
        self.objectsPerPage = 100;
        
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:(BOOL)animated];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(Back)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    //UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LargeBJ.jpg"]];
    //self.tableView.backgroundView = background;
    
}

-(IBAction)Back
{
    //self.navigationItem.backBarButtonItem.title = @"";
    ViewController *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"VCID"];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    //[self presentViewController:VC animated:YES completion:nil];
    [self.navigationController pushViewController:VC animated:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    /*
     // create and reuse for later the customListViewController
     self.customListTableView = [[self storyboard] instantiateViewControllerWithIdentifier:@"customListTableViewID"];
     
     // use our custom segues to the destination view controller is reused
     self.listSegue = [[ListSegue alloc] initWithIdentifier:@"showDetail"
     source:self
     destination:self.customListTableView];
     
     */
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    /*
     [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriendButtonHandler:)]];
     */
    /*menuItemsArray = [[NSMutableArray alloc] init];
     
     PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
     [query whereKey:@"category" equalTo:@"Dessert"];
     [query orderByAscending:@"category"];*/
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    //[query whereKey:@"category" equalTo:[PFUser currentUser].username];
    //[query whereKey:@"Username" equalTo:@"Ankush Agrawal"];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"category"];
    
    return query;
}


// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"category"];
    cell.textLabel.textColor = [UIColor blackColor];
    if(indexPath.row %2 == 0)
        cell.backgroundColor = [UIColor clearColor];
    else
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.3];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"Priority: %@", [object objectForKey:@"priority"]];
    
    return cell;
}


- (NSMutableArray *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
                       object:(PFObject *)object {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = [object objectForKey:@"category"];
    NSString *cellText = cell.textLabel.text;
    NSMutableArray *menuItemArray = [[NSMutableArray alloc] init];
    [menuItemArray addObject:cellText];
    return menuItemArray;
}


#pragma mark - Table view data source


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        PFObject *objectToDel = [self.objects objectAtIndex:indexPath.row];
        [objectToDel deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             UIAlertView *Alert = [[UIAlertView alloc]  initWithTitle:@"Item Was Deleted" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [Alert show];
             
         }];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *loadingView = [[UIView alloc] initWithFrame:CGRectMake(110, 130, 100, 100)];
    UIActivityIndicatorView *ai = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView setBackgroundColor:[UIColor blackColor]];
    [loadingView setAlpha:.7f];
    [ai setFrame:CGRectMake(40, 50, 20, 20)];
    loadingView.layer.cornerRadius = 5;
    UILabel *loadLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
    loadLabel.text = @"Loading...";
    loadLabel.textColor = [UIColor whiteColor];
    [loadingView addSubview:loadLabel];
    [loadingView addSubview:ai];
    [ai startAnimating];
    [self.view addSubview: loadingView];
    [self.view bringSubviewToFront:loadingView];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
        NSIndexPath *selectedItem = [self.tableView indexPathForSelectedRow];
        PFObject* listObject = [self.objects objectAtIndex:selectedItem.row];
        
        NSString* menuItem = [listObject objectForKey:@"category"];
        //NSString* contactName = [listObject objectForKey:@"RelatedUsername"];
        //NSLog(listName2);
        //MenuPictureViewController *imageMenuVC = [[MenuPictureViewController alloc] init];
        
        
        MenuPictureViewController *imageMenuVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MenuPictureVCID"];
        //CategoryMenuItemViewController *menuItemView = [CategoryMenuItemViewController new];
        imageMenuVC.fromList = menuItem;
        
        
        
        dispatch_async(dispatch_get_main_queue(),^{
        
            [self.view sendSubviewToBack:loadingView];
            [loadingView removeFromSuperview];
           [self.navigationController pushViewController:imageMenuVC animated:YES];
        });
        
    });

    
}


@end