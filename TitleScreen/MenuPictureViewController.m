//
//  MenuPictureViewController.m
//  TitleScreen
//
//  Created by Josh Anatalio on 5/11/14.
//  Copyright (c) 2014 JoshAnatalio. All rights reserved.
//

#import "MenuPictureViewController.h"
#import "MenuCell.h"
#import <MZFormSheetController.h>
#import <MZFormSheetSegue.h>
#define CELL_COUNT 12
#define CELL_NAME @"MenuCell"


@interface MenuPictureViewController ()
@property (nonatomic, strong) NSMutableArray *cellSizes;

@end

@implementation MenuPictureViewController{
    NSMutableArray *foodPicArray;
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
    foodPicArray = [[NSMutableArray alloc]initWithObjects:@"BJs.png",@"Bluefin.png",@"CPK.png",@"Cottage.png",@"DBar.png",@"Eureka.png",@"ExtraordinaryDesserts.png", @"MignonPho.png",@"SabELee.png",@"Tajima.png",@"Snooze.png",@"TGIF.png", nil];
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
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
    MenuCell *cell = (MenuCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_NAME forIndexPath:indexPath];;;
    
    
    NSString *string = [foodPicArray objectAtIndex:indexPath.row];
    
    if(string){
        NSLog(string);
        cell.backgroundImage.image =  [UIImage imageNamed:string];
    }
    else
    {
        cell.backgroundImage.image = [UIImage imageNamed:@"BJ's"];
    
    }
    
    
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"PopUpTest" sender:self];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PopUpTest"])
    {
        MZFormSheetSegue *formSheetSegue = (MZFormSheetSegue *)segue;
        MZFormSheetController *formSheet = formSheetSegue.formSheetController;
        formSheet.transitionStyle = MZFormSheetTransitionStyleBounce;
        formSheet.cornerRadius = 8.0;
        formSheet.didTapOnBackgroundViewCompletionHandler = ^(CGPoint location) {
        };
        
        formSheet.shouldDismissOnBackgroundViewTap = YES;
        formSheet.didPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        
        };
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
