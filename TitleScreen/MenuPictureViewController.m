//
//  MenuPictureViewController.m
//  TitleScreen
//
//  Created by Josh Anatalio on 5/11/14.
//  Copyright (c) 2014 JoshAnatalio. All rights reserved.
//

#import "MenuPictureViewController.h"
#import "MenuCell.h"
#import "PopUpViewController.h"
#import "MZCustomTransition.h"
#import <MZFormSheetController.h>
#import <MZFormSheetSegue.h>
#define CELL_COUNT 13
#define CELL_NAME @"MenuCell"


@interface MenuPictureViewController ()
@property (nonatomic, strong) NSMutableArray *cellSizes;

@end

@implementation MenuPictureViewController{
    NSMutableArray *foodPicArray;
}

/* This method is used to instantiate the collectionView in a waterfall layout form
 This method uses a form of lazy instantiation and is used to make sure that each
 collection view item is automatically resized.
 */
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc]init]; // make the view into a waterfal; layout
        /* do tall the specifications for header footer and spacing here */
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumColumnSpacing = 5;
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout]; // init the collection view with the bounds that were given above
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        // not exactly sure what this does.
        _collectionView.dataSource = self; //this is the data source
        _collectionView.delegate = self; // this is the delegate
        
        _collectionView.backgroundColor = [UIColor clearColor]; //background is a clear color
        
        [_collectionView registerClass:[MenuCell class] forCellWithReuseIdentifier:CELL_NAME]; // assigns each cell a name and registers the class of each cell.
    }
    return _collectionView; // return the view
}

/* This method is used to populate the array of cell sizes. They are randomized to give the waterfall affect */

-(NSMutableArray *)cellSizes {
    if(!_cellSizes)
    {
        _cellSizes = [NSMutableArray array]; // make a new array
        
        for(NSInteger i = 0; i < CELL_COUNT; i++) //loop to add the sizes in
        {
            CGSize size = CGSizeMake(arc4random() % 50 + 50, arc4random() % 50 + 50);
            _cellSizes[i] = [NSValue valueWithCGSize:size];
        }
    }
    return _cellSizes;
}

/* Used for deallocation and memory management, automatically called when the view is released */
-(void) dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}


- (void)viewDidLoad
{
    // Used for testing purposes, filling in the foodPicArray with all the pictures that are in this file as a demonstration
    foodPicArray = [[NSMutableArray alloc]initWithObjects:@"burger.jpg",@"BJs.png",@"Bluefin.png",@"CPK.png",@"Cottage.png",@"DBar.png",@"Eureka.png",@"ExtraordinaryDesserts.png", @"MignonPho.png",@"SabELee.png",@"Tajima.png",@"Snooze.png",@"TGIF.png", nil];
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView]; // adds the collectionView as a subview to the view
    /* May not need to add these gesture recognizers */
    UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myRightAction)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
    
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation: toInterfaceOrientation];
}

-(void) updateLayoutForOrientation:(UIInterfaceOrientation)orientation{
    CHTCollectionViewWaterfallLayout *layout = (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return CELL_COUNT; // number of cells in the collection view
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1; // leave this at 1
    
}

/* This method is used to organize the collectionView by creating each of the cells on the index path and assigns pictures to each cell
 From the foodPictureName
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MenuCell *cell = (MenuCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_NAME forIndexPath:indexPath];
    NSString *string = [foodPicArray objectAtIndex:indexPath.row];
    
    if(string){
        cell.foodPictureName = string;
        cell.backgroundImage.image =  [UIImage imageNamed:string];
    }
    else
    {
        cell.backgroundImage.image = [UIImage imageNamed:@"BJ's"];
        
    }
    [cell.layer setBorderWidth:2.0f]; // the thickness of the border around the cell
    [cell.layer setBorderColor:[UIColor blackColor].CGColor]; // color of the border around the call
    
    return cell; // returns the last cell
}

/* This method is used when a selection is called on any cell and will create a popup with the image and description of that popup
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *image = [UIImage imageNamed:[foodPicArray objectAtIndex:indexPath.row]];
    if(image)
    {
        NSLog(@"image is not null");
    }
    // [self performSegueWithIdentifier:@"PopUpTest" sender:image];
    
    PopUpViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"popup"];
    vc.foodPic = image;
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:vc];
    
    formSheet.presentedFormSheetSize = CGSizeMake(300, 298); // size of the formsheet
    formSheet.shadowRadius = 2.0;
    formSheet.shadowOpacity = 0.3;
    formSheet.shouldDismissOnBackgroundViewTap = YES; //ensures that the form will dissapear when the sheet is tapped outside of the formsheet
    formSheet.shouldCenterVertically = YES;
    formSheet.movementWhenKeyboardAppears = MZFormSheetWhenKeyboardAppearsCenterVertically;
    
    __weak MZFormSheetController *weakFormSheet = formSheet;
    
    // If you want to animate status bar use this code
    formSheet.didTapOnBackgroundViewCompletionHandler = ^(CGPoint location) {
        PopUpViewController *navController = (PopUpViewController *)weakFormSheet.presentedFSViewController;
        navController.foodPic = image;
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
    formSheet.transitionStyle = MZFormSheetTransitionStyleDropDown; // animation for how the formsheet will appear on screen
    
    [MZFormSheetController sharedBackgroundWindow].formSheetBackgroundWindowDelegate = self;
    
    [self mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        
    }];
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PopUpTest"])
    {
        MZFormSheetController *vc = [segue destinationViewController];
        
        MZFormSheetSegue *formSheetSegue = (MZFormSheetSegue *)segue;
        MZFormSheetController *formSheet = formSheetSegue.formSheetController;
        
        NSLog(@"tried to put the picture on the form sheet");
        formSheet.transitionStyle = MZFormSheetTransitionStyleDropDown;
        formSheet.cornerRadius = 8.0;
        formSheet.didTapOnBackgroundViewCompletionHandler = ^(CGPoint location) {
        };
        
        formSheet.shouldDismissOnBackgroundViewTap = YES;
        formSheet.didPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
            
        };
        [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:YES];
        [[MZFormSheetBackgroundWindow appearance] setBlurRadius:2.0];
        [[MZFormSheetBackgroundWindow appearance] setBackgroundColor:[UIColor clearColor]];
                
        NSLog(@"tried to put the picture on the form sheet");

        
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.cellSizes[indexPath.item] CGSizeValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

@end
