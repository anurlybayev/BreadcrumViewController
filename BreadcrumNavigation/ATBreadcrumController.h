//
//  ATBreadcrumController.h
//  BreadcrumNavigation
//
//  Created by Akbar Nurlybayev on 2014-04-16.
//  Copyright (c) 2014 Akbar Nurlybayev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ATBreadcrumDataSource <NSObject>
@optional
- (NSString *)breadcrumTitle;
- (NSString *)breadcrumSubtitle;

@end

@interface ATBreadcrumController : UIViewController

@property(nonatomic, strong, readonly) UIViewController *visibleViewController;
@property(nonatomic, strong) NSArray *viewControllers;

- (instancetype)initWithViewControllers:(NSArray *)viewControllers;

- (void)pushViewControllerAnimated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated;
- (void)popToRootViewControllerAnimated:(BOOL)animated;
- (void)goToViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
