//
//  AngleContactFilter.h
//  Box2D
//
//  Created by Pablo Vasquez on 8/4/13.
//  Copyright (c) 2013 Brian Broom. All rights reserved.
//

#ifndef __Box2D__AngleContactFilter__
#define __Box2D__AngleContactFilter__

#include <iostream>
#include <Box2D.h>

extern b2Body *ext_body_dragged, *ext_body_pisado;

class AngleContactFilter : public b2ContactFilter
{
public:
	virtual bool ShouldCollide(b2Fixture* fixtureA, b2Fixture* fixtureB);
};

#endif /* defined(__Box2D__AngleContactFilter__) */

