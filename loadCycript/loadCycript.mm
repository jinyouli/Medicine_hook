//
//  loadCycript.mm
//  loadCycript
//
//  Created by Li JinYou on 2018/2/24.
//  Copyright (c) 2018年 ___ORGANIZATIONNAME___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"
#include <notify.h> // not required; for examples only

// Objective-C runtime hooking using CaptainHook:
//   1. declare class using CHDeclareClass()
//   2. load class using CHLoadClass() or CHLoadLateClass() in CHConstructor
//   3. hook method using CHOptimizedMethod()
//   4. register hook using CHHook() in CHConstructor
//   5. (optionally) call old method using CHSuper()


#define CYCRIPT_PORT 8888

CHDeclareClass(AppDelegate);
CHDeclareClass(UIApplication);

CHDeclareClass(AmituofoViewController);
CHDeclareClass(DetailViewController);
CHDeclareClass(NSObject);
CHDeclareClass(DBMgr);

CHOptimizedMethod2(self, void, AppDelegate, application, UIApplication *, application, didFinishLaunchingWithOptions, NSDictionary *, options)
{
    CHSuper2(AppDelegate, application, application, didFinishLaunchingWithOptions, options);
    
    NSLog(@"## Start Cycript3 ##");
    CYListenServer(CYCRIPT_PORT);
}

CHOptimizedMethod0(self, void, AmituofoViewController, loadView)
{
    CHSuper0(AmituofoViewController, loadView);
}

CHOptimizedMethod0(self, void, AmituofoViewController, viewDidLoad)
{
    CHSuper0(AmituofoViewController, viewDidLoad);
}

CHOptimizedMethod0(self, void, DetailViewController, viewDidLoad)
{
    CHSuper0(DetailViewController, viewDidLoad);
}

CHOptimizedMethod0(self, int, DBMgr, IsProductFullVersionPurchased)
{
    return 1;
    CHSuper0(DBMgr, IsProductFullVersionPurchased);
}

__attribute__((constructor)) static void entry() {
    CHLoadLateClass(AppDelegate);
    CHHook2(AppDelegate, application, didFinishLaunchingWithOptions);
    
    CHLoadLateClass(AmituofoViewController);
    CHHook0(AmituofoViewController,loadView);
    CHHook0(AmituofoViewController,viewDidLoad);
    
    CHLoadLateClass(DetailViewController);
    CHHook0(DetailViewController,viewDidLoad);
    
    CHLoadLateClass(DBMgr);
    CHHook0(DBMgr,IsProductFullVersionPurchased);
}







