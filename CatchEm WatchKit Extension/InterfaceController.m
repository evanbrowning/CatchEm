//
//  InterfaceController.m
//  CatchEm WatchKit Extension
//
//  Created by Evan Browning on 5/9/16.
//  Copyright © 2016 Netflix. All rights reserved.
//

#import "InterfaceController.h"
#import <CoreMotion/CoreMotion.h>

@interface InterfaceController()
@end


@implementation InterfaceController

NSTimer *timer;
NSTimer *shakeTimer;
int remainingCounts;
int remainingCountsShake;

bool armed;


NSTimer *motionTimer;
CMMotionManager *motionManager;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    remainingCounts = 0;
    remainingCountsShake = 0;
    armed = false;
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)pressPokeball {
    NSLog(@"pressPokeball called");
    if (remainingCounts == 0 && !armed) {
        NSLog(@"pressPokeball arming");
        [self startDeviceMotion];
        [_pokeballButton setBackgroundImageNamed:@"PokeballGlow"];
        armed = true;
    }
}

-(void)throwPokeball {
    NSLog(@"throwPokeball called");
    if (remainingCounts == 0) {
        NSLog(@"throwPokeball success");
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                 target:self
                                               selector:@selector(countDown)
                                               userInfo:nil
                                                repeats:YES];
        
        shakeTimer = [NSTimer scheduledTimerWithTimeInterval:0.25
                                                      target:self
                                                    selector:@selector(shake)
                                                    userInfo:nil
                                                     repeats:YES];
        remainingCounts = 16;
        remainingCountsShake = 28;
        [self countDown]; // Call once immediately
    }
}

-(void)countDown {
    if (remainingCounts % 2 == 1) {
        [_pokeballButton setBackgroundImageNamed:@"Pokeball"];
    } else {
        [_pokeballButton setBackgroundImageNamed:@"PokeballGlow"];
        [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeStart];
    }
    if (--remainingCounts <= 0) {
        NSLog(@"countDown ended");
        [timer invalidate];
        remainingCounts = 0;
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
    if (--remainingCountsShake <= 0) {
        NSLog(@"shake ended");
        [shakeTimer invalidate];
        remainingCountsShake = 0;
        [self animateWithDuration:0.5 animations:^{
            [self.pokeballButton setHorizontalAlignment:WKInterfaceObjectHorizontalAlignmentCenter];
        }];
    }
}

- (void)startDeviceMotion {
    // Create a CMMotionManager
    motionManager = [[CMMotionManager alloc] init];
    
    motionTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(getValues:) userInfo:nil repeats:YES];
    
    motionManager.accelerometerUpdateInterval = 0.05;  // 20 Hz
    [motionManager startAccelerometerUpdates];
}

-(void) getValues:(NSTimer *) timer {
    CMAcceleration acceleration = motionManager.accelerometerData.acceleration;
    if(acceleration.x + acceleration.y + acceleration.z > 2) {
        [self throwPokeball];
        [self stopDeviceMotion];
    }
}


- (void)stopDeviceMotion {
    [motionManager stopDeviceMotionUpdates];
    [motionTimer invalidate];
    armed = false;
}

@end



