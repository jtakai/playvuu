@interface VideoSpriteBatchNode: CCSpriteBatchNode
{
  AVURLAsset *asset;
  AVAssetTrack *videoTrack;
  AVAssetReader *assetReader;
  AVAssetReaderTrackOutput *trackOutput;
}
@property(nonatomic,retain) AVURLAsset *asset;
@property(nonatomic,retain) AVAssetTrack *videoTrack;
@property(nonatomic,retain) AVAssetReader *assetReader;
@property(nonatomic,retain) AVAssetReaderTrackOutput *trackOutput;
+ (id)batchNodeWithVideo:(NSString *)name;
- (id)initWithVideo:(NSString *)name;
- (void)updateTexture;
@end
