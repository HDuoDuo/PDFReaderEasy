//
//  AppDelegate.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2013/12/17.
//  Copyright (c) 2013 James Kingdom. All rights reserved.
//

#import "AppDelegate.h"

#import <Crashlytics/Crashlytics.h>

#import "DocumentListViewController.h"
#import "Folder.h"
#import "FolderDocumentListViewModel.h"
#import "LibraryUtils.h"
#import "NSFileManager+PDFReaderAdditions.h"
#import "PDFDocument.h"
#import "PDFDocumentStore.h"
#import "PDFDocumentViewController.h"
#import "PDFRecentDocumentList.h"
#import "RecentDocumentListViewModel.h"
#import "RootFolder.h"

#import <AVOSCloud/AVOSCloud.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <NotificationCenter/NotificationCenter.h>
#import <UserNotifications/UserNotifications.h>
#endif

static NSString * const RestorationDocumentListTabBar = @"RestorationDocumentListTabBar";
static NSString * const RestorationDocumentListRecentNavi = @"RestorationDocumentListRecentNavi";
static NSString * const RestorationDocumentListRecent = @"RestorationDocumentListRecent";
static NSString * const RestorationDocumentListFolderNavi = @"RestorationDocumentListFolderNavi";
static NSString * const RestorationDocumentListFolder = @"RestorationDocumentListFolder";
static NSString * const RestorationPDFDocument = @"RestorationPDFDocument";
static NSString * const StoryboardPDFDocument = @"StoryboardPDFDocument";

static NSString * const LastAppVersion = @"LastAppVersion";


@interface AppDelegate () <UITabBarControllerDelegate,UNUserNotificationCenterDelegate>
@property (nonatomic, strong) PDFDocumentStore *documentStore;
@property (nonatomic, strong) DocumentListViewController *documentsViewController;
@property (nonatomic, strong) DocumentListViewController *recentViewController;
@property (nonatomic, assign) BOOL launchingWithURL;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (CrashlyticsEnabled()) {
        [Crashlytics startWithAPIKey:GetCrashlyticsAPIKey()];
    }
    [AVOSCloud setAllLogsEnabled:NO];
    [self registerForRemoteNotification];
    [self migrateIfNeeded];

    self.documentStore = PDFDocumentStore.new;
    [self.documentStore.rootFolder load];

    UITabBarController *tabBar = (UITabBarController *)[[self window] rootViewController];
    tabBar.delegate = self;

    self.documentsViewController = (DocumentListViewController *)[tabBar.viewControllers[0] topViewController];
    FolderDocumentListViewModel *folderModel =
            [[FolderDocumentListViewModel alloc] initWithFolder:self.documentStore.rootFolder];
    self.documentsViewController.viewModel = folderModel;
    [self.documentsViewController view];
    
    self.recentViewController = (DocumentListViewController *)[tabBar.viewControllers[1] topViewController];
    RecentDocumentListViewModel *recentModel =
            [[RecentDocumentListViewModel alloc] initWithDocumentList:self.documentStore.documentList];
    self.recentViewController.viewModel = recentModel;

    NSURL *URL = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    if (URL) {
        self.launchingWithURL = YES;
    }    

    return YES;
}


- (void)registerForRemoteNotification {

    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {

        UNUserNotificationCenter *uncenter = [UNUserNotificationCenter currentNotificationCenter];

        uncenter.delegate =self;
        [uncenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert+UNAuthorizationOptionBadge+UNAuthorizationOptionSound)
                                completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [[UIApplication sharedApplication] registerForRemoteNotifications];
                                    });
      
                                }];

        [uncenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            NSLog(@"%s\nline:%@\n-----\n%@\n\n", __func__, @(__LINE__), settings);
         
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
              
            } else if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
            
            } else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            
            }
        }];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIUserNotificationType types = UIUserNotificationTypeAlert |
        UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType types = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
#pragma clang diagnostic pop
}



- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [AVOSCloud handleRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
    // Create empty photo object
    NSLog(@"iOS10收到推送: %@", [userInfo[@"aps"] objectForKey:@"alert"]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:[userInfo[@"aps"] objectForKey:@"alert"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //TODO:处理远程推送内容
        NSLog(@"%@", userInfo);
    }
    completionHandler();
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    application.applicationIconBadgeNumber = 0;
}


- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    return !self.launchingWithURL;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}

- (UIViewController *)application:(UIApplication *)application
viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
                            coder:(NSCoder *)coder
{
    NSString *identifier = [identifierComponents lastObject];
    if ([identifier isEqual:RestorationPDFDocument]) {
        UIStoryboard *storyboard = [self.window.rootViewController storyboard];
        PDFDocumentViewController *vc =
                [storyboard instantiateViewControllerWithIdentifier:StoryboardPDFDocument];
        vc.hidesBottomBarWhenPushed = YES;
        PDFRecentDocumentList *documentList = self.documentStore.documentList;
        vc.document = [documentList.documents firstObject];
        [vc.document.store addHistory:vc.document];
        return vc;
    }
    return nil;
}
						
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation 
{
    NSString *fileName = [url lastPathComponent];
    NSURL *dirURL = [[url URLByDeletingLastPathComponent] URLByDeletingLastPathComponent];
    NSURL *destURL = [dirURL URLByAppendingPathComponent:fileName];

    NSFileManager *fm = [NSFileManager new];
    NSURL *uniqueDestURL = [fm grt_incrementURLIfNecessary:destURL];
    if ([fm moveItemAtURL:url
                    toURL:uniqueDestURL
                    error:NULL]) {
        NSString *path = [[uniqueDestURL path] stringByRemovingPercentEncoding];
        PDFDocument *document = [self.documentStore documentAtPath:path];
        [self.documentStore addHistory:document];
        [self openURL:uniqueDestURL];
        return YES;
    }
    return NO;
}

#pragma mark - Open Document in GreatReader

- (void)openURL:(NSURL *)URL
{
    [self.documentsViewController reload];
    [self.recentViewController reload];

    [self.documentsViewController.navigationController
        popToRootViewControllerAnimated:NO];
    [self.recentViewController.navigationController
        popToRootViewControllerAnimated:NO];

    UITabBarController *tab = (UITabBarController *)[[self window] rootViewController];
    UINavigationController *selected = (UINavigationController *)tab.selectedViewController;
    UIViewController *top = selected.topViewController == self.documentsViewController
            ? self.documentsViewController
            : self.recentViewController;

    void (^open)(void) = ^{
        [top performSelector:@selector(openDocumentsAtURL:)
                  withObject:URL
                  afterDelay:0];
    };

    if (top.presentedViewController) {
        [top dismissViewControllerAnimated:NO
                                completion:open];
    } else {
        open();
    }
}

#pragma mark -

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    tabBarController.title = viewController.title;
}

#pragma mark -

- (void)migrateIfNeeded
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:LastAppVersion];
    if (!lastVersion) {
        [self copySamplePDFFiles];
    }
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [defaults setObject:currentVersion forKey:LastAppVersion];
    [defaults synchronize];
}

- (void)copySamplePDFFiles
{
    NSArray *pdfs = @[@"Pride and Prejudice",
                      @"The Adventres of Sherlock Holmes"];
    NSFileManager *fm = [NSFileManager new];
    for (NSString *pdf in pdfs) {
        NSString *path = [[NSBundle mainBundle] pathForResource:pdf ofType:@"pdf"];
        NSString *toPath = [[[NSFileManager grt_documentsPath]
                               stringByAppendingPathComponent:pdf]
                               stringByAppendingPathExtension:@"pdf"];
        NSError *error = nil;
        [fm copyItemAtPath:path
                    toPath:toPath
                     error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
    }
}

@end
