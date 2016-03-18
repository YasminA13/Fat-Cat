//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"


@interface LPGViewController ()

//PROPERTIES

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImage *defaultImage;
@property (nonatomic) UIImage *grumpyImage;
@property (nonatomic) UIImageView *bucketView;
@property (nonatomic) UIImageView *appleView;
@property (nonatomic) UIImageView *appleView2;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture2;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;
@property (nonatomic, strong) UIPinchGestureRecognizer *feedCat;

@end

@implementation LPGViewController




#pragma mark - View Lifecycle

//VIEW

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareSubviews];
    [self prepareGestureRecognizers];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.petImageView.userInteractionEnabled = YES;
    self.defaultImage = [UIImage imageNamed: @"default"];
    self.grumpyImage = [UIImage imageNamed:@"grumpy"];
    self.petImageView.image = self.defaultImage;
    
    [self prepareGestureRecognizers];
    
    [self.view addSubview:self.petImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    
    
    
}

- (void) prepareSubviews
{
    
//BUCKET IMAGE
    
    UIImageView *bucketView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bucket"]];
    
    bucketView.translatesAutoresizingMaskIntoConstraints = NO;
    bucketView.userInteractionEnabled = YES;
    [self.view addSubview:bucketView];
    [bucketView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [bucketView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [bucketView.widthAnchor constraintEqualToConstant:100].active = YES;
    [bucketView.heightAnchor constraintEqualToConstant:100].active = YES;
    
    
//APPLE IMAGE
    
    self.appleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple"]];
    self.appleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleView.userInteractionEnabled = YES;
    [self.view addSubview:self.appleView];
    
    
//CENTERING APPLE IMAGE IN BUCKET
    
    NSLayoutConstraint *appleY = [self.appleView.centerYAnchor constraintEqualToAnchor:bucketView.centerYAnchor];
    appleY.active = YES;
    [self.appleView.centerXAnchor constraintEqualToAnchor:bucketView.centerXAnchor].active = YES;
    [self.appleView.widthAnchor constraintEqualToConstant:50].active = YES;
    [self.appleView.heightAnchor constraintEqualToConstant:50].active = YES;
    
}


//GESTURES

- (void) prepareGestureRecognizers
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pettingCat:)];
    [self.petImageView addGestureRecognizer: panGesture];
    
    UILongPressGestureRecognizer *pinchGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longApple:)];
    [self.appleView addGestureRecognizer:pinchGesture];
}


//SELECT APPLE

-(void)longApple:(UILongPressGestureRecognizer*)longGesture
{
    NSLog(@"Long Press");
    
    if (longGesture.state == UIGestureRecognizerStateBegan)
    {
    
    CGRect rect = CGRectMake(self.appleView.frame.origin.x + 20,
                             self.appleView.frame.origin.y - 20,
                             self.appleView.frame.size.width,
                             self.appleView.frame.size.height);
    self.appleView2 = [[UIImageView alloc] initWithFrame:rect];
    self.appleView2.image = [UIImage imageNamed:@"apple"];
    self.appleView2.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveApple:)];
    [self.appleView2 addGestureRecognizer: panGesture];
    [self.view addSubview:self.appleView2];
    }
}

//MOVE APPLE

-(void)moveApple:(UIPanGestureRecognizer*)panGesture
    {
    NSLog(@"moving: %@", NSStringFromCGPoint([panGesture locationInView:nil]));
    
    switch (panGesture.state)
        {
            
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"Time to feed the Fat Cat");
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            self.appleView2.center = [panGesture locationInView:nil];
            NSLog(@"Any second now!");
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            CGPoint endPoint = [panGesture locationInView:self.view];
            if (CGRectContainsPoint(self.petImageView.frame, endPoint)) {
                NSLog(@"YUMMY! PURR!");
                
                [UIView animateWithDuration:1 animations:^{
                    self.appleView2.alpha = 0.0; 
                } completion:^(BOOL finished) {
                    [self.appleView2 removeFromSuperview];
                    self.appleView2 = nil;
                    
                }];

        }
            
        else
        {
            [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.appleView2.frame = CGRectMake(CGRectGetMaxX(self.view.frame), CGRectGetMaxY(self.view.frame), self.appleView2.frame.size.width,self.appleView2.frame.size.height);
        }
            completion:^(BOOL finished)
            {
                    
            }];
            
            }
                break;
        }
            
            default:
                break;
            
    }
}

//PETTING CAT

- (void)pettingCat:(UIPanGestureRecognizer *)panGesture
{
    switch (panGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"GESTURE BEGAN");
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint velocity = [panGesture velocityInView:self.view];
            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
            NSLog(@"%f", magnitude);
            if (magnitude > 75)
            {
                self.petImageView.image = self.grumpyImage;
                break;
            }
            else
            {
                self.petImageView.image = self.defaultImage;
                NSLog(@"Soft kitty, warm kitty, little ball of fur. Happy kitty, sleepy kitty, purr, purr, purr");
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"If you're not gonna pet me, at least feed me!!");
            break;
        }
        default:
            break;
    }
}



@end
