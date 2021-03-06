// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Flutter/Flutter.h>
@import Mapbox;

@interface MapboxJsonConversions : NSObject
+ (bool)toBool:(NSNumber*)data;
+ (int)toInt:(NSNumber*)data;
+ (double)toDouble:(NSNumber*)data;
+ (float)toFloat:(NSNumber*)data;
+ (CLLocationCoordinate2D)toLocation:(NSArray*)data;
+ (UIColor*)toColor:(NSNumber*)data;
@end
