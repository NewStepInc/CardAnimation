//__________________________________________________________________________________________________
//
// Copyright © 2015 Bernard Krummenacher                                              Silicon-Peace
//__________________________________________________________________________________________________
//
// PROJECT  CardAnimations
//__________________________________________________________________________________________________
//
//! \file   BouncingCardsAnimation.m
//! \brief  A class that implement the bouncing cards animation.
//!
//! \author Bernard Krummenacher
//__________________________________________________________________________________________________

#import "AnimationEasing.h"
#import "BouncingCardsAnimation.h"
#import "CardClass.h"
#import "MasterInclude.h"
//__________________________________________________________________________________________________

//!< Enumeration of the parts for this animation.
typedef enum
{
  E_AnimationPart_Bounce, //!< This animation has only one part.
  N_AnimationParts,       //!< Number of animation parts.
} T_AnimationParts;
//__________________________________________________________________________________________________
//! Struct that contains the parameters of an animation part.
typedef struct
{
  CGFloat Duration; //!< The nominal duration in seconds of the animation part.
} AnimationPart;
//__________________________________________________________________________________________________

//==================================================================================================

@interface BouncingCardsParameters()
{
@public
  NSMutableArray* Animatedcards;  //!< The array of animated cards submitted to these parameters.
}
@end

@implementation BouncingCardsParameters
{
}
@synthesize cards;
@synthesize bounceAmplitude;
@synthesize bounceDuration;
@synthesize bounceDamping;
@synthesize lateralSpeed;
@synthesize initialBouncePhase;
@synthesize cardPhaseShift;
@synthesize lateralSuitOffset;
//____________________

- (instancetype)init
{
  self = [super init];
  if (self != nil)
  {
    cards = [NSMutableArray arrayWithCapacity:10];
  }
  return self;
}

@end
//==================================================================================================

//! A class that implement the bouncing cards animation.
@implementation BouncingCardsAnimation
{
  AnimationPart             AnimationParts[N_AnimationParts]; //!< The table of animation parts.
  NSMutableArray*           CardsParametersSets;
  BouncingCardsParameters*  DefaultCardsParameters;
}
//____________________

-(instancetype)init
{
  self = [super init];
  if (self != nil)
  {
    CardsParametersSets         = [NSMutableArray arrayWithCapacity:5];
    self.animationPartStart     = E_AnimationPart_Bounce;
    self.animationPartEnd       = N_AnimationParts;
    self.animationPartLoopStart = -1;
    self.animationPartLoopEnd   = -1;
  }
  return self;
}
//__________________________________________________________________________________________________

- (void)dealloc
{
}
//__________________________________________________________________________________________________

//! Call this method if you want to replace all the card sets.
- (void)removeAllBouncingCardsSets
{
  [CardsParametersSets removeAllObjects];
}
//__________________________________________________________________________________________________

//! Add a set of cards with the related parameters.
- (void) addBouncingCardsSet:(BouncingCardsParameters*)cardsSet
{
  [CardsParametersSets addObject:cardsSet];
}
//__________________________________________________________________________________________________

//! Set the parameters for all the cards that are not part of any added cards set. The cards property is ignored.
- (void) setDefaultBouncingParameters:(BouncingCardsParameters*)parameters
{
  if (DefaultCardsParameters != nil)
  {
    [CardsParametersSets removeObject:DefaultCardsParameters];
  }
  DefaultCardsParameters = parameters;
  [CardsParametersSets addObject:DefaultCardsParameters];
}
//__________________________________________________________________________________________________

//! Called by the animation engine before starting the animation. Should be overloaded by derived classes.
- (void)initializeAnimation;
{
  // Initialize the list of cards submitted to the default parameters.
  NSMutableArray* defaultCards = [NSMutableArray arrayWithCapacity:50];
  [self forEachCard:^(AnimatedCard* card)
  {
    BOOL found = NO;
    for (BouncingCardsParameters* parameters in CardsParametersSets)
    {
      if ((parameters != DefaultCardsParameters) && ([parameters.cards indexOfObject:card->Card] != NSNotFound))
      {
        found = YES;
        [parameters->Animatedcards addObject:card];
        card->Id0 = parameters;
        break;
      }
    }
    if (!found)
    {
      [defaultCards addObject:card];
      card->Id0 = DefaultCardsParameters;
    }
  }];
  DefaultCardsParameters->Animatedcards = defaultCards;

  AnimationParts[E_AnimationPart_Bounce].Duration = 1.0;

  [super initializeAnimation];
}
//__________________________________________________________________________________________________

//! Called by the animation engine before starting the animation. Should be overloaded by derived classes.
- (void)reorderCardsInZAxis
{
  for (NSInteger rank = HIGHEST_RANKS; rank >= LOWEST_RANKS; --rank)
  {
    AnimatedCard* card;
    card = [self findCardWithRank:rank andSuit:CARDCLASS_SUIT_DIAMOND];
    if (card != nil)
    {
      [card->Card.superview bringSubviewToFront:card->Card];
    }
    card = [self findCardWithRank:rank andSuit:CARDCLASS_SUIT_SPADE];
    if (card != nil)
    {
      [card->Card.superview bringSubviewToFront:card->Card];
    }
    card = [self findCardWithRank:rank andSuit:CARDCLASS_SUIT_CLUB];
    if (card != nil)
    {
      [card->Card.superview bringSubviewToFront:card->Card];
    }
    card = [self findCardWithRank:rank andSuit:CARDCLASS_SUIT_HEART];
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
  [self setDurationForCurrentAnimationPart:AnimationParts[self.currentAnimationPart].Duration];
  [super initializeAnimationPart:animationPart];
}
//__________________________________________________________________________________________________

//! Called by the animation engine for every card before starting the animation. Should be overloaded by derived classes.
- (void)initializeAnimationForCard:(AnimatedCard*)card
{
  card->Flag0 = NO; // FLag0 is used tell if the card finished the initial interpolating bounce.
  BouncingCardsParameters* parameters = card->Id0;

  // Param0 is used to set the horizontal card center position.
  // Param1 is used to store the the card phase shift.
  switch (card->Card.suit)
  {
  case CARDCLASS_SUIT_DIAMOND:
    card->Param0 = parameters.initialLateralPos;
    card->Param1 = 0;
    break;
  case CARDCLASS_SUIT_SPADE:
    card->Param0 = parameters.initialLateralPos +  (card->Card.bounds.size.width + parameters.lateralSuitOffset);
    card->Param1 = parameters.suitPhaseShift;
    break;
  case CARDCLASS_SUIT_CLUB:
    card->Param0 = parameters.initialLateralPos + 2 * (card->Card.bounds.size.width + parameters.lateralSuitOffset);
    card->Param1 = 2 * parameters.suitPhaseShift;
    break;
  case CARDCLASS_SUIT_HEART:
    card->Param0 = parameters.initialLateralPos + 3 * (card->Card.bounds.size.width + parameters.lateralSuitOffset);
    card->Param1 = 3 * parameters.suitPhaseShift;
    break;
  }
  card->Param1 += parameters.cardPhaseShift * card->Card.rank;
}
//__________________________________________________________________________________________________

//! Called by the animation engine for each animation step. Animation stops if YES is returned.
- (BOOL)updateAnimation
{
  // Process animation parts.
  if (self.partParametricValue > self.totalAnimationDuration)
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

//! Called by the animation engine for every card when switching to the next animation part.
- (void)switchToAnimationPart:(NSInteger)animationPart forCard:(AnimatedCard*)card
{
  card->StartCenter   = card->EndCenter;
  card->StartRotation = card->EndRotation;
}
//__________________________________________________________________________________________________

//! Called by the animation engine for every card at every animation step.
- (CGPoint)CalculatePositionForCard:(AnimatedCard*)card
{
  BouncingCardsParameters* parameters = card->Id0;
  CGFloat frequency = 1 / parameters.bounceDuration; // 0.5 because the JumpWithPhase function generates a sinus with two positive alternances in one period.
  CGFloat amplitude = parameters.bounceAmplitude * (GAMETABLE).bounds.size.height;
  CGFloat damping   = parameters.bounceDamping;
  CGFloat parametricValue = MAX(0, self.parametricValue - card->Param1);
  CGPoint cardCenter;
  cardCenter = card->Card.center;
  CGFloat paramValue = jumpWithPhase(1, frequency, parametricValue, parameters.initialBouncePhase);

  CGFloat lateralValue = card->Param0 + parameters.lateralSpeed * parametricValue;
  CGFloat jumpValue    = (GAMETABLE).bounds.size.height - self.cardSize.height / 2 - paramValue * amplitude * pow(damping, fmod(parameters.initialBouncePhase + parametricValue * frequency, parameters.numBouncesBeforeDampingReset));
  if (!card->Flag0)
  {
    lateralValue = Interpolate(lateralValue, card->StartCenter.x, paramValue);
    cardCenter.y = Interpolate(jumpValue,    card->StartCenter.y, paramValue);
  }
  else
  {
    cardCenter.y = jumpValue;
  }
  CGFloat mirrorWidth = ((GAMETABLE).bounds.size.width - card->Card.bounds.size.width);
  CGFloat mirrorPos   = fmod(lateralValue - card->Card.bounds.size.width / 2, 2 * mirrorWidth);
  cardCenter.x = ((mirrorPos < mirrorWidth)? mirrorPos: 2 * mirrorWidth - mirrorPos) + card->Card.bounds.size.width / 2;
#if 0
  if (card->CardIndex == 51)
  {
    NSLog(@"lateralValue: %f, mirrorWidth: %f, mirrorPos: %f, cardCenter.x: %f", lateralValue, mirrorWidth, mirrorPos, cardCenter.x);
  }
#endif
  // Check for ending the initial interlolated movements.
  if (paramValue < 0.01)
  {
    card->Flag0 = YES;
  }
  return cardCenter;
}
//__________________________________________________________________________________________________

//! Called by the animation engine for every card at every animation step.
- (CGAffineTransform)CalculateTransformForCard:(AnimatedCard*)card
{
  return CGAffineTransformIdentity;
}
//__________________________________________________________________________________________________

@end
//__________________________________________________________________________________________________
