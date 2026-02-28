//
//  AngleContactFilter.cpp
//  Box2D
//
//  Created by Guille Becker on 8/4/13.
//  Copyright (c) 2013 Brian Broom. All rights reserved.
//

#include "AngleContactFilter.h"
#include "BubbleConfig.h"

bool AngleContactFilter::ShouldCollide(b2Fixture* fixtureA, b2Fixture* fixtureB){
    bool collide = b2ContactFilter::ShouldCollide(fixtureA, fixtureB);
    float32 dis_prop; // Distancia proporcional, radios de separacion, 0 misma pos, 1 se tocan
    
    if(collide){
        b2Body *bodyA= fixtureA->GetBody();
        b2Body *bodyB= fixtureB->GetBody();
        if(ext_body_dragged==bodyA || ext_body_dragged==bodyB)
        {
            b2Vec2 coll_v= bodyA->GetLinearVelocity();
            coll_v-= bodyB->GetLinearVelocity();
            b2Vec2 pos_v= bodyA->GetWorldCenter();
            pos_v-= bodyB->GetWorldCenter();
            dis_prop= fabs(pos_v.Length()/(fixtureA->GetShape()->m_radius+fixtureB->GetShape()->m_radius));
            
            if(dis_prop<0.8) {
                collide= false;
                if(dis_prop<(MERGE_DISTANCE-0.1))
                    ext_body_pisado= ext_body_dragged==bodyA? bodyB: bodyA; // con ext^a^b no queda claro
            }
            else {
                coll_v.Normalize();
                pos_v.Normalize();
                float32 coseno= coll_v.x*pos_v.x+coll_v.y*pos_v.y;
                if(fabs(coseno)>(1-PENET_SIN))
                    collide= false;
            }
        }
    }
    
    return collide;
    
}
