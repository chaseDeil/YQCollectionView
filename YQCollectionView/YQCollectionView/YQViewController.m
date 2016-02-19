//
//  ViewController.m
//  YQCollectionView
//
//  Created by chase on 16/2/18.
//  Copyright © 2016年 chase_liu. All rights reserved.
//

#import "YQViewController.h"
#import "YQMoveCollectionViewCell.h"

@interface YQViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, assign) NSInteger deleteIndexPath;

@end

@implementation YQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"长按拖拽Demo";
    self.dataArray = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
    [self createCollectionView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[YQMoveCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    //********添加长按手势***********
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPress.delegate = self;
    [_collectionView addGestureRecognizer:longPress];
    
    _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 20, 20)];
    _deleteButton.backgroundColor = [UIColor redColor];
    [_deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}


// ****************删除事件*******************
- (void)deleteButtonAction:(UIButton *)sender
{
    [_dataArray removeObjectAtIndex:_deleteIndexPath];
    [_deleteButton removeFromSuperview];
    [_collectionView reloadData];
}

//*****************长按事件*******************
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    static NSIndexPath *sourceIndex = nil;
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            
            NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:[longPress locationInView:_collectionView]];
            UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
            _deleteButton.hidden = NO;
            [cell addSubview:_deleteButton];
            [UIView animateWithDuration:0.5 animations:^{
                
            }];
            _deleteIndexPath = indexPath.row;
            sourceIndex = indexPath;
            [_deleteButton bringSubviewToFront:_collectionView];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:[longPress locationInView:_collectionView]];
            if (indexPath && ![indexPath isEqual:sourceIndex]) {
                [_dataArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndex.row];
                [_collectionView moveItemAtIndexPath:sourceIndex toIndexPath:indexPath];
                sourceIndex = indexPath;
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:[longPress locationInView:_collectionView]];
            if (indexPath && ![indexPath isEqual:sourceIndex]) {
                [_dataArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndex.row];
                [_collectionView moveItemAtIndexPath:sourceIndex toIndexPath:indexPath];
                [_collectionView reloadData];
            }
        }
        default:
            break;
    }
}

#pragma mark - CollectionView delegate && dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YQMoveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.borderColor=[UIColor darkGrayColor].CGColor;
    cell.layer.borderWidth=0.3;
    [cell.titleLabel setText:_dataArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize rect = CGSizeMake(79, 80);
    return rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
