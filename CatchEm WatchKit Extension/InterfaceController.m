//
//  InterfaceController.m
//  CatchEm WatchKit Extension
//
//  Created by Evan Browning on 5/9/16.
//  Copyright © 2016 Netflix. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)pressPokeball {
    NSLog(@"pressPokeball called");
    [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeNotification];
    [_pokeballButton setBackgroundImageNamed:@"PokeballGlow"];
}
@end



