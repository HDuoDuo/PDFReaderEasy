//
//  PDFDocumentBrightnessViewController.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 3/17/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "PDFDocumentBrightnessViewController.h"

#import "Device.h"
#import "PDFDocument.h"
#import "PDFDocumentViewController.h"


@interface PDFDocumentBrightnessViewController () <UITableViewDataSource,
                                                UITableViewDelegate>
// Common
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UINavigationBar *naviBar;
@property (nonatomic, strong) UITableViewCell *sliderCell;
// iPhone
@property (nonatomic, strong) IBOutlet UIView *dimView;
@property (nonatomic, strong) IBOutlet UIView *sheetView;
@end

@implementation PDFDocumentBrightnessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (IsPhone()) {
        UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:LocalizedString(@".brightness")];
        item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(done:)];
        [self.naviBar setItems:@[item] animated:NO];
    }

    self.tableView.scrollEnabled = NO;

    [self prepareCells];
}

- (void)prepareCells
{
    self.sliderCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:nil]; {
        self.sliderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISlider *slider = [[UISlider alloc] initWithFrame:({
            CGRect f = self.sliderCell.contentView.bounds;
            f.origin.x = 20;
            f.size.width -= (CGRectGetMinX(f) * 2);
            f;
        })];
        slider.value = self.document.brightness;
        [slider addTarget:self
                   action:@selector(sliderChanged:)
         forControlEvents:UIControlEventValueChanged];
        slider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.sliderCell.contentView addSubview:slider];
    }
}
- (void)prepareCell
{
    self.sliderCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:nil]; {
        self.sliderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.view.frame.size.height == 812) {
//            UISlider *slider = [[UISlider alloc] initWithFrame:({
//                CGRect f = self.sliderCell.contentView.bounds;
//                f.origin.x = 80;
//                f.size.width -= (CGRectGetMinX(f) * 2);
//                f;
//            })];
        }
        UISlider *slider = [[UISlider alloc] initWithFrame:({
            CGRect f = self.sliderCell.contentView.bounds;
            f.origin.x = 20;
            f.size.width -= (CGRectGetMinX(f) * 2);
            f;
        })];
        slider.value = self.document.brightness;
        [slider addTarget:self
                   action:@selector(sliderChanged:)
         forControlEvents:UIControlEventValueChanged];
        slider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.sliderCell.contentView addSubview:slider];
    }
}
- (IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)sliderChanged:(UISlider *)slider
{
    self.document.brightness = slider.value;
}

- (void)cropEnabledSwitchChanged:(UISwitch *)sw
{
    [self.tableView reloadData];
}

- (void)cropSameSwitchChanged:(UISwitch *)sw
{
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.sliderCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

@end


