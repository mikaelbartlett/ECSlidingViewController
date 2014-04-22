// METransitions.h
// TransitionFun
//
// Copyright (c) 2013, Michael Enriquez (http://enriquez.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "ECSlidingViewController.h"
#import "MEFoldAnimationController.h"
#import "MEZoomAnimationController.h"
#import "MEDynamicTransition.h"
#import "MEAboveAnimationController.h"

FOUNDATION_EXPORT NSString *const METransitionNameDefault;
FOUNDATION_EXPORT NSString *const METransitionNameFold;
FOUNDATION_EXPORT NSString *const METransitionNameZoom;
FOUNDATION_EXPORT NSString *const METransitionNameDynamic;
FOUNDATION_EXPORT NSString *const METransitionNameAbove;

@interface METransitions : NSObject {
    NSArray *_all;
}
@property (nonatomic, strong) MEFoldAnimationController *foldAnimationController;
@property (nonatomic, strong) MEZoomAnimationController *zoomAnimationController;
@property (nonatomic, strong) MEDynamicTransition *dynamicTransition;
@property (nonatomic, strong) MEAboveAnimationController *aboveTransition;
@property (nonatomic, strong, readonly) NSArray *all;
@end
