//
//  Creature.m
//  GameOfLife
//
//  Created by Billy Wolfington on 7/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

-(instancetype)initCreature {
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self) {
        self.isAlive = NO;
    }
    
    return self;
}

-(void)setIsAlive:(BOOL)newState {
    // @property creates instance variables
    _isAlive = newState;
    
    self.visible = _isAlive;
}

@end
