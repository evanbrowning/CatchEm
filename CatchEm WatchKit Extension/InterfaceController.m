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

NSTimer *timer;
int remainingCounts;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    remainingCounts = 0;
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)pressPokeball {
    if (remainingCounts == 0) {
        NSLog(@"pressPokeball called");
        timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(countDown)
                                               userInfo:nil
                                                repeats:YES];
        remainingCounts = 7;
        [self countDown]; // Call once immediately
    }
}

-(void)countDown {
    if (remainingCounts % 2 == 0) {
        [_pokeballButton setBackgroundImageNamed:@"Pokeball"];
    } else {
        [_pokeballButton setBackgroundImageNamed:@"PokeballGlow"];
        [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeNotification];
    }
    if (--remainingCounts == 0) {
        [timer invalidate];
        [_pokeballButton setBackgroundImageNamed:@"Pokeball"];
    }
}

@end



