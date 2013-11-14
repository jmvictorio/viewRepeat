//
//  ViewController.h
//  viewRepeat
//
//  Created by Jesus Victorio on 29/10/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<UIScrollViewDelegate, UIGestureRecognizerDelegate,CLLocationManagerDelegate>{
    
    float longitud;
    float latitud;
}

- (IBAction)changePage:(id)sender;

// Handle Gestures

//- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gesture;
@property (nonatomic, strong) UIPanGestureRecognizer *dedo;

@property (nonatomic, strong) UIScrollView *scrollInbox;

@property (nonatomic, strong) UIPageControl *pages;

@property(nonatomic, retain) CLLocationManager *locationManager;

@end
