//
//  NSValue+MKMapPoint.m
//  
//
//  Created by Rahul Surti on 4/9/17.
//
//

#import "NSValue+MKMapPoint.h"

@implementation NSValue (MKMapPoint)

+ (NSValue *)valueWithMKMapPoint:(MKMapPoint)mapPoint {
    return [NSValue value:&mapPoint withObjCType:@encode(MKMapPoint)];
}

- (MKMapPoint)MKMapPointValue {
    MKMapPoint mapPoint;
    [self getValue:&mapPoint];
    return mapPoint;
}

@end
