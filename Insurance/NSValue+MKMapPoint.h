//
//  NSValue+MKMapPoint.h
//  
//
//  Created by Rahul Surti on 4/9/17.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface NSValue (MKMapPoint)

+ (NSValue *)valueWithMKMapPoint:(MKMapPoint)mapPoint;
- (MKMapPoint)MKMapPointValue;

@end
