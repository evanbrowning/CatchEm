//
//  InterfaceController.h
//  CatchEm WatchKit Extension
//
//  Created by Evan Browning on 5/9/16.
//  Copyright © 2016 Netflix. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
- (IBAction)pressPokeball;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *pokeballButton;
@end
