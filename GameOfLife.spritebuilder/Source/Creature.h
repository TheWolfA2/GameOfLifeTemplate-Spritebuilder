//
//  Creature.h
//  GameOfLife
//
//  Created by Billy Wolfington on 7/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

// represents weather creature is alive or not
@property (nonatomic, assign) BOOL isAlive;

// number of neighbors that are alive
@property (nonatomic, assign) NSInteger livingNeighbors;

-(id)initCreature;

@end
