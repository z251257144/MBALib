//
//  ZMLocationManager.m
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import "ZMLocationManager.h"

@interface ZMLocationManager ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) LocationBlock locationBlock;
@property (nonatomic, strong) NSStringBlock cityBlock;
@property (nonatomic, strong) NSStringBlock addressBlock;
@property (nonatomic, strong) LocationErrorBlock errorBlock;

@end

@implementation ZMLocationManager

+ (ZMLocationManager *)shareLocation;
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) getLocationError:(LocationErrorBlock) errorBlock
{
    self.errorBlock = [errorBlock copy];
    [self startLocation];
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock
{
    self.locationBlock = [locaiontBlock copy];
    [self startLocation];
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock
{
    self.locationBlock = [locaiontBlock copy];
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void) getAddress:(NSStringBlock)addressBlock
{
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void) getCity:(NSStringBlock)cityBlock
{
    self.cityBlock = [cityBlock copy];
    [self startLocation];
}

- (void)startLocation
{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];//创建位置管理器
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 1000.0f;
    }
    //启动位置更新
    [self.locationManager startUpdatingLocation];
    
}

- (void)stopLocation
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    self.coordinate = newLocation.coordinate;
    
    if (self.locationBlock) {
        self.locationBlock(self.coordinate);
    }
    
    if (self.needAddress) {
        CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
        CLGeocodeCompletionHandler handle = ^(NSArray *placemarks, NSError *error)
        {
            for (CLPlacemark *placeMark in placemarks)
            {
                NSDictionary *addressDic = placeMark.addressDictionary;
                
                NSString *state         = [addressDic objectForKey:@"State"];
                NSString *city          = [addressDic objectForKey:@"City"];
                NSString *subLocality   = [addressDic objectForKey:@"SubLocality"];
                NSString *street        = [addressDic objectForKey:@"Street"];
                
                self.city = city;
                self.address = [NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,street];
            }
            
            if (self.cityBlock) {
                self.cityBlock(self.city);
            }
            
            if (self.addressBlock) {
                self.addressBlock(self.address);
            }
        };
        [clGeoCoder reverseGeocodeLocation:newLocation completionHandler:handle];
    }
    
    [self stopLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (self.errorBlock) {
        self.errorBlock(error);
    }
    [self stopLocation];
}

@end
