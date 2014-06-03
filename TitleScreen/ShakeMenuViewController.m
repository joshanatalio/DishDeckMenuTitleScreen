//
//  ShakeMenuViewController.m
//  CSE 110 Application
//
//  Created by Aaron Chuang on 5/13/14.
//  Copyright (c) 2014 How I Modified Your Menu. All rights reserved.
//

#import "ShakeMenuViewController.h"
#import <Parse/Parse.h>
#import "ViewController.h"

@interface ShakeMenuViewController ()

@end

@implementation ShakeMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)queryForShakeItems:(NSString *)maxPrice Calories:(NSNumber *)maxCalories category: (NSString *) category {
    NSMutableArray *shakeItems;
    NSMutableArray *menuItem;
    // shakeItems = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"BJMenu"];
    [query whereKey:@"course" equalTo:category];
    [query whereKey:@"menuItemPrice" lessThanOrEqualTo:maxPrice];
    [query whereKey:@"calories" lessThanOrEqualTo:maxCalories];
    //[query whereKey:@"Username" equalTo:@"Ankush Agrawal"];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"menuItemPrice"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error) {
            for (int i = 0; i < [objects count]; i++) {
                NSString *name = [objects[i] objectForKey:@"menuItemName"];
                NSString *price = [objects[i] objectForKey:@"menuItemPrice"];
                NSNumber *caloriesCount = [objects[i] objectForKey:@"calories"];
                
                // Add desired information into an array for each menu item
                [menuItem addObject:name];
                [menuItem addObject:price];
                [menuItem addObject:caloriesCount];
                
                // Add information for individual menu item into final array to return
                [shakeItems addObject:menuItem];
                
                // Clear menuItem array to fill next menu item
                [menuItem removeAllObjects];
                
                NSLog(@"HHH");
            }
        }
    }
     ];
    return shakeItems;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:(BOOL)animated];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(Back)];
    self.navigationController.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.leftBarButtonItem = backButton;
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


@end
