//
//  ImageListViewController.m
//  TitleScreen
//
//  Created by Josh Anatalio on 5/4/14.
//  Copyright (c) 2014 JoshAnatalio. All rights reserved.
//

#import "ImageListViewController.h"
#import <MZFormSheetBackgroundWindowViewController.h>
#import <CHTCollectionViewWaterfallLayout.h>

@interface ImageListViewController ()

@end

@implementation ImageListViewController{
    NSMutableArray *array;
    int i;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    array = [[NSMutableArray alloc]initWithObjects:@"BJs.png",@"Bluefin.png",@"CPK.png",@"Cottage.png",@"DBar.png",@"Eureka.png",@"ExtraordinaryDesserts.png", @"MignonPho.png",@"SabELee.png",@"Tajima.png",@"Snooze.png",@"TGIF.png", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Collection View Methods
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [array count];
}
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCell" forIndexPath:indexPath];
    
    //UIImageView *pic = (UIImageView *)[cell viewWithTag:69];
    NSString *string = [array objectAtIndex:indexPath.row];
    
    if(string){
        NSLog(string);
        cell.backgroundImage.image =  [UIImage imageNamed:string];
    }
    
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}
#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *searchTerm = array[indexPath.section];
    UIImage *photo = [UIImage imageNamed:searchTerm];
    // 2
    CGSize retval = photo.size.width > 0 ? photo.size : CGSizeMake(100, 100);
    retval.height += 0; retval.width += 0;
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}
/*
#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    NSString *searchTerm = self.searches[section];
    return [self.searchResults[searchTerm] count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return [self.searches count];
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FlickrCell " forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
// 4
- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/


@end
