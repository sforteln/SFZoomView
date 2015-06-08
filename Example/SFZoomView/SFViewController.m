//
//  SFViewController.m
//  SFZoomView
//
//  Created by Simon Fortelny on 06/05/2015.
//  Copyright (c) 2014 Simon Fortelny. All rights reserved.
//

#import "SFViewController.h"
#import "UIView+SFZoomView.h"

@interface SFViewController ()

@property (nonatomic,weak) IBOutlet UIButton *zoomButton;
@property (nonatomic,weak) IBOutlet UIStepper *zoomStepper;
@property (nonatomic,weak) UIView *zoomedOutView;

@end

@implementation SFViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /*
     * You can create UIView's and zoom them out before adding them to the view hierarchy
     */
    UIView *zoomedOutView = [[UIView alloc]initWithFrame:CGRectMake(30, 30, 100, 100)];
    zoomedOutView.backgroundColor = [UIColor redColor];
    [zoomedOutView sf_makeZoomedOut];
    [self.view addSubview:zoomedOutView];
    self.zoomedOutView = zoomedOutView;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    [self.zoomedOutView addGestureRecognizer:tapGesture];
}

- (IBAction)resetPressed:(id)sender {
    [self.zoomButton sf_zoomIn];
    [self.zoomStepper sf_zoomIn];
    [self.zoomedOutView sf_zoomIn];
}

- (void)viewTapped:(UITapGestureRecognizer *)gesture {
    [gesture.view sf_zoomOut];
}

- (IBAction)zoomPressed:(UIView *)sender {
    [sender sf_zoomOut];
}

@end
