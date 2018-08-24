//
//  DocumentListTableViewController.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/5/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "DocumentListTableViewController.h"

#import "Device.h"
#import "DocumentListViewModel.h"
#import "DocumentTableViewCell.h"
#import "NSArray+PDFReaderAdditions.h"
#import "PDFDocument.h"
#import "PDFDocumentStore.h"
#import "PDFRecentDocumentList.h"
#import "PDFDocumentViewController.h"

@interface DocumentListTableViewController ()
@property (nonatomic, strong, readwrite) id<DocumentCell> selectedDocumentCell; 
@end

@implementation DocumentListTableViewController

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    self.tableView.allowsMultipleSelectionDuringEditing = editing;    
    [self.tableView setEditing:editing animated:animated];
}

#pragma mark -

- (void)delete:(id)sender
{

    
    UIAlertController *sheet =  [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:LocalizedString(@".cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *destructive = [UIAlertAction actionWithTitle:LocalizedString(@".delete") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.viewModel removeDocumentHistories:self.selectedDocuments];
        [self deleteCellsAtIndexPaths:self.selectedIndexPaths];
        [self updateButtonsEnabled];
    }];
    UIAlertAction *other = [UIAlertAction actionWithTitle:LocalizedString(@".remove-history") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [sheet addAction:cancel];
    [sheet addAction:destructive];
    [sheet addAction:other];
    [self presentViewController:sheet animated:YES completion:nil];
}
- (void)deleted:(id)sender
{
    
    
    UIAlertController *sheet =  [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:LocalizedString(@".cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *destructive = [UIAlertAction actionWithTitle:LocalizedString(@".delete") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.viewModel removeDocumentHistories:self.selectedDocuments];
        [self deleteCellsAtIndexPaths:self.selectedIndexPaths];
        [self updateButtonsEnabled];
    }];
    UIAlertAction *other = [UIAlertAction actionWithTitle:LocalizedString(@".remove-history") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [sheet addAction:cancel];
    [sheet addAction:destructive];
    [sheet addAction:other];
    [self presentViewController:sheet animated:YES completion:nil];
}
#pragma mark - UIActionSheet Delegate


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DocumentTableViewCell *cell =
            [tableView dequeueReusableCellWithIdentifier:DocumentListViewControllerCellIdentifier];
    cell.document = [self.viewModel documentAtIndex:indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUInteger index = indexPath.row;
        [self.viewModel removeDocumentHistories:@[[self.viewModel documentAtIndex:index]]];
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing) {
        [self updateButtonsEnabled];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing) {
        [self updateButtonsEnabled];
    } else {
        DocumentTableViewCell *cell = (DocumentTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:DocumentListViewControllerSeguePDFDocument
                                  sender:cell];
        self.selectedDocumentCell = cell;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
/***- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (self.editing) {
 [self updateButtonsEnabled];
 }
 }
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (self.editing) {
 [self updateButtonsEnabled];
 } else {
 DocumentTableViewCell *cell = (DocumentTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
 [self performSegueWithIdentifier:DocumentListViewControllerSeguePDFDocument
 sender:cell];
 self.selectedDocumentCell = cell;
 [tableView deselectRowAtIndexPath:indexPath animated:YES];
 }
 }*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark -

- (void)registerNibForCell
{
    UINib *nib = [UINib nibWithNibName:@"DocumentTableViewCell" bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:DocumentListViewControllerCellIdentifier];
}

- (void)reloadView
{
    [self.tableView reloadData];

    if ([self.tableView numberOfRowsInSection:0] > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:NO];
    }
}

- (NSArray *)selectedIndexPaths
{
    return self.tableView.indexPathsForSelectedRows;
}

- (void)deleteCellsAtIndexPaths:(NSArray *)indexPaths
{
    [self.tableView deleteRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)openDocumentsAtURL:(NSURL *)URL
{
    for (int i = 0; i < self.viewModel.count; i++) {
        PDFDocument *document = [self.viewModel documentAtIndex:i];
        if ([document.path.lastPathComponent isEqual:URL.lastPathComponent]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath
                                        animated:YES
                                  scrollPosition:UITableViewScrollPositionMiddle];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                [self performSegueWithIdentifier:DocumentListViewControllerSeguePDFDocument
                                          sender:cell];
            });
        }
    }
}
- (void)openDocumentsAtURLs:(NSURL *)URL
{
    for (int i = 0; i < self.viewModel.count; i++) {
        PDFDocument *document = [self.viewModel documentAtIndex:i];
        if ([document.path.lastPathComponent isEqual:URL.lastPathComponent]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath
                                        animated:YES
                                  scrollPosition:UITableViewScrollPositionMiddle];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                [self performSegueWithIdentifier:DocumentListViewControllerSeguePDFDocument
                                          sender:cell];
            });
        }
    }
}
- (id<DocumentCell>)documentCellForDocument:(PDFDocument *)document
{
    for (DocumentTableViewCell *cell in [self.tableView visibleCells]) {
        if (cell.document == document) {
            return cell;
        }
    }
    return nil;
}

@end
