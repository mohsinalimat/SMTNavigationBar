//
//  SMTSharedNavigationBar.m
//  SMTNavigationBar
//
//  Created by Steffi Tan on 10/8/15.
//  Copyright © 2015 iamsteffi.com. All rights reserved.
//

#import "SMTSharedNavigationBar.h"

@implementation SMTSharedNavigationBar


-(instancetype)init{
    self = [super init];
    
    if(!self){
        return nil;
    }
    return self;
}

+(SMTSharedNavigationBar *)sharedNavigationBar{
    static SMTSharedNavigationBar * _sharedNavbar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNavbar = [[self alloc]init];
    });
    return _sharedNavbar;
}

#pragma mark - Adding Buttons
#pragma mark -
-(void)addToButtonList:(NSString *)key button:(UIButton *)btn{
    if(_buttonList == nil){
        _buttonList = [[NSMutableDictionary alloc]init];
    }
    [_buttonList setValue:btn forKey:key];
}

#pragma mark - Set DefaultButtons
#pragma mark -
-(UIButton *)defaultLeftButton{
    /**
     *  Context:Previously generated selectors on UniversalNavBar category still get referenced.
     *  Sol: Reset targets.
     */
    [_defaultLeftButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
    return _defaultLeftButton;
}
-(UIButton *)defaultRightButton{
    /**
     *  Context:Previously generated selectors on UniversalNavBar category still get referenced.
     *  Sol: Reset targets.
     */
    [_defaultRightButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
    return _defaultRightButton;
}
#pragma mark - Block Selectors
#pragma mark -
-(void)runLeftActionBlockSelector:(LeftAction_BlockSelector)block{
    if(self.leftActionBlock){
        self.leftActionBlock(_selfReference);
    }
}

-(void)runRightActionBlockSelector:(RightAction_BlockSelector)block{
    if(self.rightActionBlock){
        self.rightActionBlock(_selfReference);
    }
}

-(void)resetSMTNavigationBar{
    self.rightActionBlock = nil;
    self.leftActionBlock = nil;
    self.defaultRightButton = nil;
    self.defaultLeftButton = nil;
    self.defaultLeftPop = NO;
}


@end
