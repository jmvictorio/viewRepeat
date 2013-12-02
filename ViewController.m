//
//  ViewController.m
//  viewRepeat
//
//  Created by Jesus Victorio on 29/10/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "ViewController.h"
#import "ForecastKit.h"
#import <AFNetworking.h>
#import "Weather.h"
#import "MRProgress.h"
#import <AFNetworking/UIActivityIndicatorView+AFNetworking.h>
#import "UIFont+PCUtils.h"

@interface ViewController ()
{
    UIActivityIndicatorView *spinner;
    UIView *vistaScroll;
    
    NSMutableArray *week;
    
    UIView *first2;
    UILabel *date;
    UILabel *time;
    
    UIView *second2;
    UIImageView *state;
    NSString *icon;
    UILabel *temperature;
    UILabel *resume;
    
    NSDate *now;
    
    Weather *weather;
    UIView *third2;
     UIImageView *iconDay1;
     UIImageView *iconDay2;
     UIImageView *iconDay3;
     UIImageView *iconDay4;
     UIImageView *iconDay5;
    UILabel *day1;
    UILabel *day2;
    UILabel *day3;
    UILabel *day4;
    UILabel *day5;
     UILabel *infoMin1;
     UILabel *infoMin2;
     UILabel *infoMin3;
     UILabel *infoMin4;
     UILabel *infoMin5;
    UILabel *infoMax1;
    UILabel *infoMax2;
    UILabel *infoMax3;
    UILabel *infoMax4;
    UILabel *infoMax5;
    //////////////////////////////////
    
    int primera;
    int segunda;
    int tercera;
    int actual;
    NSTimer *timer;
    NSTimer *timer2;
    int bandera;
    int contador;
    int ancho;
    int vuelta;
    int paginaActual;
}

@end

@implementation ViewController
@synthesize scrollInbox, pages, dedo;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup2];
    
}
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}



- (void)gestionaLocalizacion:(UIView *)vistatemp{
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    
    if([CLLocationManager locationServicesEnabled]){
        self.locationManager.delegate = self;
        
        
        [self.locationManager startUpdatingLocation];
        
    }
    BOOL locationAvailable = self.locationManager.location!=nil;
    if(locationAvailable){
        
        //latitud = 40.67;
        //longitud = -73.94;
        latitud = self.locationManager.location.coordinate.latitude;
        longitud = self.locationManager.location.coordinate.longitude;
        
    }else{
        //COORDENADAS MANHATTAN
        latitud = 40.67;
        longitud = -73.94;
    }
    
    //ForecastKit *forecast = [[ForecastKit alloc] initWithAPIKey:@"0b32c5e989fe10a2060dca536b5f76cc"];
    
    
    /*[forecast getCurrentConditionsForLatitude:latitud longitude:longitud success:^(NSMutableDictionary *responseDict) {
     
     NSLog(@"Temperatura: %@", responseDict);
     NSString *temp=[[NSString alloc] initWithFormat:@"%@",[responseDict objectForKey:@"apparentTemperature"]];
     NSString *icono=[[NSString alloc] initWithFormat:@"%@",[responseDict objectForKey:@"summary"]];
     temperature.text=temp;
     icon.text=icono;
     } failure:^(NSError *error){
     
     NSLog(@"Currently %@", error.description);
     
     }];*/
     NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"minutely,hourly,flags,alerts", @"exclude", nil];
    //NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"currently", @"exclude", nil];

    [spinner startAnimating];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"https://api.forecast.io/forecast/%@/%.6f,%.6f", @"0b32c5e989fe10a2060dca536b5f76cc", latitud, longitud] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@", responseObject);
        icon=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:0] objectForKey:@"icon"];
        [self chooseIcon:icon imagen:state];
        
        weather.icono1=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:1] objectForKey:@"icon"];
        weather.icono2=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:2] objectForKey:@"icon"];
        weather.icono3=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:3] objectForKey:@"icon"];
        weather.icono4=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:4] objectForKey:@"icon"];
        weather.icono5=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:5] objectForKey:@"icon"];
        //[NSString ]
        
        weather.max1=[[NSString alloc]initWithFormat:@"%d",[[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:1] objectForKey:@"apparentTemperatureMax"] intValue]];
        weather.max2=[[NSString alloc]initWithFormat:@"%d",[[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:2] objectForKey:@"apparentTemperatureMax"] intValue]];
        weather.max3=[[NSString alloc]initWithFormat:@"%d",[[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:3] objectForKey:@"apparentTemperatureMax"] intValue]];
        weather.max4=[[NSString alloc]initWithFormat:@"%d",[[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:4] objectForKey:@"apparentTemperatureMax"] intValue]];
        weather.max5=[[NSString alloc]initWithFormat:@"%d",[[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:5] objectForKey:@"apparentTemperatureMax"] intValue]];
        
        weather.min1=[[NSString alloc]initWithFormat:@"%d",[[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:1] objectForKey:@"apparentTemperatureMin"]intValue]];
        weather.min2=[[NSString alloc]initWithFormat:@"%d",[[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:2] objectForKey:@"apparentTemperatureMin"]intValue]];
        weather.min3=[[NSString alloc]initWithFormat:@"%d",[[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:3] objectForKey:@"apparentTemperatureMin"]intValue]];
        weather.min4=[[NSString alloc]initWithFormat:@"%d",[[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:4] objectForKey:@"apparentTemperatureMin"]intValue]];
        weather.min5=[[NSString alloc]initWithFormat:@"%d",[[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:5] objectForKey:@"apparentTemperatureMin"]intValue]];
        
        
        
        [self chooseIcon:weather.icono1 imagen:iconDay1];
        [self chooseIcon:weather.icono2 imagen:iconDay2];
        [self chooseIcon:weather.icono3 imagen:iconDay3];
        [self chooseIcon:weather.icono4 imagen:iconDay4];
        [self chooseIcon:weather.icono5 imagen:iconDay5];
        infoMin1.text=[[NSString alloc] initWithFormat:@"L:  %@º",weather.min1];
        infoMin2.text=[[NSString alloc] initWithFormat:@"L:  %@º",weather.min2];
        infoMin3.text=[[NSString alloc] initWithFormat:@"L:  %@º",weather.min3];
        infoMin4.text=[[NSString alloc] initWithFormat:@"L:  %@º",weather.min4];
        infoMin5.text=[[NSString alloc] initWithFormat:@"L:  %@º",weather.min5];
        infoMax1.text=[[NSString alloc] initWithFormat:@"H: %@º",weather.max1];
        infoMax2.text=[[NSString alloc] initWithFormat:@"H: %@º",weather.max2];
        infoMax3.text=[[NSString alloc] initWithFormat:@"H: %@º",weather.max3];
        infoMax4.text=[[NSString alloc] initWithFormat:@"H: %@º",weather.max4];
        infoMax5.text=[[NSString alloc] initWithFormat:@"H: %@º",weather.max5];
        
        day1.text=[week objectAtIndex:0];
        day2.text=[week objectAtIndex:1];
        day3.text=[week objectAtIndex:2];
        day4.text=[week objectAtIndex:3];
        day5.text=[week objectAtIndex:4];
        
        //NSLog(@"%@",responseObject);
        temperature.text=[[NSString alloc] initWithFormat:@"%dº",[[[responseObject objectForKey:@"currently"] objectForKey:@"apparentTemperature"] intValue]];
        resume.text=[[NSString alloc] initWithFormat:@"%@",[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:0] objectForKey:@"summary"]];
       
        [spinner stopAnimating];
         timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(countup) userInfo:nil repeats:YES];
        [vistatemp setHidden:YES];
    } failure:nil];

    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    // Si solo lo necesitamos una vez podemos dejar de actualizar las coordenadas aunque el usuario se mueva.
    
    // [self.locationManager stopUpdatingLocation];
    
    // Si necesitamos una precisión bastante buena, dejaremos unos segundos para que siga actualizando antes de pararlo, ya que la primera vez suele devolver la última posición recogida, por el iOS o por cualquier otra aplicación.
    
    // Si no lo paramos, el método será llamado en función de la precisión establecida cada X metros.
    
    
    //Obtenemos las coordenadas.
    latitud = newLocation.coordinate.latitude;
    longitud = newLocation.coordinate.longitude;
    
    
}
- (void) dameDias:(NSString *)Hoy{
    week=[[NSMutableArray alloc]init];
    if([Hoy isEqualToString:@"Mon"]){
        [week addObject:@"Tue"];
        [week addObject:@"Wed"];
        [week addObject:@"Thu"];
        [week addObject:@"Fri"];
        [week addObject:@"Sat"];
    }else if([Hoy isEqualToString:@"Tue"]){
        [week addObject:@"Wed"];
        [week addObject:@"Thu"];
        [week addObject:@"Fri"];
        [week addObject:@"Sat"];
        [week addObject:@"Sun"];
    }else if([Hoy isEqualToString:@"Wed"]){
        [week addObject:@"Thu"];
        [week addObject:@"Fri"];
        [week addObject:@"Sat"];
        [week addObject:@"Sun"];
        [week addObject:@"Mon"];
    }else if([Hoy isEqualToString:@"Thu"]){
        [week addObject:@"Fri"];
        [week addObject:@"Sat"];
        [week addObject:@"Sun"];
        [week addObject:@"Mon"];
        [week addObject:@"Tue"];
    }else if([Hoy isEqualToString:@"Fri"]){
        [week addObject:@"Sat"];
        [week addObject:@"Sun"];
        [week addObject:@"Mon"];
        [week addObject:@"Tue"];
        [week addObject:@"Wed"];
    }else if([Hoy isEqualToString:@"Sat"]){
        [week addObject:@"Sun"];
        [week addObject:@"Mon"];
        [week addObject:@"Tue"];
        [week addObject:@"Wed"];
        [week addObject:@"Thu"];
    }else{
        [week addObject:@"Mon"];
        [week addObject:@"Tue"];
        [week addObject:@"Wed"];
        [week addObject:@"Thu"];
        [week addObject:@"Fri"];
    }
}
- (void) setup2{
    primera=0;
    segunda=320;
    tercera=-320;
    
    
    first2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];
    //DATES AND TIME
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy"];
    now = [[NSDate alloc] init];
    NSString *fecha = [format stringFromDate:now];
    [format setDateFormat:@"hh:mm:ss a"];
    NSString *tiempo = [format stringFromDate:now];
    [format setDateFormat:@"EE"];
    NSString *hoy=[format stringFromDate:now];
    [self dameDias:hoy];
    NSLog(@"%@",week);
    date=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 280, 38)];
    [date setTextAlignment:NSTextAlignmentCenter];
    date.text=fecha;
    date.font=[UIFont PCFontWithSize:17.0f];
    date.textColor=[UIColor whiteColor];
    
    time=[[UILabel alloc]initWithFrame:CGRectMake(20, 60, 280, 38)];
    [time setTextAlignment:NSTextAlignmentCenter];
    time.text=tiempo;
    time.textColor=[UIColor whiteColor];
    time.font=[UIFont PCFontWithSize:30.0f];
    timer2=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countup2) userInfo:nil repeats:YES];
    
    [first2 addSubview:date];
    [first2 addSubview:time];
    first2.backgroundColor=[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    
    second2 = [[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, 130)];
    temperature=[[UILabel alloc]initWithFrame:CGRectMake(179, 11, 95, 75)];
    [temperature setTextAlignment:NSTextAlignmentCenter];
    temperature.textColor=[UIColor whiteColor];
    temperature.font=[UIFont PCFontWithSize:40.0f];
    temperature.adjustsFontSizeToFitWidth = YES;
    
    resume=[[UILabel alloc]initWithFrame:CGRectMake(152, 75, 148, 40)];
    [resume setTextAlignment:NSTextAlignmentCenter];
    [resume setNumberOfLines:2];
    resume.font=[UIFont PCFontWithSize:15.0f];
    resume.textColor=[UIColor whiteColor];
    //resume.adjustsFontSizeToFitWidth = YES;
    
    state=[[UIImageView alloc] init];
    [state setFrame:CGRectMake(20, 11, 100, 100)];
    [second2 addSubview:temperature];
    [second2 addSubview:resume];
    [second2 addSubview:state];
    second2.backgroundColor=[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    
    third2 = [[UIView alloc] initWithFrame:CGRectMake(640, 0, 320, 130)];
    weather=[[Weather alloc] init];
    third2.backgroundColor=[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    iconDay1=[[UIImageView alloc] init];
    iconDay2=[[UIImageView alloc] init];
    iconDay3=[[UIImageView alloc] init];
    iconDay4=[[UIImageView alloc] init];
    iconDay5=[[UIImageView alloc] init];
    [iconDay1 setFrame:CGRectMake(20, 25, 44, 44)];
    [iconDay2 setFrame:CGRectMake(78, 25, 44, 44)];
    [iconDay3 setFrame:CGRectMake(136, 25, 44, 44)];
    [iconDay4 setFrame:CGRectMake(194, 25, 44, 44)];
    [iconDay5 setFrame:CGRectMake(252, 25, 44, 44)];
    
    day1=[[UILabel alloc]initWithFrame:CGRectMake(30, 3, 42, 21)];
    day2=[[UILabel alloc]initWithFrame:CGRectMake(89, 3, 42, 21)];
    day3=[[UILabel alloc]initWithFrame:CGRectMake(148, 3, 42, 21)];
    day4=[[UILabel alloc]initWithFrame:CGRectMake(207, 3, 42, 21)];
    day5=[[UILabel alloc]initWithFrame:CGRectMake(266, 3, 42, 21)];
    
    day1.font=[UIFont PCFontWithSize:13.0f];
    day1.adjustsFontSizeToFitWidth = YES;
    day1.textColor=[UIColor whiteColor];
    day2.font=[UIFont PCFontWithSize:13.0f];
    day2.adjustsFontSizeToFitWidth = YES;
    day2.textColor=[UIColor whiteColor];
    day3.font=[UIFont PCFontWithSize:13.0f];
    day3.adjustsFontSizeToFitWidth = YES;
    day3.textColor=[UIColor whiteColor];
    day4.font=[UIFont PCFontWithSize:13.0f];
    day4.adjustsFontSizeToFitWidth = YES;
    day4.textColor=[UIColor whiteColor];
    day5.font=[UIFont PCFontWithSize:13.0f];
    day5.adjustsFontSizeToFitWidth = YES;
    day5.textColor=[UIColor whiteColor];
    
    infoMax1=[[UILabel alloc]initWithFrame:CGRectMake(21, 75, 42, 21)];
    infoMax2=[[UILabel alloc]initWithFrame:CGRectMake(79, 75, 42, 21)];
    infoMax3=[[UILabel alloc]initWithFrame:CGRectMake(137, 75, 42, 21)];
    infoMax4=[[UILabel alloc]initWithFrame:CGRectMake(195, 75, 42, 21)];
    infoMax5=[[UILabel alloc]initWithFrame:CGRectMake(253, 75, 42, 21)];
    infoMin1=[[UILabel alloc]initWithFrame:CGRectMake(21, 94, 42, 21)];
    infoMin2=[[UILabel alloc]initWithFrame:CGRectMake(79, 94, 42, 21)];
    infoMin3=[[UILabel alloc]initWithFrame:CGRectMake(137, 94, 42, 21)];
    infoMin4=[[UILabel alloc]initWithFrame:CGRectMake(195, 94, 42, 21)];
    infoMin5=[[UILabel alloc]initWithFrame:CGRectMake(253, 94, 42, 21)];
    
    infoMax1.font=[UIFont PCFontWithSize:15.0f];
    infoMax1.adjustsFontSizeToFitWidth = YES;
    infoMax1.textColor=[UIColor whiteColor];
    infoMax2.font=[UIFont PCFontWithSize:15.0f];
    infoMax2.adjustsFontSizeToFitWidth = YES;
    infoMax2.textColor=[UIColor whiteColor];
    infoMax3.font=[UIFont PCFontWithSize:15.0f];
    infoMax3.adjustsFontSizeToFitWidth = YES;
    infoMax3.textColor=[UIColor whiteColor];
    infoMax4.font=[UIFont PCFontWithSize:15.0f];
    infoMax4.adjustsFontSizeToFitWidth = YES;
    infoMax4.textColor=[UIColor whiteColor];
    infoMax5.font=[UIFont PCFontWithSize:15.0f];
    infoMax5.adjustsFontSizeToFitWidth = YES;
    infoMax5.textColor=[UIColor whiteColor];
    infoMin1.font=[UIFont PCFontWithSize:15.0f];
    infoMin1.adjustsFontSizeToFitWidth = YES;
    infoMin1.textColor=[UIColor whiteColor];
    infoMin2.font=[UIFont PCFontWithSize:15.0f];
    infoMin2.adjustsFontSizeToFitWidth = YES;
    infoMin2.textColor=[UIColor whiteColor];
    infoMin3.font=[UIFont PCFontWithSize:15.0f];
    infoMin3.adjustsFontSizeToFitWidth = YES;
    infoMin3.textColor=[UIColor whiteColor];
    infoMin4.font=[UIFont PCFontWithSize:15.0f];
    infoMin4.adjustsFontSizeToFitWidth = YES;
    infoMin4.textColor=[UIColor whiteColor];
    infoMin5.font=[UIFont PCFontWithSize:15.0f];
    infoMin5.adjustsFontSizeToFitWidth = YES;
    infoMin5.textColor=[UIColor whiteColor];
    
    [third2 addSubview:iconDay1];
    [third2 addSubview:iconDay2];
    [third2 addSubview:iconDay3];
    [third2 addSubview:iconDay4];
    [third2 addSubview:iconDay5];
    [third2 addSubview:infoMin1];
    [third2 addSubview:infoMin2];
    [third2 addSubview:infoMin3];
    [third2 addSubview:infoMin4];
    [third2 addSubview:infoMin5];
    [third2 addSubview:infoMax1];
    [third2 addSubview:infoMax2];
    [third2 addSubview:infoMax3];
    [third2 addSubview:infoMax4];
    [third2 addSubview:infoMax5];
    [third2 addSubview:day1];
    [third2 addSubview:day2];
    [third2 addSubview:day3];
    [third2 addSubview:day4];
    [third2 addSubview:day5];
    
    vistaScroll=[[UIView alloc]initWithFrame:CGRectMake(0, 20, 960, 170)];
    vistaScroll.backgroundColor=[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];

    
    self.scrollInbox = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, 960, 130)];
    [self.scrollInbox setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]];
    
    [scrollInbox setScrollEnabled:YES];
    [scrollInbox setPagingEnabled:YES];
    [scrollInbox setContentSize:CGSizeMake(960, 130)];
    scrollInbox.userInteractionEnabled=NO;
    [scrollInbox addSubview:first2];
    [scrollInbox addSubview:second2];
    [scrollInbox addSubview:third2];
    
    pages = [[UIPageControl alloc] init];
    pages.frame = CGRectMake(0,0,320,20);
    pages.numberOfPages = 3;
    pages.currentPage = 0;

    
    [vistaScroll addSubview:pages];
    [vistaScroll addSubview:scrollInbox];
    pages.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    pages.tintColor=[UIColor blackColor];
    
    [pages addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:vistaScroll];
    
    scrollInbox.decelerationRate = UIScrollViewDecelerationRateFast;
    
    dedo=[[UIPanGestureRecognizer alloc]init];
    
    [vistaScroll addGestureRecognizer:dedo];
    [dedo addTarget:self action:@selector(handlePanGestureRecognizer:)];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    
    spinner.tintColor=[UIColor blackColor];
    spinner.hidesWhenStopped = YES;
    spinner.frame = CGRectMake(140, 50, spinner.bounds.size.height, spinner.bounds.size.width);
    
    [vistaScroll addSubview:spinner];
    
    UIView *vistatemp=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    
    [self.view addSubview:vistatemp];
    [self gestionaLocalizacion:vistatemp];
    
    
                       //dispatch back to the main (UI) thread to stop the activity indicator
    
    
    //[MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
    
    
    
    ancho=0;
    contador=0;
    bandera=0;
    vuelta=0;
    paginaActual=0;
    
}
- (void)chooseIcon:(NSString *)icono imagen:(UIImageView *)imagen{
    if([icono isEqualToString:@"partly-cloudy-day"]){
        //NSLog(@"ENTRAAA");
        [imagen setImage:[UIImage imageNamed:@"partly-cloudy-day.png"]];
        
    }else if([icono isEqualToString:@"partly-cloudy-night"]){
        //NSLog(@"ENTRAAA2");
        [imagen setImage:[UIImage imageNamed:@"partly-cloudy-night.png"]];
        
    }else if([icono isEqualToString:@"clear-day"]){
        [imagen setImage:[UIImage imageNamed:@"clear-day.png"]];
        
    }else if([icono isEqualToString:@"rain"]){
        [imagen setImage:[UIImage imageNamed:@"rain.png"]];
        
    }else if([icono isEqualToString:@"fog"]){
        //NSLog(@"ENTRAAA2");
        [imagen setImage:[UIImage imageNamed:@"fog.png"]];
        
    }else if([icono isEqualToString:@"sleet"]){
        [imagen setImage:[UIImage imageNamed:@"sleey.png"]];
        
    }else if([icono isEqualToString:@"wind"]){
        [imagen setImage:[UIImage imageNamed:@"wind.png"]];
        
    }else if([icono isEqualToString:@"snow"]){
        //NSLog(@"ENTRAAA2");
        [imagen setImage:[UIImage imageNamed:@"snow.png"]];
        
    }else if([icono isEqualToString:@"cloudy"]){
        [imagen setImage:[UIImage imageNamed:@"cloudy.png"]];
        
    }else if([icono isEqualToString:@"clear-night"]){
        [imagen setImage:[UIImage imageNamed:@"clear-night.png"]];
        
    }
}
- (void)countup2{
    now = [[NSDate alloc] init];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"hh:mm:ss a"];
    NSString *tiempo = [format stringFromDate:now];
    time.text=tiempo;
}
- (void)countup{
    if(paginaActual==0){
        pages.currentPage=1;
        paginaActual=1;
        [self cambioDelante:1 actually:0];
    }else if(paginaActual==1){
        pages.currentPage=2;
        paginaActual=2;
        [self cambioDelante:2 actually:1];
    }else{
        pages.currentPage=0;
        paginaActual=0;
        [self cambioDelante:0 actually:2];
    }
}

- (void)cambioDelante:(int)new actually:(int)actually{
    if(new==0){
        [first2 setFrame:CGRectMake(primera, 0, 320, 130)];
        [scrollInbox setContentOffset:CGPointMake(primera, 0) animated:YES];
        tercera=(int)first2.frame.origin.x-320;
        segunda=(int)first2.frame.origin.x+320;
    }else{
        if(new==1){
                [second2 setFrame:CGRectMake(segunda, 0, 320, 130)];
                [scrollInbox setContentOffset:CGPointMake(segunda, 0) animated:YES];
                tercera=(int)second2.frame.origin.x+320;
                primera=(int)second2.frame.origin.x-320;
            
        }else{
                [third2 setFrame:CGRectMake(tercera, 0, 320, 130)];
                [scrollInbox setContentOffset:CGPointMake(tercera, 0) animated:YES];
                segunda=(int)third2.frame.origin.x-320;
                primera=(int)third2.frame.origin.x+320;
            
        }
    }
}
- (void)cambioAtras:(int)new actually:(int)actually{
    if(new==2){
        tercera=(int)first2.frame.origin.x-320;
        [third2 setFrame:CGRectMake(tercera, 0, 320, 130)];
        [scrollInbox setContentOffset:CGPointMake(tercera, 0) animated:YES];
        segunda=(int)third2.frame.origin.x-320;
        primera=(int)third2.frame.origin.x+320;
    }else{
        if(new==1){
                [second2 setFrame:CGRectMake(segunda, 0, 320, 130)];
                [scrollInbox setContentOffset:CGPointMake(segunda, 0) animated:YES];
                primera=(int)second2.frame.origin.x-320;
                tercera=(int)second2.frame.origin.x+320;
            
        }else{
                [first2 setFrame:CGRectMake(primera, 0, 320, 130)];
                [scrollInbox setContentOffset:CGPointMake(primera, 0) animated:YES];
                segunda=(int)first2.frame.origin.x+320;
                tercera=(int)first2.frame.origin.x-320;
            
        }
    }
}
- (void)cambioDesliza:(int)cont{
    if(pages.currentPage==1){
        pages.currentPage=cont;
        paginaActual=cont;
        if(cont<1){
            //NSLog(@"-> Desde la izquierda, proxima pagina es la %d",cont);
            [self cambioAtras:cont actually:1];
        }else{
            //NSLog(@"<- Desde la derecha, proxima pagina es la %d",cont);
            [self cambioDelante:cont actually:1];
        }
    }else if(pages.currentPage==0){
        pages.currentPage=cont;
        paginaActual=cont;
        if(cont==2){
            //NSLog(@"-> Desde la izquierda, proxima pagina es la %d",cont);
            [self cambioAtras:cont actually:0];
        }else{
            //NSLog(@"<- Desde la derecha, proxima pagina es la %d",cont);
            [self cambioDelante:cont actually:0];
        }
    }else{
        pages.currentPage=cont;
        paginaActual=cont;
        if(cont==1){
            //NSLog(@"-> Desde la izquierda, proxima pagina es la %d",cont);
            [self cambioAtras:cont actually:2];
        }else{
            //NSLog(@"<- Desde la derecha, proxima pagina es la %d",cont);
            [self cambioDelante:cont actually:2];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changePage:(id)sender {
    [timer invalidate];
    if([pages currentPage]==0){
        [self cambioAtras:0 actually:1];
        
    }else if([pages currentPage]==1){
        //[timer invalidate];
        if(paginaActual==2){
            [self cambioAtras:1 actually:2];
        }else{
            [self cambioDelante:1 actually:0];
        }
    }else{
        //[timer invalidate];
        [self cambioDelante:2 actually:1];
    }
    timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(countup) userInfo:nil repeats:YES];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gesture
{
		UIGestureRecognizerState states = [gesture state];
		CGPoint translation = [gesture translationInView:scrollInbox];
		if (states == UIGestureRecognizerStateBegan)
		{
			[timer invalidate];
		}
		else if (states == UIGestureRecognizerStateBegan || states == UIGestureRecognizerStateChanged)
		{
            
            if([pages currentPage]==0){
                [third2 setFrame:CGRectMake(tercera, 0, 320, 130)];
                [second2 setFrame:CGRectMake(segunda, 0, 320, 130)];
                [scrollInbox setContentOffset:CGPointMake(primera-translation.x, 0)];
            }else if([pages currentPage]==1){
                [first2 setFrame:CGRectMake(primera, 0, 320, 130)];
                [third2 setFrame:CGRectMake(tercera, 0, 320, 130)];
                [scrollInbox setContentOffset:CGPointMake(segunda-translation.x, 0)];
            }else{
                [first2 setFrame:CGRectMake(primera, 0, 320, 130)];
                [second2 setFrame:CGRectMake(segunda, 0, 320, 130)];
                [scrollInbox setContentOffset:CGPointMake(tercera-translation.x, 0)];
            }
            
         
		}
		else if (states == UIGestureRecognizerStateEnded || states == UIGestureRecognizerStateCancelled)
		{
			
            if(translation.x>100){
                if([pages currentPage]==1){
                    [self cambioDesliza:0];
                }else if([pages currentPage]==2){
                    [self cambioDesliza:1];
                    
                }else{
                    [self cambioDesliza:2];
                }
                
            }
            else if(translation.x<-100){
                if([pages currentPage]==0){
                    [self cambioDesliza:1];
                }else if([pages currentPage]==1){
                    [self cambioDesliza:2];
                }else{
                    [self cambioDesliza:0];
                }
                
            }else{
                if([pages currentPage]==0){
                    [scrollInbox setContentOffset:CGPointMake(primera, 0) animated:YES];
                }else if([pages currentPage]==1){
                    [scrollInbox setContentOffset:CGPointMake(segunda, 0) animated:YES];
                }else{
                    [scrollInbox setContentOffset:CGPointMake(tercera, 0) animated:YES];
                }
            }
            timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(countup) userInfo:nil repeats:YES];
		}
	
}
 
@end
