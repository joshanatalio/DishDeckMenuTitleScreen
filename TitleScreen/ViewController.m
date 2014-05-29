//
//  ViewController.m
//  TitleScreen
//
//  Created by Josh Anatalio on 4/30/14.
//  Copyright (c) 2014 JoshAnatalio. All rights reserved.
//

#import "ViewController.h"
#import "MenuPictureViewController.h"
#import "MenuViewController.h"
#import "BBBadgeBarButtonItem.h"
#import "PopUpViewController.h"
#import "MZCustomTransition.h"
#import <MZFormSheetController.h>
#import <MZFormSheetSegue.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController
@synthesize dataArray;
@synthesize picNames;
int count = 1;

- (IBAction)leadToTab:(id)sender {
    
    MenuViewController *menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"menuVCID"];
    MenuPictureViewController *myPlateVC = [[MenuPictureViewController alloc] init];
    MenuPictureViewController *shakerVC = [[MenuPictureViewController alloc] init];
    
    UINavigationController *tab1 = [[UINavigationController alloc] initWithRootViewController:menuVC];
    UINavigationController *tab2 = [[UINavigationController alloc] initWithRootViewController:myPlateVC];
    UINavigationController *tab3 = [[UINavigationController alloc] initWithRootViewController:shakerVC];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    NSArray* controllers = [NSArray arrayWithObjects:tab1, tab2, tab3, nil];
    
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    tabBarController.viewControllers = controllers;
    UITabBarItem *tab1Item = [[[tabBarController tabBar] items] objectAtIndex:0];
    [tab1Item setTitle:@"Home"];
    UITabBarItem *tab2Item = [[[tabBarController tabBar] items] objectAtIndex:1];
    [tab2Item setTitle:@"My Plate"];
    UITabBarItem *tab3Item = [[[tabBarController tabBar] items] objectAtIndex:2];
    [tab3Item setTitle:@"Shake It"];
    
    [self.navigationController pushViewController:tabBarController animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RedBar.png"]];
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
    
    UIButton *customButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [customButton addTarget:self action:@selector(barButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    [customButton setImage:[UIImage imageNamed:@"BJs.png"] forState:UIControlStateNormal];
    
    BBBadgeBarButtonItem *barButton = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:customButton];
      barButton.shouldHideBadgeAtZero = NO;
    NSString *hi = [NSString stringWithFormat:@"%d", count];
    barButton.badgeValue = hi;

    
    barButton.badgeOriginX = 13;
    barButton.badgeOriginY = -9;
    barButton.badgeBGColor = [UIColor whiteColor];
    barButton.badgeTextColor = [UIColor redColor];
  
    self.navigationItem.rightBarButtonItem = barButton;
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)barButtonItemPressed:(UIButton *)sender
{
    
    // [self performSegueWithIdentifier:@"PopUpTest" sender:image];
    
    PopUpViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"queuepop"];
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:vc];
    
    formSheet.presentedFormSheetSize = CGSizeMake(300, 150);
    //    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromTop;
    formSheet.shadowRadius = 2.0;
    formSheet.shadowOpacity = 0.3;
    formSheet.shouldDismissOnBackgroundViewTap = YES;
    formSheet.shouldCenterVertically = YES;
    formSheet.movementWhenKeyboardAppears = MZFormSheetWhenKeyboardAppearsCenterVertically;
    // formSheet.keyboardMovementStyle = MZFormSheetKeyboardMovementStyleMoveToTop;
    // formSheet.keyboardMovementStyle = MZFormSheetKeyboardMovementStyleMoveToTopInset;
    // formSheet.landscapeTopInset = 50;
    // formSheet.portraitTopInset = 100;
    
    __weak MZFormSheetController *weakFormSheet = formSheet;
    
    
    // If you want to animate status bar use this code
    formSheet.didTapOnBackgroundViewCompletionHandler = ^(CGPoint location) {
        PopUpViewController *navController = (PopUpViewController *)weakFormSheet.presentedFSViewController;

        // navController = image;
        
        /*if ([navController.topViewController isKindOfClass:[MZModalViewController class]]) {
         MZModalViewController *mzvc = (MZModalViewController *)navController.topViewController;
         mzvc.showStatusBar = NO;
         }*/
        
        [UIView animateWithDuration:0.3 animations:^{
            if ([weakFormSheet respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
                [weakFormSheet setNeedsStatusBarAppearanceUpdate];
            }
        }];
    };
    /*
     formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
     // Passing data
     UINavigationController *navController = (UINavigationController *)presentedFSViewController;
     navController.topViewController.title = @"PASSING DATA";
     };*/
    formSheet.transitionStyle = MZFormSheetTransitionStyleFade;
    
    [MZFormSheetController sharedBackgroundWindow].formSheetBackgroundWindowDelegate = self;
    
    [self mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        
    }];
    
    
    NSLog(@"Bar button item pressed");
    BBBadgeBarButtonItem *barButton = (BBBadgeBarButtonItem *)self.navigationItem.rightBarButtonItem;
    count++;
    NSString *hi = [NSString stringWithFormat:@"%d", count];
    barButton.badgeValue = hi;
   
    barButton.shouldAnimateBadge = YES;
    barButton.shouldHideBadgeAtZero = NO;
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
