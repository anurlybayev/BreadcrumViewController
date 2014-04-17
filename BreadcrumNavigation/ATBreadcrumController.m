//
//  ATBreadcrumController.m
//  BreadcrumNavigation
//
//  Created by Akbar Nurlybayev on 2014-04-16.
//  Copyright (c) 2014 Akbar Nurlybayev. All rights reserved.
//

#import "ATBreadcrumController.h"
#import "ATBreadcrumView.h"

@interface ATBreadcrumController ()

@property(nonatomic, strong, readonly) NSMutableArray *navItems;
@property(nonatomic, strong) UIViewController *visibleViewController;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end

@implementation ATBreadcrumController

@synthesize navItems = _navItems;

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
{
    self = [super init];
    if (self) {
        if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
            self.viewControllers = viewControllers;
        }
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat padding = 60.0f;
    __block CGFloat x = padding;
    CGFloat y = 0.0f;
    CGFloat width = (CGRectGetWidth(self.headerView.bounds) - 2*padding) / [self.viewControllers count];
    CGFloat height = CGRectGetHeight(self.headerView.bounds);
    [self.viewControllers enumerateObjectsUsingBlock:^(id<ATBreadcrumDataSource> vc, NSUInteger idx, BOOL *stop) {
        
        ATBreadcrumView *crum = [[ATBreadcrumView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [crum addGestureRecognizer:tap];
        
        if ([vc respondsToSelector:@selector(breadcrumTitle)]) {
            NSLog(@"%@", [vc breadcrumTitle]);
            crum.titleLabel.text = [vc breadcrumTitle];
        }
        if ([vc respondsToSelector:@selector(breadcrumSubtitle)]) {
            NSLog(@"%@", [vc breadcrumSubtitle]);
            crum.subtitleLabel.text = [vc breadcrumSubtitle];
        }
        
        [self.headerView addSubview:crum];
        [self.navItems addObject:crum];
        x += CGRectGetWidth(crum.frame);
    }];
    
    [self goToViewController:[self.viewControllers firstObject] animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)navItems
{
    if (!_navItems) {
        _navItems = [[NSMutableArray alloc] init];
    }
    return _navItems;
}

- (void)setVisibleViewController:(UIViewController *)visibleViewController
{
    if (_visibleViewController) {
        [_visibleViewController.view removeFromSuperview];
    }
    _visibleViewController = visibleViewController;
    [self.contentView addSubview:visibleViewController.view];
}

- (void)tap:(UIGestureRecognizer *)tap
{
    NSInteger idx = [self.navItems indexOfObject:tap.view];
    UIViewController *vc = [self.viewControllers objectAtIndex:idx];
    [self goToViewController:vc animated:YES];
}

#pragma mark - Public Methods

- (void)pushViewControllerAnimated:(BOOL)animated
{
    NSInteger visibleViewControllerIndex = [self.viewControllers indexOfObject:self.visibleViewController];
    NSInteger nextViewControllerIndex = visibleViewControllerIndex + 1;
    UIViewController *nextViewController = (nextViewControllerIndex < [self.viewControllers count]) ? [self.viewControllers objectAtIndex:nextViewControllerIndex] : nil;
    [self goToViewController:nextViewController animated:animated];
}

- (void)popViewControllerAnimated:(BOOL)animated
{
    NSInteger visibleViewControllerIndex = [self.viewControllers indexOfObject:self.visibleViewController];
    NSInteger prevViewControllerIndex = visibleViewControllerIndex - 1;
    UIViewController *prevViewController = (prevViewControllerIndex >= 0) ? [self.viewControllers objectAtIndex:prevViewControllerIndex] : nil;
    [self goToViewController:prevViewController animated:animated];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
{
    [self goToViewController:[self.viewControllers objectAtIndex:0] animated:animated];
}

- (void)goToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.visibleViewController = viewController;
}

@end
