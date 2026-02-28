//
//  PVVideoSprite.m
//
//  Based on:
//
// =====================
//  JGCameraSprite.m
//  Created by Jake Gundersen on 9/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
// =====================
//
// Pablo Vasquez

#import "PVVideoSprite.h"
//#import <GPUImage/GPUImageMovie.h>
//#import <GPUImage/GPUImageSphereRefractionFilter.h>
//#import <GPUImage/GPUImageCropFilter.h>
#import <cocos2d/CCGLProgram.h>
#import "PVSlideAtlasHelper.h"
#define kPVBubbleProgram @"bubbleProgram"
#define kPVBubbleMask @"bubblemask2.png"


@interface PVVideoSprite() {
    BOOL isActive;
    GPUImageMovie* movie;
    GPUImageTextureOutput *output;
    GLuint _textureLocation;
    GLuint _maskLocation;
    UIImage *slideAtlas;
    CCTexture2D *_bubbleMask;    
    }
@end

@implementation PVVideoSprite

CCTexture2D *_imgTexture;
CCTexture2D *_videoTexture;
CCTexture2D * _slideTexture;

-(id) initWithRect:(CGRect) rect{
    CCRenderTexture *rt = [[CCRenderTexture alloc] initWithWidth:rect.size.width height:rect.size.height pixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    self = [super initWithTexture:rt.sprite.texture rect:rect];
    
    if(self) {
        //
        // Setup for GL shader masking.
        //
        
        self.shaderProgram = [[CCShaderCache sharedShaderCache] programForKey:kPVBubbleProgram];
        _bubbleMask = [[CCTextureCache sharedTextureCache] textureForKey:kPVBubbleMask];
        
        _maskLocation = glGetUniformLocation(self.shaderProgram->program_, "u_mask");
        glUniform1i(_maskLocation, 1);
        
        [self.shaderProgram use];
        ccGLBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glActiveTexture(GL_TEXTURE1);
        glBindTexture(GL_TEXTURE_2D, [_bubbleMask name]);
        glActiveTexture(GL_TEXTURE0);
        
        isActive = NO;
        
        //
        // Setup for GPUImageMovie video playing.
        //
        
        // Texture output for the sprite.
        //output = [[GPUImageTextureOutput alloc] init];
        //output.delegate = self;
        //[movie addTarget:output];
        
        //[movie startProcessing];
        _imgTexture = [[CCTextureCache sharedTextureCache] addImage: @"girl.png"];
    }
    
    return self;
}


-(void)setSlideShow:(UIImage *)slideShow alias:(NSString *)alias{
    slideAtlas = slideShow;
    _slideTexture = [[CCTexture2D alloc] initWithCGImage:slideAtlas.CGImage resolutionType:kCCResolutioniPhone5RetinaDisplay];
    
    NSDictionary *slideShowProps = [PVSlideAtlasHelper frameDictWithAlias:alias];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithDictionary:slideShowProps texture:_slideTexture];
}


-(void)setMovieAtUrl:(NSURL*)movieUrl{
    
    if(movie){
        [movie removeAllTargets];
        [movie endProcessing];
    }
    
    // Little hack so that I don't spend all night coding :P
    if(!movieUrl){
        NSString* fileStr = [[NSBundle mainBundle] pathForResource:@"girl" ofType:@"mp4"];
        movieUrl = [NSURL fileURLWithPath:fileStr];
    }
    
    // Movie output
    //movie = [[GPUImageMovie alloc] initWithURL:movieUrl];
    //[movie setPlayAtActualSpeed:YES];
    
    //[movie addTarget:output];
    //[movie startProcessing];

}

-(void) draw
{
    // Set the still image as texture if we're not playing.
    if(!isActive)
        self.texture.name = _imgTexture.name;
    
    ccGLEnable(self.glServerState);
    NSAssert1(self.shaderProgram, @"No shader program set for node: %@", self);
    [self.shaderProgram use];
    
    ccGLEnableVertexAttribs(kCCVertexAttribFlag_PosColorTex);
    ccGLBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    [self.shaderProgram setUniformForModelViewProjectionMatrix];
    
    glActiveTexture(GL_TEXTURE0);
    glBindTexture( GL_TEXTURE_2D, [self.texture name] );
    glUniform1i(_textureLocation, 0);
    
    glActiveTexture(GL_TEXTURE1);
    glBindTexture( GL_TEXTURE_2D, [_bubbleMask name] );
    glUniform1i(_maskLocation, 1);
    
#define kQuadSize sizeof(quad_.bl)
    ccV3F_C4B_T2F_Quad q = quad_;
    long offset = (long)&q;
    
    NSInteger diff = offsetof( ccV3F_C4B_T2F, vertices);
    glVertexAttribPointer(kCCVertexAttrib_Position, 3, GL_FLOAT, GL_FALSE, kQuadSize, (void*) (offset + diff));
    
    diff = offsetof( ccV3F_C4B_T2F, texCoords);
    glVertexAttribPointer(kCCVertexAttrib_TexCoords, 2, GL_FLOAT, GL_FALSE, kQuadSize, (void*)(offset + diff));
    
    diff = offsetof( ccV3F_C4B_T2F, colors);
    glVertexAttribPointer(kCCVertexAttrib_Color, 4, GL_UNSIGNED_BYTE, GL_TRUE, kQuadSize, (void*)(offset + diff));
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glActiveTexture(GL_TEXTURE0);
}

-(void)toggleVideo {
    if(isActive)
       [self stopVideo];
    else
        [self resumeVideo];
}

-(void)stopVideo {
    if (isActive) {
        [movie removeAllTargets];
        [movie endProcessing];
        isActive = NO;
    }
}

-(void)resumeVideo {
    if (!isActive) {
        [movie addTarget:output];
        [movie startProcessing];
        isActive = YES;
    }
}

- (void)newFrameReadyFromTextureOutput:(GPUImageTextureOutput *)callbackTextureOutput;
{
    if(isActive)
        self.texture.name = callbackTextureOutput.texture;
}


+(void)initialize{
    
    CCGLProgram *glProgram;
    NSURL* fileUrl;
    GLchar const *fragShaderString;
    
    NSString *fileStr = [[NSBundle mainBundle] pathForResource:@"bubblemask" ofType:@"frag"];
    fileUrl = [NSURL fileURLWithPath:fileStr];
    fragShaderString = (GLchar *)[[NSString stringWithContentsOfURL:fileUrl encoding:NSUTF8StringEncoding error:nil] UTF8String];
    
    glProgram = [[CCGLProgram alloc] initWithVertexShaderByteArray:ccPositionTextureA8Color_vert fragmentShaderByteArray:fragShaderString];
    
    [glProgram addAttribute:kCCAttributeNamePosition index:kCCVertexAttrib_Position];
    [glProgram addAttribute:kCCAttributeNameTexCoord index:kCCVertexAttrib_TexCoords];
    [glProgram addAttribute:kCCAttributeNameColor index:kCCVertexAttrib_Color];
    [glProgram link];
    [glProgram updateUniforms];
    [[CCShaderCache sharedShaderCache] addProgram:glProgram forKey:kPVBubbleProgram];
    [[CCTextureCache sharedTextureCache] addImage:kPVBubbleMask];
}

@end
