@implementation VideoSpriteBatchNode
@synthesize asset;
@synthesize videoTrack;
@synthesize assetReader;
@synthesize trackOutput;

+ (id)batchNodeWithVideo:(NSString *)name
{
  VideoSpriteBatchNode *sprite = [[VideoSpriteBatchNode alloc] initWithVideo:name];
  return sprite;
}

- (id)initWithVideo:(NSString *)name
{
  NSURL *fileURL = [[NSBundle mainBundle] URLForResource:name withExtension:nil];
  self.asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
  self.videoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];

  [self rewindAssetReader];

  CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer([self.trackOutput copyNextSampleBuffer]);
  CVPixelBufferLockBaseAddress(imageBuffer,0); 
  /*Get information about the image*/
  uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer); 
  size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
  size_t width = CVPixelBufferGetWidth(imageBuffer); 
  size_t height = CVPixelBufferGetHeight(imageBuffer); 

  CCTexture2D *texture = [[[CCTexture2D alloc] initWithData:baseAddress
     pixelFormat:kCCTexture2DPixelFormat_RGBA8888
      pixelsWide:width
      pixelsHigh:height
      contentSize:CGSizeMake(width,height)
  ] autorelease];
  /*We unlock the  image buffer*/
  CVPixelBufferUnlockBaseAddress(imageBuffer,0);

  [self initWithTexture:texture capacity:16];
  // schedule texture updates for the frame duration (1/freq)
  [self schedule:@selector(updateTexture) interval:1.0/self.videoTrack.nominalFrameRate];
  return self;
}

- (void)rewindAssetReader
{
  NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
    [NSNumber numberWithInt:kCVPixelFormatType_32BGRA], (NSString*)kCVPixelBufferPixelFormatTypeKey,
  nil];
  self.trackOutput = nil;
  self.trackOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:videoTrack outputSettings:settings];

  NSError *error  = [[NSError alloc] autorelease];
  self.assetReader = nil;
  self.assetReader = [AVAssetReader assetReaderWithAsset:asset error:&error];
  [assetReader addOutput:trackOutput];
  [assetReader startReading];
}

- (void)updateTexture
{
  if (self.assetReader.status == AVAssetReaderStatusCompleted) {
    // this texture should repeat from the beginning
    [self rewindAssetReader];
  }
  CMSampleBufferRef *sampleBuffer = [trackOutput copyNextSampleBuffer];
  CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
  CVPixelBufferLockBaseAddress(imageBuffer,0); 
  /*Get information about the image*/
  uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer); 
  size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
  size_t width = CVPixelBufferGetWidth(imageBuffer); 
  size_t height = CVPixelBufferGetHeight(imageBuffer); 

  // update the texture
  glBindTexture(GL_TEXTURE_2D, self.texture.name);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, baseAddress);
  /*We unlock the  image buffer*/
  CVPixelBufferUnlockBaseAddress(imageBuffer,0);
  [sampleBuffer release];
}
@end
