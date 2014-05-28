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
#import <Parse/Parse.h>
#define CELL_COUNT 13
#define CELL_NAME @"MenuCell"


@interface MenuPictureViewController ()
@property (nonatomic, strong) NSMutableArray *cellSizes;

@end

@implementation MenuPictureViewController{
    NSMutableArray *foodPicArray;
}


- (NSMutableArray *)queryForPics:(NSString *) category {
    //NSMutableArray *picArray = [[NSMutableArray alloc] init];
    self.array = [[NSMutableArray alloc] init];
    NSLog(@"inside query for pics");
    PFQuery *query = [PFQuery queryWithClassName:@"BJMenu"];
    query.limit = 30;
    [query whereKey:@"category" equalTo:category];
    NSArray *objects = [query findObjects];
    for (PFObject *obj in objects) {
        PFFile *imageFile = [obj objectForKey:@"pics"];
        NSData *data = [imageFile getData];
        UIImage *image = [UIImage imageWithData:data];
        [self.array addObject:image];
        NSLog(@"Added object");
        NSLog(@"array has this many elements: %d", [self.array count]);
    }

    NSLog(@"End of method. Num Elements: %d", [self.array count]);
    return self.array;
}


- (UICollectionView *)collectionView {
    if(!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc]init]; // make the view into a waterfal; layout
        /* do tall the specifications for header footer and spacing here */
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
       // layout.footerHeight = 10;
        //layout.headerHeight = 15;
        layout.minimumColumnSpacing = 5;
        layout.minimumInteritemSpacing = 10;
    
        
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout]; // init the collection view with the bounds that were given above
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        // not exactly sure what this does.
        _collectionView.dataSource = self; //this is the data source
        _collectionView.delegate = self; // this is the delegate
        
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[MenuCell class] forCellWithReuseIdentifier:CELL_NAME];
        
    }

    
    return _collectionView;
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

-(void) dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}


- (void)viewDidLoad
{
    foodPicArray = [[NSMutableArray alloc]initWithObjects:@"burger.jpg",@"BJs.png",@"Bluefin.png",@"CPK.png",@"Cottage.png",@"DBar.png",@"Eureka.png",@"ExtraordinaryDesserts.png", @"MignonPho.png",@"SabELee.png",@"Tajima.png",@"Snooze.png",@"TGIF.png", nil];
    [super viewDidLoad];
    [self queryForPics:@"Entree"];

	// Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myRightAction)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];

}


-(void)myRightAction{
    
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
    return CELL_COUNT;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    /*
    NSLog(@"inside cellforItemAtIndex");
    MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCell" forIndexPath:indexPath];
    
    //UIImageView *pic = (UIImageView *)[cell viewWithTag:69];
    UIImage *string = [array objectAtIndex:indexPath.row];
    
    if(string){
        //NSLog(string);
        //cell.backgroundImage.image =  [UIImage imageNamed:string];
        cell.backgroundImage.image = string;
    }
    
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    return cell;
*/
    
    
    MenuCell *cell = (MenuCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_NAME forIndexPath:indexPath];;;
    //NSString *string = [self.array objectAtIndex:indexPath.row];
    
    /*if(string){
       // NSLog(string);
        cell.foodPictureName = string;
        cell.backgroundImage.image =  [UIImage imageNamed:string];
    }
    else
    {
        cell.backgroundImage.image = [UIImage imageNamed:@"BJ's"];
    
    }*/
    UIImage *datImage = [self.array objectAtIndex:indexPath.row];
    
    if(datImage){
        //NSLog(string);
        //cell.backgroundImage.image =  [UIImage imageNamed:string];
        cell.backgroundImage.image = datImage;
    }

    
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //UIImage *image = [UIImage imageNamed:[foodPicArray objectAtIndex:indexPath.row]];
    UIImage *image = [self.array objectAtIndex:indexPath.row];
    if(image)
    {
        NSLog(@"image is not null");
    }
   // [self performSegueWithIdentifier:@"PopUpTest" sender:image];

    PopUpViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"popup"];
    vc.foodPic = image;
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:vc];
    
    formSheet.presentedFormSheetSize = CGSizeMake(300, 298);
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
    formSheet.transitionStyle = MZFormSheetTransitionStyleDropDown;
    
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
        //vc.pic = sender;
     
        
       
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
