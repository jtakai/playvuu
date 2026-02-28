//
//  BubbleConfig.h
//  playvuu
//
//  Created by Guille Becker on 8/2/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//


#define BUBBLE_SPRITE 60  // Points of the sprite edge
#define BUBBLE_DIAMETER 65 // Initial diameter in points

#define PTM_RATIO (32.0f) // 1 meter == PTM_RATIO cocos points

// World physics parameters
#define GRID_SEP  (BUBBLE_DIAMETER*1.20f/PTM_RATIO) // Grid points distance in meters
#define GRID_STRENGTH 100.0f // Grid strength in m/s²
#define GRAV_X 0  // X axis gravity in m/s²
#define GRAV_Y (-10.0f) // Y axis gravity in m/s²

#define MOUSE_STRENGTH (500000.0f) // Drag strength in m/s², must be greater than GRID_STRENGTH

#define LINEAR_DAMPING 1.0f // Linear damping is used to reduce the linear velocity.
#define FRICTION 0.5 // The friction coefficient, usually in the range [0,1] between bubbles
#define RESTITUTION 0.1 // The restitution (elasticity) usually in the range [0,1], for collisions

#define MAX_RADIUS (BUBBLE_DIAMETER/PTM_RATIO) // Max in meters when eating bubbles

#define VEL_ITERATIONS 6  // Iterations on velocity changes higher for precision, lower for speed
#define POS_ITERATIONS 2  // Iterations on position changes higher for precision, lower for speed

#define GRAVITY_SCALE 1 // Scale of the gravity distortion (on moving the iphone) NOT IN USE

#define MERGE_DISTANCE 0.5 // Distance in diameters for bubble merge between centers (play around with it [0.1,0.9])
#define PENET_SIN (0.1f) // Sin of angle for bubble penetration

#define SPRITE_NAME @"bubbleblue.png"
