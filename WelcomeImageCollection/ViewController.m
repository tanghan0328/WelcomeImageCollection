//
//  ViewController.m
//  WelcomeImageCollection
//
//  Created by tang on 16/6/21.
//  Copyright © 2016年 tang. All rights reserved.
//

#define identifier @"welcomeCell"

//屏幕宽度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSMutableArray *imageArray;
@property (nonatomic, assign)Boolean isFullScreen;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, assign)int currentIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = [NSMutableArray arrayWithArray:@[@"001.jpg",@"002.jpg",@"003.jpg"]];
    [self intiWithCollection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)intiWithCollection
{
    int imageCount = self.imageArray.count;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    layout.minimumInteritemSpacing = 0.0f;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    self.collectionView.contentSize = CGSizeMake(SCREEN_WIDTH*imageCount, SCREEN_HEIGHT);
    self.collectionView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:_collectionView];
    
    //pageControl 一直不居中  只能这样设置了
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT- 60, 40, 40)];
    
    self.pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.pageControl.numberOfPages = self.imageArray.count;
    if(self.imageArray.count == 1){
        self.pageControl.alpha = 0;
    }
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor greenColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self.view insertSubview:_pageControl aboveSubview:_collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSLog(@"indexPath.row ====>%ld",(long)indexPath.row);
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_imageArray[indexPath.row]]];
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [cell.contentView addSubview:imageView];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //得到每页宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    _currentIndex = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    if(_currentIndex == _imageArray.count-1){
        
    }
    self.pageControl.currentPage = _currentIndex;
}


@end
