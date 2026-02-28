//
//  PVBubbleWorld.h
//  playvuu
//
//  Created by Guille Becker on 8/2/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#ifndef __playvuu__PVBubbleWorld__
#define __playvuu__PVBubbleWorld__

#include <cmath>
#include <Box2D/Box2D.h>
//#include <DestructionListener.h>

class PVBubbleWorld;

class DestructionListener : public b2DestructionListener
{
public:
	void SayGoodbye(b2Fixture* fixture) { B2_NOT_USED(fixture); }
	void SayGoodbye(b2Joint* joint);
    
	PVBubbleWorld* bubbleWorld;
};

const int32 k_maxContactPoints = 2048;

struct ContactPoint
{
	b2Fixture* fixtureA;
	b2Fixture* fixtureB;
	b2Vec2 normal;
	b2Vec2 position;
	b2PointState state;
};


class PVBubbleWorld: public b2ContactListener
{
public:
    
	b2ContactFilter *m_ContactFilterP;
	enum { e_count = 16	};
	enum AddMethod { E_NORMAL, E_GROW, E_PUSH };
    
    PVBubbleWorld(float32 maxX, float32 maxY);

    
	int32 Step(float32 timeStep);
    virtual int32 MouseDown(const b2Vec2& p, int body_idx);
	virtual int32 MouseUp(const b2Vec2& p);
	void MouseMove(const b2Vec2& p);
    int32 queryWorld(const b2Vec2&p);
    b2Body *newBubble(void *userData, float32 xPos, float32 yPos, float32 radius, AddMethod addMeth= E_NORMAL);
    void removeBubble(int i);
    
	b2Body* m_bodies[e_count];
    float32 m_bodyRadius[e_count];
    float32 m_bodyFinalRadius[e_count];
    int32 m_cnt;
    b2World* m_world;
    
protected:
    
	friend class DestructionListener;
	friend class BoundaryListener;
	friend class ContactListener;
    
	b2Body* m_groundBody;
    b2Body* m_gridBody[e_count];
	b2MouseJoint* m_gridJoint[e_count];
	b2AABB m_worldAABB;
	ContactPoint m_points[k_maxContactPoints];
	int32 m_pointCount;
	DestructionListener m_destructionListener;
	b2MouseJoint* m_mouseJoint;
	b2Vec2 m_mouseWorld;
	int32 m_stepCount;
    
	b2Profile m_maxProfile;
	b2Profile m_totalProfile;
    
    b2Body* m_bodyPisado;
    
    void createGridJoint(int32 idx);
    void newBox(float32 x1, float32 y1, float32 x2, float32 y2); // Stone rectangle walls
    
private:
    ~PVBubbleWorld(){
		m_world->SetContactFilter((b2ContactFilter *)NULL);
		delete m_ContactFilterP;
	}
};

#endif /* defined(__playvuu__PVBubbleWorld__) */
