//
//  DocumentListCollectionViewController.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/6/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "DocumentListViewController.h"

@interface DocumentListCollectionViewController : DocumentListViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@end
