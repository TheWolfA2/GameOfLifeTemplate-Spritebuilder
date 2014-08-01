//
//  Grid.m
//  GameOfLife
//
//  Created by Billy Wolfington on 7/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

static const int GRID_ROWS = 8, GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}


-(void)onEnter {
    [super onEnter];
    
    [self setupGrid];
    
    self.userInteractionEnabled = YES;
}

-(void)setupGrid {
    // determine sizing of cells based on current screen dimmensions
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0, y = 0;
    
    _gridArray = [NSMutableArray array];
    
    for (int i = 0; i < GRID_ROWS; i++) {
        _gridArray[i] = [NSMutableArray array];
        
        // new row, reset x position
        x = 0;
        for (int j = 0; j < GRID_COLUMNS; j++) {
            // initalize and set position of creature
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x,y);
            [self addChild:creature];
            
            // place creature in grid
            _gridArray[i][j] = creature;
            
            // update row position
            x += _cellWidth;
        }
        
        // update col position
        y += _cellHeight;
    }
}


-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // get the touch location
    CGPoint touchLocation = [touch locationInNode:self];
    
    // get the creature
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    // invert creature's state
    creature.isAlive = !creature.isAlive;
}


-(Creature*)creatureForTouchPosition:(CGPoint)touchPosition {
    int row = touchPosition.y / _cellHeight,
        column = touchPosition.x / _cellWidth;
    
    return _gridArray[row][column];
}



-(void)evolveStep {
    [self countNeighbors];
    
    [self updateCreatures];
    
    _generation++;
}



-(BOOL)isIndexValidForX:(int)x andY:(int)y {
    if (x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS) {
        return NO;
    }
    
    return YES;
}


-(void)countNeighbors {
    for (int i = 0; i < GRID_ROWS; i++) {
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *currentCreature = _gridArray[i][j];
            
            currentCreature.livingNeighbors = 0;
            
            for (int x = i - 1; x <= i + 1; x++) {
                for (int y = j - 1; y <= j + 1; y++) {
                    BOOL isValidIndex = [self isIndexValidForX:x andY:y];
                    
                    if (!(x == i && y == j) && isValidIndex) {
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive)
                        {
                            currentCreature.livingNeighbors++;
                        }
                    }
                }
            }
        }
    }
}


-(void)updateCreatures {
    for (int i = 0; i < GRID_ROWS; i++) {
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *currentCreature = _gridArray[i][j];
            
            if (currentCreature.livingNeighbors == 3) {
                currentCreature.isAlive = YES;
            } else {
                if (currentCreature.livingNeighbors <= 1 || currentCreature.livingNeighbors >= 4) {
                    currentCreature.isAlive = NO;
                }
            }
        }
    }
}


@end
