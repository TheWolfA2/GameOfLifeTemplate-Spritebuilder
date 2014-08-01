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
        
        x = 0;
        for (int j = 0; j < GRID_COLUMNS; j++) {
            // initalize and set position of creature
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x,y);
            [self addChild:creature];
            
            // place creature in grid
            _gridArray[i][j] = creature;
            
            //creature.isAlive = YES;
            [creature setIsAlive:YES];
            
            // update row position
            x += _cellWidth;
        }
        
        // update col position
        y += _cellHeight;
    }
}


@end
