//
//  ZMLocationManager.h
//  MBALib
//
//  Created by zmsoul on 2014-5-6.
//  Copyright (c) 2014年 MBALib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#define kZMLocationManager  [ZMLocationManager shareLocation]

typedef void (^LocationBlock) (CLLocationCoordinate2D locationCorrrdinate);
typedef void (^LocationErrorBlock) (NSError *error);
typedef void (^NSStringBlock) (NSString *cityString);
typedef void (^NSStringBlock) (NSString *addressString);


@interface ZMLocationManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, assign) BOOL      needAddress;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *address;

+ (ZMLocationManager *)shareLocation;

/**
 *  定位失败
 *
 *  @param locationErrorBlock description
 */
- (void) getLocationError:(LocationErrorBlock) errorBlock ;

/**
 *  获取坐标
 *
 *  @param locaiontBlock locaiontBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock ;

/**
 *  获取坐标和地址
 *
 *  @param locaiontBlock locaiontBlock description
 *  @param addressBlock  addressBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock;

/**
 *  获取地址
 *
 *  @param addressBlock addressBlock description
 */
- (void) getAddress:(NSStringBlock)addressBlock;

/**
 *  获取城市
 *
 *  @param cityBlock cityBlock description
 */
- (void) getCity:(NSStringBlock)cityBlock;

@end
