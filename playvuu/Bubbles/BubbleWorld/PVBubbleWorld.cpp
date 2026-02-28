//
//  PVBubbleWorld.cpp
//  playvuu
//
//  Created by Guille Becker on 8/2/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#include "PVBubbleWorld.h"
#include "BubbleConfig.h"
#include "AngleContactFilter.h"

void DestructionListener::SayGoodbye(b2Joint* joint)
{
	if (bubbleWorld->m_mouseJoint == joint)
	{
		bubbleWorld->m_mouseJoint = NULL;
	}
	else
	{
		//bubbleWorld->JointDestroyed(joint);
	}
}

float32 _maxX, _maxY;
b2Body *ext_body_dragged=NULL, *ext_body_pisado=NULL;
bool _updateGrid = false;

b2Vec2 near_grid_point(const b2Vec2& p){
	b2Vec2 np(floor(p.x/GRID_SEP+0.5), floor(p.y/GRID_SEP+0.5));
    np= b2Clamp(np, b2Vec2(1, 1), b2Vec2(floor(_maxX), floor(_maxY)));
	return b2Vec2(np.x*GRID_SEP, np.y*GRID_SEP);
}

void PVBubbleWorld::newBox(float32 x1, float32 y1, float32 x2, float32 y2) // Stone rectangle walls
{
    b2BodyDef bd;
    b2EdgeShape shape;

    b2Body* ground1 = m_world->CreateBody(&bd);
    b2Body* ground2 = m_world->CreateBody(&bd);
    b2Body* ground3 = m_world->CreateBody(&bd);
    b2Body* ground4 = m_world->CreateBody(&bd);

    shape.Set(b2Vec2(x1,y1), b2Vec2(x1,y2));
    ground1->CreateFixture(&shape, 0.0f);
    shape.Set(b2Vec2(x1,y1), b2Vec2(x2,y1));
    ground2->CreateFixture(&shape, 0.0f);
    shape.Set(b2Vec2(x1,y2), b2Vec2(x2,y2));
    ground3->CreateFixture(&shape, 0.0f);
    shape.Set(b2Vec2(x2,y1), b2Vec2(x2,y2));
    ground4->CreateFixture(&shape, 0.0f);
}

PVBubbleWorld::PVBubbleWorld(float32 maxX, float32 maxY)
{
    b2BodyDef bd;
    
    _maxX = maxX;
    _maxY = maxY;
    
    m_world = new b2World(b2Vec2(GRAV_X, GRAV_Y));
    m_groundBody = m_world->CreateBody(&bd);
    
    m_cnt = 0;
    
    newBox(0 ,0, maxX, maxY);
 
    m_ContactFilterP= new AngleContactFilter;
    m_world->SetContactFilter(m_ContactFilterP);
    m_world->SetContactListener(this);
    m_world->SetDestructionListener(&m_destructionListener);
    
    m_bodyPisado= NULL;
    
    bzero(m_gridBody, sizeof(m_gridBody));
    bzero(m_gridJoint, sizeof(m_gridJoint));
    bzero(m_bodies, sizeof(m_bodies));
}

void PVBubbleWorld::createGridJoint(int32 idx){
    b2MouseJointDef md;
    md.bodyA = m_gridBody[idx];
    md.bodyB = m_bodies[idx];
    md.target = m_bodies[idx]->GetWorldCenter();
    md.maxForce = GRID_STRENGTH * md.bodyB->GetMass();
    m_gridJoint[idx]= (b2MouseJoint*)m_world->CreateJoint(&md);
    m_gridJoint[idx]->SetTarget(near_grid_point(m_bodies[idx]->GetWorldCenter()));
}

b2Body * PVBubbleWorld::newBubble(void *userData, float32 xPos, float32 yPos, float32 radius, AddMethod addMeth)
{
    b2CircleShape shape;
    float32 initRadius= addMeth==E_GROW? radius/16 : radius;
    shape.m_radius = initRadius;
    
    b2FixtureDef fixt;
    fixt.shape= &shape;
    fixt.friction= FRICTION;
    fixt.density= 0.02;
    fixt.restitution= RESTITUTION;

    b2BodyDef bd;
    m_gridBody[m_cnt] = m_world->CreateBody(&bd);
    
    m_bodyRadius[m_cnt] = initRadius;
    m_bodyFinalRadius[m_cnt] = radius;

    bd.type = b2_dynamicBody;
    bd.position.Set(xPos, yPos);
    bd.linearDamping= LINEAR_DAMPING;
    bd.angularDamping= 4;
    bd.userData = userData?userData:(void *)m_cnt;
        
    m_bodies[m_cnt] = m_world->CreateBody(&bd);
    m_bodies[m_cnt]->CreateFixture(&fixt);
    
    createGridJoint(m_cnt);

    //m_bodies[m_cnt]->SetLinearVelocity(b2Vec2(3.0f, 0.0f));

    return m_bodies[m_cnt++];
}

int32 PVBubbleWorld::Step(float32 timeStep)
{
    int32 ret = -1, i;

    for (i = 0; i < m_cnt; ++i)
    	if(m_bodyRadius[i] != m_bodyFinalRadius[i])
    	{
            b2Fixture* fixp= m_bodies[i]->GetFixtureList();
            b2Shape* shape= NULL;
            if(fixp)
                shape= fixp->GetShape();

            if(fabs(m_bodyRadius[i]-m_bodyFinalRadius[i])<0.02f)
    			m_bodyRadius[i]= m_bodyFinalRadius[i];
    		else
    			m_bodyRadius[i]+= (m_bodyRadius[i]<m_bodyFinalRadius[i])? 0.02: -0.02;

            if(shape)
                shape->m_radius= m_bodyRadius[i];
    	}
    
    if(m_bodyPisado)
    {
        removeBubble((int32)m_bodyPisado->GetUserData());
        m_bodyPisado = NULL;
    }
    
    if(_updateGrid){
        for (i = 0; i < m_cnt; ++i)
           if(m_gridJoint[i] && m_bodies[i])
              m_gridJoint[i]->SetTarget(near_grid_point(m_bodies[i]->GetWorldCenter()));
        _updateGrid=false;
    }

    
	m_pointCount = 0;
    
	m_world->Step(timeStep, VEL_ITERATIONS, POS_ITERATIONS);
    
	if (timeStep > 0.0f)
	{
		++m_stepCount;
	}
    
    return ret;
}

void PVBubbleWorld::removeBubble(int i){
    if(m_gridJoint[i]){
        m_world->DestroyJoint(m_gridJoint[i]);
        m_gridJoint[i]= NULL;
    }
    
    if(m_bodies[i]){
        m_world->DestroyBody(m_bodies[i]);
        m_bodies[i]= NULL;
    }
}


class QueryCallback : public b2QueryCallback
{
public:
	QueryCallback(const b2Vec2& point)
	{
		m_point = point;
		m_fixture = NULL;
	}
    
	bool ReportFixture(b2Fixture* fixture)
	{
		b2Body* body = fixture->GetBody();
		if (body->GetType() == b2_dynamicBody)
		{
			bool inside = fixture->TestPoint(m_point);
			if (inside)
			{
				m_fixture = fixture;
                
				// We are done, terminate the query.
				return false;
			}
		}
        
		// Continue the query.
		return true;
	}
    
	b2Vec2 m_point;
	b2Fixture* m_fixture;
};

int32 PVBubbleWorld::queryWorld(const b2Vec2&p)
{
    int32 retVal = -1;
    b2AABB aabb;
    b2Vec2 d;
    
    d.Set(0.001f, 0.001f);
    aabb.lowerBound = p - d;
    aabb.upperBound = p + d;
    
    // Query the world for overlapping shapes.
    QueryCallback callback(p);
    m_world->QueryAABB(&callback, aabb);
    
    if(callback.m_fixture)
        retVal = (int32)(callback.m_fixture->GetBody()->GetUserData());
    
    return retVal;
}

int32 PVBubbleWorld::MouseDown(const b2Vec2& p, int body_idx)
{
    int32 retVal = -1;
	m_mouseWorld = p;
	
	if (m_mouseJoint == NULL){
        
        // Make a small box.
        b2AABB aabb;
        b2Vec2 d;
        d.Set(0.001f, 0.001f);
        aabb.lowerBound = p - d;
        aabb.upperBound = p + d;
        
        // Query the world for overlapping shapes.
        QueryCallback callback(p);
        m_world->QueryAABB(&callback, aabb);
        
        if (callback.m_fixture)
        {
            b2Body* body = callback.m_fixture->GetBody();//m_bodies[body_idx];//
            b2MouseJointDef md;
            md.bodyA = m_groundBody;
            md.bodyB = body;
            md.target = body->GetWorldCenter();
            md.maxForce = MOUSE_STRENGTH * body->GetMass();
            m_mouseJoint = (b2MouseJoint*)m_world->CreateJoint(&md);
            m_world->DestroyJoint(m_gridJoint[(int32)body->GetUserData()]);
            m_gridJoint[(int32)body->GetUserData()] = NULL;
            retVal = (int32)body->GetUserData();
            body->SetAwake(true);
            m_mouseJoint->SetTarget(p);
            ext_body_dragged= body;
        }
    }
    return retVal;
}

int32 PVBubbleWorld::MouseUp(const b2Vec2& p)
{
    int32 retVal = -1;
    if (m_mouseJoint)
	{
		float32 dis_prop=1; // Distancia proporcional, radios de separacion, 0 misma pos, 1 se tocan
        
		b2Body * draggedBody= m_mouseJoint->GetBodyB();
		if(ext_body_pisado)
		{
			b2Vec2 dist_v= draggedBody->GetWorldCenter();
			dist_v-= ext_body_pisado->GetWorldCenter();
            
            dis_prop= fabs(dist_v.Length()/(m_bodyRadius[(int32)draggedBody->GetUserData()]+m_bodyRadius[(int32)ext_body_pisado->GetUserData()]));
		}
        
		if(dis_prop<MERGE_DISTANCE && draggedBody)
		{
			int32 sbi= (int32)draggedBody->GetUserData();
			m_bodyFinalRadius[sbi]= fmin(m_bodyRadius[sbi]*2, MAX_RADIUS);
            m_bodyPisado = ext_body_pisado;
		}
		
    	ext_body_pisado= NULL;

        _updateGrid = true;
        
		m_world->DestroyJoint(m_mouseJoint);
		m_mouseJoint = NULL;
        if(ext_body_dragged)
        {
        	createGridJoint((int32)ext_body_dragged->GetUserData());
        	retVal = (int32)ext_body_dragged->GetUserData();
        }
	}
    
	ext_body_dragged= NULL;
    return retVal;
}

void PVBubbleWorld::MouseMove(const b2Vec2& p)
{
	m_mouseWorld = p;
	
	if (m_mouseJoint){
		m_mouseJoint->SetTarget(p);
        b2Body *body = m_mouseJoint->GetBodyB();
        if(body && ext_body_pisado)
		{
			b2Vec2 dist_v= ext_body_pisado->GetWorldCenter() - body->GetWorldCenter();
            
            if(fabs(dist_v.Length()/(m_bodyRadius[(int32)body->GetUserData()]+m_bodyRadius[(int32)ext_body_pisado->GetUserData()]))>0.5)
                ext_body_pisado = NULL;
        }
	}
}
