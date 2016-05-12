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
NSTimer *shakeTimer;
int remainingCounts;
int remainingCountsShake;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    remainingCounts = 0;
    remainingCountsShake = 0;
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
        
        shakeTimer = [NSTimer scheduledTimerWithTimeInterval:0.25
                                                 target:self
                                               selector:@selector(shake)
                                               userInfo:nil
                                                repeats:YES];
        remainingCounts = 8;
        remainingCountsShake = 28;
        [self countDown]; // Call once immediately
    }
}

-(void)countDown {
    if (remainingCounts % 2 == 1) {
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

-(void) shake {
    if (remainingCountsShake % 4 == 0) {
        [self animateWithDuration:0.25 animations:^{
            [self.pokeballButton setHorizontalAlignment:WKInterfaceObjectHorizontalAlignmentLeft];
        }];
    } else if ((remainingCountsShake + 1) % 4 == 0){
        [self animateWithDuration:0.25 animations:^{
            [self.pokeballButton setHorizontalAlignment:WKInterfaceObjectHorizontalAlignmentRight];
        }];
    } else if ((remainingCountsShake + 2) % 4 == 0){
        [self animateWithDuration:0.25 animations:^{
            [self.pokeballButton setHorizontalAlignment:WKInterfaceObjectHorizontalAlignmentCenter];
        }];
    }
    if (--remainingCountsShake == 0) {
        [shakeTimer invalidate];
        
        [self animateWithDuration:0.5 animations:^{
            [self.pokeballButton setHorizontalAlignment:WKInterfaceObjectHorizontalAlignmentCenter];
        }];
    }
}

@end



