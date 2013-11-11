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


@interface ViewController ()
{
    UIView *vistaScroll;
    
    UIView *first2;
    UILabel *date;
    UILabel *time;
    
    UIView *second2;
    UIImageView *state;
    NSString *icon;
    UILabel *temperature;
    UILabel *resume;
    
    Weather *weather;
    UIView *third2;
     UIImageView *iconDay1;
     UIImageView *iconDay2;
     UIImageView *iconDay3;
     UIImageView *iconDay4;
     UIImageView *iconDay5;
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
    UIImageView *first;
    UIImageView *second;
    UIImageView *third;
    int primera;
    int segunda;
    int tercera;
    int actual;
    NSTimer *timer;
    int bandera;
    int contador;
    int ancho;
    int vuelta;
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
    
    
    // Lo mostramos en las etiquetas
    //latitude.text = [NSString stringWithFormat:@"%0.8f",latitud];
    //longitude.text = [NSString stringWithFormat:@"%0.8f",longitud];
    
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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"https://api.forecast.io/forecast/%@/%.6f,%.6f", @"0b32c5e989fe10a2060dca536b5f76cc", latitud, longitud] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@", responseObject);
        icon=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:0] objectForKey:@"icon"];
        [self chooseIcon:icon imagen:state];
        
        weather.icono1=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:1] objectForKey:@"icon"];
        weather.icono2=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:2] objectForKey:@"icon"];
        weather.icono3=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:3] objectForKey:@"icon"];
        weather.icono4=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:4] objectForKey:@"icon"];
        weather.icono5=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:5] objectForKey:@"icon"];
        
        weather.max1=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:1] objectForKey:@"apparentTemperatureMax"];
        weather.max2=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:2] objectForKey:@"apparentTemperatureMax"];
        weather.max3=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:3] objectForKey:@"apparentTemperatureMax"];
        weather.max4=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:4] objectForKey:@"apparentTemperatureMax"];
        weather.max5=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:5] objectForKey:@"apparentTemperatureMax"];
        
        weather.min1=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:1] objectForKey:@"apparentTemperatureMin"];
        weather.min2=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:2] objectForKey:@"apparentTemperatureMin"];
        weather.min3=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:3] objectForKey:@"apparentTemperatureMin"];
        weather.min4=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:4] objectForKey:@"apparentTemperatureMin"];
        weather.min5=[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:5] objectForKey:@"apparentTemperatureMin"];
        [self chooseIcon:weather.icono1 imagen:iconDay1];
        [self chooseIcon:weather.icono2 imagen:iconDay2];
        [self chooseIcon:weather.icono3 imagen:iconDay3];
        [self chooseIcon:weather.icono4 imagen:iconDay4];
        [self chooseIcon:weather.icono5 imagen:iconDay5];
        infoMin1.text=[[NSString alloc] initWithFormat:@"L: %@º",weather.min1];
        infoMin2.text=[[NSString alloc] initWithFormat:@"L: %@º",weather.min2];
        infoMin3.text=[[NSString alloc] initWithFormat:@"L: %@º",weather.min3];
        infoMin4.text=[[NSString alloc] initWithFormat:@"L: %@º",weather.min4];
        infoMin5.text=[[NSString alloc] initWithFormat:@"L: %@º",weather.min5];
        infoMax1.text=[[NSString alloc] initWithFormat:@"H: %@º",weather.max1];
        infoMax2.text=[[NSString alloc] initWithFormat:@"H: %@º",weather.max2];
        infoMax3.text=[[NSString alloc] initWithFormat:@"H: %@º",weather.max3];
        infoMax4.text=[[NSString alloc] initWithFormat:@"H: %@º",weather.max4];
        infoMax5.text=[[NSString alloc] initWithFormat:@"H: %@º",weather.max5];
        
        
        
        //NSLog(@"%@",weather.icono4);
        temperature.text=[[NSString alloc] initWithFormat:@"%@",[[responseObject objectForKey:@"currently"] objectForKey:@"apparentTemperature"]];
        resume.text=[[NSString alloc] initWithFormat:@"%@",[[[[responseObject objectForKey:@"daily"] objectForKey:@"data"] objectAtIndex:0] objectForKey:@"summary"]];
        //alerta=[[NSString alloc] initWithFormat:@"%@",[[[responseObject objectForKey:@"alerts"] objectAtIndex:0] objectForKey:@"title"]];
       // NSLog(@"%@",temp);
        //NSLog(@"%@",icono);
        
        //UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"ALERT!!" message:alerta delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        //[mes show];
        
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

- (void) setup2{
    primera=0;
    segunda=320;
    tercera=640;
    
    first2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];
    //DATES AND TIME
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy"];
    NSDate *now = [[NSDate alloc] init];
    NSString *fecha = [format stringFromDate:now];
    [format setDateFormat:@"HH:mm:ss a"];
    NSString *tiempo = [format stringFromDate:now];
    
    date=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 280, 38)];
    [date setTextAlignment:NSTextAlignmentCenter];
    date.text=fecha;
    date.textColor=[UIColor whiteColor];
    
    time=[[UILabel alloc]initWithFrame:CGRectMake(20, 60, 280, 38)];
    [time setTextAlignment:NSTextAlignmentCenter];
    time.text=tiempo;
    time.textColor=[UIColor whiteColor];
    time.font = [UIFont systemFontOfSize:30];
    
    [first2 addSubview:date];
    [first2 addSubview:time];
    first2.backgroundColor=[UIColor grayColor];
    
    second2 = [[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, 130)];
    temperature=[[UILabel alloc]initWithFrame:CGRectMake(179, 11, 95, 75)];
    [temperature setTextAlignment:NSTextAlignmentCenter];
    temperature.textColor=[UIColor whiteColor];
    
    resume=[[UILabel alloc]initWithFrame:CGRectMake(152, 89, 148, 21)];
    [resume setTextAlignment:NSTextAlignmentCenter];
    resume.textColor=[UIColor whiteColor];
    resume.adjustsFontSizeToFitWidth = YES;
    
    state=[[UIImageView alloc] init];
    [state setFrame:CGRectMake(20, 11, 124, 99)];
    [second2 addSubview:temperature];
    [second2 addSubview:resume];
    [second2 addSubview:state];
    second2.backgroundColor=[UIColor grayColor];
    
    third2 = [[UIView alloc] initWithFrame:CGRectMake(640, 0, 320, 130)];
    weather=[[Weather alloc] init];
    third2.backgroundColor=[UIColor grayColor];
    iconDay1=[[UIImageView alloc] init];
    iconDay2=[[UIImageView alloc] init];
    iconDay3=[[UIImageView alloc] init];
    iconDay4=[[UIImageView alloc] init];
    iconDay5=[[UIImageView alloc] init];
    [iconDay1 setFrame:CGRectMake(9, 31, 38, 44)];
    [iconDay2 setFrame:CGRectMake(72, 31, 38, 44)];
    [iconDay3 setFrame:CGRectMake(136, 31, 38, 44)];
    [iconDay4 setFrame:CGRectMake(200, 31, 38, 44)];
    [iconDay5 setFrame:CGRectMake(262, 31, 38, 44)];
    
    infoMax1=[[UILabel alloc]initWithFrame:CGRectMake(12, 83, 42, 21)];
    infoMax2=[[UILabel alloc]initWithFrame:CGRectMake(75, 83, 42, 21)];
    infoMax3=[[UILabel alloc]initWithFrame:CGRectMake(139, 83, 42, 21)];
    infoMax4=[[UILabel alloc]initWithFrame:CGRectMake(209, 83, 42, 21)];
    infoMax5=[[UILabel alloc]initWithFrame:CGRectMake(265, 83, 42, 21)];
    infoMin1=[[UILabel alloc]initWithFrame:CGRectMake(12, 102, 42, 21)];
    infoMin2=[[UILabel alloc]initWithFrame:CGRectMake(75, 102, 42, 21)];
    infoMin3=[[UILabel alloc]initWithFrame:CGRectMake(139, 102, 42, 21)];
    infoMin4=[[UILabel alloc]initWithFrame:CGRectMake(209, 102, 42, 21)];
    infoMin5=[[UILabel alloc]initWithFrame:CGRectMake(265, 102, 42, 21)];
    
    infoMax1.font = [UIFont systemFontOfSize:10];
    infoMax1.adjustsFontSizeToFitWidth = YES;
    infoMax1.textColor=[UIColor whiteColor];
    infoMax2.font = [UIFont systemFontOfSize:10];
    infoMax2.adjustsFontSizeToFitWidth = YES;
    infoMax2.textColor=[UIColor whiteColor];
    infoMax3.font = [UIFont systemFontOfSize:10];
    infoMax3.adjustsFontSizeToFitWidth = YES;
    infoMax3.textColor=[UIColor whiteColor];
    infoMax4.font = [UIFont systemFontOfSize:10];
    infoMax4.adjustsFontSizeToFitWidth = YES;
    infoMax4.textColor=[UIColor whiteColor];
    infoMax5.font = [UIFont systemFontOfSize:10];
    infoMax5.adjustsFontSizeToFitWidth = YES;
    infoMax5.textColor=[UIColor whiteColor];
    infoMin1.font = [UIFont systemFontOfSize:10];
    infoMin1.adjustsFontSizeToFitWidth = YES;
    infoMin1.textColor=[UIColor whiteColor];
    infoMin2.font = [UIFont systemFontOfSize:10];
    infoMin2.adjustsFontSizeToFitWidth = YES;
    infoMin2.textColor=[UIColor whiteColor];
    infoMin3.font = [UIFont systemFontOfSize:10];
    infoMin3.adjustsFontSizeToFitWidth = YES;
    infoMin3.textColor=[UIColor whiteColor];
    infoMin4.font = [UIFont systemFontOfSize:10];
    infoMin4.adjustsFontSizeToFitWidth = YES;
    infoMin4.textColor=[UIColor whiteColor];
    infoMin5.font = [UIFont systemFontOfSize:10];
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
    
    vistaScroll=[[UIView alloc]initWithFrame:CGRectMake(0, 20, 960, 170)];
    
    self.scrollInbox = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, 960, 130)];
    [self.scrollInbox setBackgroundColor:[UIColor whiteColor]];
    
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
    pages.backgroundColor = [UIColor grayColor];
    pages.tintColor=[UIColor blackColor];
    [pages setBackgroundColor:[UIColor grayColor]];
    
    [pages addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:vistaScroll];
    
    ancho=0;
    contador=0;
    bandera=0;
    vuelta=0;
    //timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(countup) userInfo:nil repeats:YES];
}
- (void) setup{
    //dedo=[[UIPanGestureRecognizer alloc]init];
    
    //[vistaScroll addGestureRecognizer:dedo];
    //[dedo addTarget:self action:@selector(handlePanGestureRecognizer:)];
    //[pages addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    scrollInbox.decelerationRate = UIScrollViewDecelerationRateFast;
    
    ancho=0;
    contador=0;
    bandera=0;
    vuelta=0;
    timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(countup) userInfo:nil repeats:YES];
    
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
        
    }
}
- (void)countup{
    if(ancho==0){
        pages.currentPage=1;
        bandera=2;
        [self cambioImagen:bandera];
        
    }
    if(ancho==320){
        pages.currentPage=2;
        bandera=3;
        [self cambioImagen:bandera];
    }
    if(ancho==640){
        pages.currentPage=0;
        bandera=1;
        [self cambioImagen:bandera];
        
    }
    if(ancho<640){
        ancho+=320;
    }else{
        ancho=0;
    }
    
}
- (void)cambioImagen2:(int)cont{
    //CGFloat medidas=scrollInbox.contentSize.width;
    if(cont==1){
        if(vuelta==1){
            
        }
        [scrollInbox setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
}

- (void)cambioImagen:(int)cont{
    CGFloat medidas=scrollInbox.contentSize.width;
     if(cont==1){
        if(vuelta==1){
            
            [second setFrame:CGRectMake(first.frame.origin.x+320, 0, 320, 130)];
            [scrollInbox setContentOffset:CGPointMake(medidas-960, 0) animated:YES];
            segunda=(int)first.frame.origin.x+320;
        }else{
            [scrollInbox setContentOffset:CGPointMake(0, 0) animated:YES];
            
        }
        
    }else if(cont==2){
        if(vuelta==1){
            [third setFrame:CGRectMake(second.frame.origin.x+320, 0, 320, 130)];
            [scrollInbox setContentOffset:CGPointMake(medidas-640, 0) animated:YES];
            tercera=(int)second.frame.origin.x+320;
        }else{
            [third setFrame:CGRectMake(640, 0, 320, 130)];
            [scrollInbox setContentOffset:CGPointMake(320, 0) animated:YES];
        }
        
    }else{
        if(vuelta==1){
            [scrollInbox setContentOffset:CGPointMake(medidas-320, 0) animated:YES];
        }else{
            
            [scrollInbox setContentOffset:CGPointMake(640, 0) animated:YES];
        }
        
    }
    if(cont<3){
        cont++;
    }else{
        cont=1;
        vuelta=1;
        
        [scrollInbox setContentSize:CGSizeMake(medidas+960, 130)];
        
        [first setFrame:CGRectMake(third.frame.origin.x+320, 0, 320, 130)];
        primera=(int)third.frame.origin.x+320;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changePage:(id)sender {
    //NSLog(@"%@", sender);
    if((int)[pages currentPage]==0){
        [scrollInbox setContentOffset:CGPointMake(primera, 0) animated:YES];
    }else if((int)[pages currentPage]==1){
        [scrollInbox setContentOffset:CGPointMake(segunda, 0) animated:YES];
    }else{
        [scrollInbox setContentOffset:CGPointMake(tercera, 0) animated:YES];
    }
}
/*- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gesture
{
		UIGestureRecognizerState state = [gesture state];
		CGPoint translation = [gesture translationInView:scrollInbox];
		//CGPoint velocity = [gesture velocityInView:scrollInbox];
        //actual=bandera;
		//NSLog(@"BEGAN");
		
		if (state == UIGestureRecognizerStateBegan)
		{
			NSLog(@"BEGAN");
            //[time invalidate];
		}
		else if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
		{
            
            NSLog(@"%f", translation.x);
            if(translation.x<0){
                if(actual==1){
                    [scrollInbox setContentOffset:CGPointMake(primera-translation.x, 0)];
                }if(actual==2){
                    [scrollInbox setContentOffset:CGPointMake(segunda-translation.x, 0)];
                }if (actual==3){
                    [scrollInbox setContentOffset:CGPointMake(tercera-translation.x, 0)];
                }
            }else{
                if(actual==1){
                    [scrollInbox setContentOffset:CGPointMake(primera-translation.x, 0)];
                }if(actual==2){
                    [scrollInbox setContentOffset:CGPointMake(segunda-translation.x, 0)];
                }if (actual==3){
                    [scrollInbox setContentOffset:CGPointMake(tercera-translation.x, 0)];
                }
            }*/
            
			/*CGPoint center = {self.contentView.center.x + translation.x, self.contentView.center.y};
			[self.contentView setCenter:center];
			[self animateWithOffset:CGRectGetMinX(self.contentView.frame)];
			[gesture setTranslation:CGPointZero inView:self];*/
		//}
		/*else if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled)
		{
            NSLog(@"FINAL O CANCEL");
			
            if(translation.x>100){
                if(actual==1){
                    //[self cambioImagen:3];
                    [scrollInbox setContentOffset:CGPointMake(tercera, 0) animated:YES];
                    pages.currentPage=2;
                }else if(actual==2){
                    //[self cambioImagen:1];
                    [scrollInbox setContentOffset:CGPointMake(primera, 0) animated:YES];
                    pages.currentPage=0;
                    
                }else{
                    [scrollInbox setContentOffset:CGPointMake(segunda, 0) animated:YES];
                    pages.currentPage=1;
                    
                }
                actual++;
                if(actual>3){
                    actual=1;
                }
                NSLog(@"%i",actual);
                
            }
            if(translation.x<-100){
                if(actual==1){
                    [scrollInbox setContentOffset:CGPointMake(segunda, 0) animated:YES];
                    pages.currentPage=1;
                }else if(actual==2){
                    [scrollInbox setContentOffset:CGPointMake(tercera, 0) animated:YES];
                    pages.currentPage=2;
                }else{
                    [scrollInbox setContentOffset:CGPointMake(primera, 0) animated:YES];
                    pages.currentPage=0;
                }
                NSLog(@"%i",bandera);
                actual++;
                if(actual<1){
                    actual=3;
                }
                
            }*/
            //time=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(countup) userInfo:nil repeats:YES];
		/*}
	
}*/

/*#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
        UIScrollView *superview = (UIScrollView *) self;
        CGPoint translation = [(UIPanGestureRecognizer *) gestureRecognizer translationInView:superview];
        
        // Make sure it is scrolling horizontally
        return ((fabs(translation.x) / fabs(translation.y) > 1) ? YES : NO && (superview.contentOffset.y == 0.0 && superview.contentOffset.x == 0.0));
    
}
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
	CGFloat pageWidth = scrollInbox.bounds.size.width ;
    float fractionalPage = scrollInbox.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
	if (pages.currentPage != nearestNumber)
	{
		pages.currentPage = nearestNumber ;
		
		// if we are dragging, we want to update the page control directly during the drag
		if (scrollInbox.dragging)
			[pages updateCurrentPageDisplay] ;
	}
}*/

 
@end
