//__________________________________________________________________________________________________
//
// Copyright © 2014 Bernard Krummenacher                                              Silicon-Peace
//__________________________________________________________________________________________________
//
// PROJECT  CardAnimations
//__________________________________________________________________________________________________
//
//! \file   SmileyCardsAnimation.m
//! \brief  A class that implement the smiley cards animation.
//!
//! \author Bernard Krummenacher
//__________________________________________________________________________________________________

#import "AnimationEasing.h"
#import "SmileyCardsAnimation.h"
#import "CardClass.h"
#import "MasterInclude.h"
//__________________________________________________________________________________________________

//!< Enumeration of the parts for this animation.
typedef enum
{
  E_AnimationPart_MoveToPosition, //!< Move cards from their initial position to their place on the smiley.
  E_AnimationPart_Pause,          //!< Mark a pause before starting the dance.
  E_AnimationPart_RotateLeft0,    //!< Rotate left for some angle around the face center.
  E_AnimationPart_LeftPause,      //!< Mark a small pause.
  E_AnimationPart_RotateRight,    //!< Rotate right for twice some angle, rotating around the bottom left corner.
  E_AnimationPart_RightPause,     //!< Mark a small pause.
  E_AnimationPart_RotateLeft1,    //!< Rotate left for some angle around the face center.
  E_AnimationPart_Wink,           //!< Flip the left yes to simulate a wink.
  E_AnimationPart_FinalPause,     //!< Mark a small pause.
  N_AnimationParts,                                           //!< Number of animation parts.
} T_AnimationParts;
//__________________________________________________________________________________________________

//! Struct that contains the parameters of an animation part.
typedef struct
{
  CGFloat Duration; //!< The nominal duration in seconds of the animation part.
} AnimationPart;
//__________________________________________________________________________________________________

//==================================================================================================

//! A class that implement the smiley cards animation.
@implementation SmileyCardsAnimation
{
  AnimationPart AnimationParts[N_AnimationParts]; //!< The table of animation parts.

  CGFloat       FaceCircleRadius; //!< Radius of the smiley face.
  CGFloat       HairArcRadius;    //!< Radius of the smiley hair.
  CGFloat       MouthArcRadius;   //!< Radius of the smiley mouth.
  CGPoint       FaceCircleCenter; //!< Center of the smiley face circle.
  CGPoint       HairArcCenter;    //!< Center of the smiley hair arc.
  CGPoint       MouthArcCenter;   //!< Center of the smiley mouth arc.
  CGPoint       LeftEyePosition;  //!< Position of the smiley left eye.
  CGPoint       RightEyePosition; //!< Position of the smiley right eye.
  CGFloat       HairArcAngle;     //!< Angle covered by the smiley hair arc.
  CGFloat       MouthArcAngle;    //!< Angle covered by the smiley mouth arc.
}
@synthesize margin;
@synthesize rotationAngle;
@synthesize alignmentDuration;
@synthesize alignmentPauseDuration;
@synthesize rotationDuration;
@synthesize rotationPauseDuration;
//____________________

-(instancetype)init
{
  self = [super init];
  if (self != nil)
  {
    margin                  = 30.0;
    rotationAngle           = 30.0;
    alignmentDuration       = 2.0;
    alignmentPauseDuration  = 0.1;
    rotationDuration        = 0.5;
    rotationPauseDuration   = 0.2;

    self.animationPartStart     = E_AnimationPart_MoveToPosition;
    self.animationPartEnd       = N_AnimationParts;
    self.animationPartLoopStart = E_AnimationPart_RotateLeft0;
    self.animationPartLoopEnd   = E_AnimationPart_RotateLeft1;
  }
  return self;
}
//__________________________________________________________________________________________________

- (void)dealloc
{
}
//__________________________________________________________________________________________________

//! Called by the animation engine before starting the animation. Should be overloaded by derived classes.
- (void)initializeAnimation;
{
  AnimationParts[E_AnimationPart_MoveToPosition].Duration = alignmentDuration;
  AnimationParts[E_AnimationPart_Pause].Duration          = alignmentPauseDuration;
  AnimationParts[E_AnimationPart_RotateLeft0].Duration    = rotationDuration;
  AnimationParts[E_AnimationPart_LeftPause].Duration      = rotationPauseDuration;
  AnimationParts[E_AnimationPart_RotateRight].Duration    = rotationDuration * 2;
  AnimationParts[E_AnimationPart_RightPause].Duration     = rotationPauseDuration;
  AnimationParts[E_AnimationPart_RotateLeft1].Duration    = rotationDuration;
  AnimationParts[E_AnimationPart_Wink].Duration           = 0.1;
  AnimationParts[E_AnimationPart_FinalPause].Duration     = 2.0;

  CGFloat viewWidth   = (APPDELEGATE).gameTable.bounds.size.width;
  CGFloat viewHeight  = (APPDELEGATE).gameTable.bounds.size.height;
  BOOL  isPortrait    = (viewWidth < viewHeight);
  CGFloat viewMinSize = (isPortrait? viewWidth: viewHeight);
  CGFloat cardWidth   = self.cardSize.width;
  CGFloat cardHeight  = self.cardSize.height;
  CGFloat maxFaceRadius = 5 * cardHeight;
  FaceCircleRadius    = (viewMinSize - (isPortrait? cardWidth: cardHeight)) / 2 - margin;
  if (FaceCircleRadius > maxFaceRadius)
  {
    FaceCircleRadius = maxFaceRadius;
  }
  HairArcRadius       = FaceCircleRadius + cardHeight * 0.75;
  MouthArcRadius      = FaceCircleRadius * 0.75;
  CGFloat eyeDistance = (cardWidth + FaceCircleRadius / 4) / 2;
  FaceCircleCenter    = CGPointMake(viewWidth / 2              , viewHeight * self.verticalPos);
  HairArcCenter       = CGPointMake(viewWidth / 2              , viewHeight * self.verticalPos);
  MouthArcCenter      = CGPointMake(viewWidth / 2              , FaceCircleCenter.y - FaceCircleRadius * 0.3);
  LeftEyePosition     = CGPointMake(viewWidth / 2 - eyeDistance, FaceCircleCenter.y - FaceCircleRadius / 3);
  RightEyePosition    = CGPointMake(viewWidth / 2 + eyeDistance, FaceCircleCenter.y - FaceCircleRadius / 3);
  HairArcAngle        = M_PI_2; // 90°
  MouthArcAngle       = M_PI_2; // 90°

  [super initializeAnimation];
}
//__________________________________________________________________________________________________

//! Called by the animation engine before starting the animation. Should be overloaded by derived classes.
- (void)reorderCardsInZAxis
{
  NSInteger i;
  for (i = self.numSpadeCards; i > 0; i--)
  {
    AnimatedCard* card = [self findCardWithRank:i andSuit:CARDCLASS_SUIT_SPADE];
    if (card != nil)
    {
      [card->Card.superview bringSubviewToFront:card->Card];
    }
  }
  for (i = self.numHeartCards; i > 0; i--)
  {
    AnimatedCard* card = [self findCardWithRank:i andSuit:CARDCLASS_SUIT_HEART];
    if (card != nil)
    {
      [card->Card.superview bringSubviewToFront:card->Card];
    }
  }
    for (i =self.numDiamondCards; i > 0; i--)
  {
    AnimatedCard* card = [self findCardWithRank:i andSuit:CARDCLASS_SUIT_DIAMOND];
    if (card != nil)
    {
      [card->Card.superview bringSubviewToFront:card->Card];
    }
  }
  for (i = self.numClubCards; i > 0; i--)
  {
    AnimatedCard* card = [self findCardWithRank:i andSuit:CARDCLASS_SUIT_CLUB];
    if (card != nil)
    {
      [card->Card.superview bringSubviewToFront:card->Card];
    }
  }
}
//__________________________________________________________________________________________________

//! Called by the animation engine when switching to the next animation part. Should be overloaded by derived classes.
- (void)initializeAnimationPart:(NSInteger)animationPart
{
  switch (self.currentAnimationPart)
  {
  case E_AnimationPart_LeftPause:
    if (self.currentAnimationLoop == 0)
    {
      AnimationParts[E_AnimationPart_RotateLeft0].Duration = rotationDuration * 2;
    }
    break;
  default:
    break;
  }
  [self setDurationForCurrentAnimationPart:AnimationParts[self.currentAnimationPart].Duration];
  [super initializeAnimationPart:animationPart];
}
//__________________________________________________________________________________________________

//! Called by the animation engine for every card before starting the animation. Should be overloaded by derived classes.
- (void)initializeAnimationForCard:(AnimatedCard*)card
{
  switch (card->Card.suit)
  {
  case CARDCLASS_SUIT_SPADE:
    if (card->Card.rank == 13)// self.numSpadeCards)
    {
      card->EndCenter   = RightEyePosition;
      card->EndRotation = M_PI -atan2(FaceCircleCenter.x - card->EndCenter.x, FaceCircleCenter.y + FaceCircleRadius - card->EndCenter.y);
    }
    else
    {
      CGFloat parametricPosInLine = (card->Card.rank - 1.0) / (13 - 2.0);
      CGFloat angle = M_PI_2 - MouthArcAngle * (0.5 - parametricPosInLine);
      card->EndCenter.x = MouthArcCenter.x + cos(angle) * MouthArcRadius;
      card->EndCenter.y = MouthArcCenter.y + sin(angle) * MouthArcRadius;
      card->EndRotation = angle + M_PI;
    }
    break;
  case CARDCLASS_SUIT_CLUB:
    if (card->Card.rank == 13)//self.numClubCards)
    {
      card->EndCenter = LeftEyePosition;
      card->EndRotation = M_PI -atan2(FaceCircleCenter.x - card->EndCenter.x, FaceCircleCenter.y + FaceCircleRadius - card->EndCenter.y);
    }
    else
    {
      CGFloat parametricPosInLine = (card->Card.rank - 1.0) / (13 - 2.0);
      CGFloat angle = HairArcAngle * (parametricPosInLine - 0.5) - M_PI_2;
      card->EndCenter.x = HairArcCenter.x + cos(angle) * HairArcRadius;
      card->EndCenter.y = HairArcCenter.y + sin(angle) * HairArcRadius;
      card->EndRotation = angle + M_PI_2;
      [card->Card.superview bringSubviewToFront:card->Card];
    }
    break;
  case CARDCLASS_SUIT_DIAMOND:
    {
      CGFloat parametricPosInLine = (card->Card.rank - 1.0) / (13);
      CGFloat angle = M_PI * (parametricPosInLine - 0.5) + M_PI;
      card->EndCenter.x = FaceCircleCenter.x + cos(angle) * FaceCircleRadius;
      card->EndCenter.y = FaceCircleCenter.y + sin(angle) * FaceCircleRadius;
      card->EndRotation = angle + M_PI;
    }
    break;
  case CARDCLASS_SUIT_HEART:
    {
      CGFloat parametricPosInLine = (card->Card.rank - 1.0) / (13);
      CGFloat angle = M_PI * (parametricPosInLine - 0.5);
      card->EndCenter.x = FaceCircleCenter.x + cos(angle) * FaceCircleRadius;
      card->EndCenter.y = FaceCircleCenter.y + sin(angle) * FaceCircleRadius;
      card->EndRotation = angle + M_PI;
    }
    break;
  }
  if (card->EndRotation > M_PI)
  {
    card->EndRotation -= 2 * M_PI;
  }
}
//__________________________________________________________________________________________________

//! Called by the animation engine for each animation step. Animation stops if YES is returned.
- (BOOL)updateAnimation
{
  // Process animation parts.
  if (self.partParametricValue > 1.001)
  {
    if ([self gotoNextAnimationPart])
    {
      return YES;
    }
  }
  // Process the animation step.
  [super updateAnimation];  // Ignore returned value.
  return NO;
}
//__________________________________________________________________________________________________

//! Called by the animation engine for every card at every animation step.
- (CGPoint)CalculatePositionForCard:(AnimatedCard*)card
{
  CGPoint cardCenter;
  switch (self.currentAnimationPart)
  {
  case E_AnimationPart_MoveToPosition:
    {
      CGFloat paramValue = EaseInOut(self.partParametricValue, QuadraticEaseFunc);
      CGFloat parametricPosInLine = card->CardIndex / (self.numCards - 1.0);
      CGPoint center;
      CGFloat lineMargin = card->Card.frame.size.width / 2 + margin;
      center.x = lineMargin + ((APPDELEGATE).gameTable.bounds.size.width - 2 * lineMargin) * parametricPosInLine;
      center.y = ((APPDELEGATE).gameTable.bounds.size.height / 2) * (1 - (parametricPosInLine - 0.5) * 0);
      cardCenter.x = card->EndCenter.x * paramValue + card->StartCenter.x * (1 - paramValue);
      cardCenter.y = card->EndCenter.y * paramValue + card->StartCenter.y * (1 - paramValue);
    }
    break;
  case E_AnimationPart_Wink:
    if ((card->Card.suit == CARDCLASS_SUIT_CLUB) && (card->Card.rank == self.numClubCards))
    {
      [card->Card flipToFace:2];
    }
    cardCenter = card->Card.center;
    break;
  case E_AnimationPart_FinalPause:
    if ((card->Card.suit == CARDCLASS_SUIT_CLUB) && (card->Card.rank == self.numClubCards))
    {
      [card->Card flipToFace:1];
    }
    cardCenter = card->Card.center;
    break;
  case E_AnimationPart_Pause:
  case E_AnimationPart_RotateLeft0:
  case E_AnimationPart_LeftPause:
  case E_AnimationPart_RotateRight:
  case E_AnimationPart_RightPause:
  case E_AnimationPart_RotateLeft1:
  default:
    // Do not change the center position.
    cardCenter = card->Card.center;
    break;
  }
  return cardCenter;
}
//__________________________________________________________________________________________________

//! Called by the animation engine for every card at every animation step.
- (CGAffineTransform)CalculateTransformForCard:(AnimatedCard*)card
{
  CGFloat offsetX = card->Card.center.x - FaceCircleCenter.x;
  CGFloat offsetY = card->Card.center.y - FaceCircleCenter.y;
  CGAffineTransform transform = CGAffineTransformIdentity;
  switch (self.currentAnimationPart)
  {
  case E_AnimationPart_MoveToPosition:
    transform = CGAffineTransformRotate(transform, card->EndRotation * EaseInOut(self.partParametricValue, QuadraticEaseFunc));
    break;
  case E_AnimationPart_RotateLeft0:
    {
      transform = CGAffineTransformTranslate(transform, -offsetX, -offsetY);
//      CGFloat ease = (self.currentAnimationLoop == 0)? EaseInOut(self.partParametricValue, QuadraticEaseFunc): EaseOut(self.partParametricValue, QuadraticEaseFunc);
      CGFloat ease;
      if (self.currentAnimationLoop == 0)
      {
        ease = EaseInOut(self.partParametricValue, QuadraticEaseFunc);
      }
      else
      {
        ease = 2 * EaseInOut(self.partParametricValue, QuadraticEaseFunc) - 1;
      }
      transform = CGAffineTransformRotate(transform, -rotationAngle * ease * M_PI / 180);
      transform = CGAffineTransformTranslate(transform, offsetX, offsetY);
      transform = CGAffineTransformRotate(transform, card->EndRotation);
    }
    break;
  case E_AnimationPart_RotateRight:
    transform = CGAffineTransformTranslate(transform, -offsetX, -offsetY);
    transform = CGAffineTransformRotate(transform, rotationAngle * (2 * EaseInOut(self.partParametricValue, QuadraticEaseFunc) - 1) * M_PI / 180);
    transform = CGAffineTransformTranslate(transform, offsetX, offsetY);
    transform = CGAffineTransformRotate(transform, card->EndRotation);
    break;
  case E_AnimationPart_RotateLeft1:
    {
      transform = CGAffineTransformTranslate(transform, -offsetX, -offsetY);
      CGFloat ease = EaseInOut(self.partParametricValue, QuadraticEaseFunc);
      transform = CGAffineTransformRotate(transform, rotationAngle * (1 - ease) * M_PI / 180);
      transform = CGAffineTransformTranslate(transform, offsetX, offsetY);
      transform = CGAffineTransformRotate(transform, card->EndRotation);
    }
    break;
  case E_AnimationPart_Pause:
  case E_AnimationPart_LeftPause:
  case E_AnimationPart_RightPause:
  case E_AnimationPart_FinalPause:
  default:
    // Do not change the transform.
    transform = card->Card.transform;
    break;
  }
  return transform;
}
//__________________________________________________________________________________________________

@end
//__________________________________________________________________________________________________
