//__________________________________________________________________________________________________
//
// Copyright © 2014 Bernard Krummenacher                                              Silicon-Peace
//__________________________________________________________________________________________________
//
// PROJECT  CardAnimations
//__________________________________________________________________________________________________
//
//! \file   CardAnimationEngine.m
//! \brief  The base class implementing the card animation engine.
//!
//! \author Bernard Krummenacher
//__________________________________________________________________________________________________

#import "CardAnimationEngine.h"
#import "CardClass.h"
#import "MasterInclude.h"
//__________________________________________________________________________________________________

//! A simple class for remenbering the cards start center position.
@implementation AnimatedCard
// Coordinate utilities
- (CGPoint) offsetPointToParentCoordinates: (CGPoint) aPoint
{
    return CGPointMake(aPoint.x + self->Card.center.x,
                       aPoint.y + self->Card.center.y);
}

- (CGPoint) pointInViewCenterTerms: (CGPoint) aPoint
{
    return CGPointMake(aPoint.x - self->Card.center.x,
                       aPoint.y - self->Card.center.y);
}

- (CGPoint) pointInTransformedView: (CGPoint) aPoint
{
    CGPoint offsetItem = [self pointInViewCenterTerms:aPoint];
    CGPoint updatedItem = CGPointApplyAffineTransform(
                                                      offsetItem, self->Card.transform);
    CGPoint finalItem =
    [self offsetPointToParentCoordinates:updatedItem];
    return finalItem;
}

- (CGRect) originalFrame
{
    CGAffineTransform currentTransform = self->Card.transform;
    self->Card.transform = CGAffineTransformIdentity;
    CGRect originalFrame = self->Card.frame;
    self->Card.transform = currentTransform;
    
    return originalFrame;
}

// These four methods return the positions of view elements
// with respect to the current transform

- (CGPoint) transformedTopLeft
{
    CGRect frame = self.originalFrame;
    CGPoint point = frame.origin;
    return [self pointInTransformedView:point];
}

- (CGPoint) transformedTopRight
{
    CGRect frame = self.originalFrame;
    CGPoint point = frame.origin;
    point.x += frame.size.width;
    return [self pointInTransformedView:point];
}

- (CGPoint) transformedBottomRight
{
    CGRect frame = self.originalFrame;
    CGPoint point = frame.origin;
    point.x += frame.size.width;
    point.y += frame.size.height;
    return [self pointInTransformedView:point];
}

- (CGPoint) transformedBottomLeft
{
    CGRect frame = self.originalFrame;
    CGPoint point = frame.origin;
    point.y += frame.size.height;
    return [self pointInTransformedView:point];
}

@end
//__________________________________________________________________________________________________

//==================================================================================================

//! The base class implementing the card animation engine.
@implementation CardAnimationEngine
{
  NSMutableArray* AnimatedCards;    //!< Array of cards to animate with the card center at the start of the animation.
  NSInteger       NumSpadeCards;    //!< The number of spade cards in this animation.
  NSInteger       NumClubCards;     //!< The number of club cards in this animation.
  NSInteger       NumDiamondCards;  //!< The number of diamond cards in this animation.
  NSInteger       NumHeartCards;    //!< The number of heart cards in this animation.
}
@synthesize overlay;
@synthesize verticalPos;
//____________________

-(instancetype)init
{
  self = [super init];
  if (self != nil)
  {
    self.nominalDuration  = 1;
    self.verticalPos      = 0.5;
    AnimatedCards         = [[NSMutableArray alloc] initWithCapacity:50];
  }
  return self;
}
//__________________________________________________________________________________________________

- (void)dealloc
{
}
//__________________________________________________________________________________________________

- (NSInteger)numCards
{
  return AnimatedCards.count;
}
//__________________________________________________________________________________________________

- (NSInteger)numSpadeCards
{
  return NumSpadeCards;
}
//__________________________________________________________________________________________________

- (NSInteger)numClubCards
{
  return NumClubCards;
}
//__________________________________________________________________________________________________

- (NSInteger)numDiamondCards
{
  return NumDiamondCards;
}
//__________________________________________________________________________________________________

- (NSInteger)numHeartCards
{
  return NumHeartCards;
}
//__________________________________________________________________________________________________

- (CGSize)cardSize
{
  if (AnimatedCards.count == 0)
  {
    return CGSizeZero;
  }
  return ((AnimatedCard*)[AnimatedCards objectAtIndex:0])->Card.bounds.size;
}
//__________________________________________________________________________________________________

- (CGSize)viewSize
{

  return (GAMETABLE).bounds.size;
}
//__________________________________________________________________________________________________

//! Launch the animation for the given set of cards. Completion block is called when animation has completed.
- (void)startAnimationWithCards:(NSArray*)cards completion:(BlockAction)completion
{
  [AnimatedCards removeAllObjects];
  NSInteger cardIndex = 0;
  NumSpadeCards       = 0;
  NumClubCards        = 0;
  NumDiamondCards     = 0;
  NumHeartCards       = 0;
  for (CardClass* card in cards)
  {
    AnimatedCard* animCard  = [[AnimatedCard alloc] init];
    animCard->Card          = card;
    animCard->StartCenter   = card.center;
    animCard->EndCenter     = card.center;
    animCard->CardIndex     = cardIndex++;
    [AnimatedCards addObject:animCard];
    switch (card.suit)
    {
    case CARDCLASS_SUIT_SPADE:
      NumSpadeCards++;
      break;
    case CARDCLASS_SUIT_CLUB:
      NumClubCards++;
      break;
    case CARDCLASS_SUIT_DIAMOND:
      NumDiamondCards++;
      break;
    case CARDCLASS_SUIT_HEART:
      NumHeartCards++;
      break;
    }
  }
    
    if (overlay != nil)
    {
        [overlay setCards:AnimatedCards];
        [overlay showAnimated:YES];
    }

  [self startAnimation:completion];
}
//__________________________________________________________________________________________________

//! Stop the animation.
- (void)stopAnimation
{
  [super stopAnimation];
    
    if (overlay != nil)
    {
        [overlay hideAnimated:YES];
    }

  [AnimatedCards removeAllObjects];
  NumSpadeCards   = 0;
  NumClubCards    = 0;
  NumDiamondCards = 0;
  NumHeartCards   = 0;
}
//__________________________________________________________________________________________________

//! Switch to the specified animation part.
- (void)gotoAnimationPart:(NSInteger)animationPart
{
  [super gotoAnimationPart:animationPart];
}
//__________________________________________________________________________________________________

//! Called by the animation engine before starting the animation. Should be overloaded by derived classes.
- (void)initializeAnimation;
{
  [super initializeAnimation];
  for (AnimatedCard* animCard in AnimatedCards)
  {
    [self initializeAnimationForCard:animCard];
  }
  [self reorderCardsInZAxis];
}
//__________________________________________________________________________________________________

//! Called by the animation engine before starting the animation. Should be overloaded by derived classes.
- (void)reorderCardsInZAxis
{
}
//__________________________________________________________________________________________________

//! Called by the animation engine when switching to the next animation part. Should be overloaded by derived classes.
- (void)initializeAnimationPart:(NSInteger)animationPart
{
  [super initializeAnimationPart:animationPart];
  for (AnimatedCard* card in AnimatedCards)
  {
    [self initializeAnimationPart:animationPart forCard:card];
  }
}
//__________________________________________________________________________________________________

//! Called by the animation engine for every card before starting the animation. Should be overloaded by derived classes.
- (void)initializeAnimationForCard:(AnimatedCard*)card
{
  card->EndCenter.x = (GAMETABLE).bounds.size.width  / 2;
  card->EndCenter.y = (GAMETABLE).bounds.size.height * verticalPos;
}
//__________________________________________________________________________________________________

//! Called by the animation engine for every card when switching to the next animation part. Should be overloaded by derived classes.
- (void)initializeAnimationPart:(NSInteger)animationPart forCard:(AnimatedCard*)card
{
}
//__________________________________________________________________________________________________

//! Called by the animation engine for each animation step. Animation stops if YES is returned.
- (BOOL)updateAnimation
{
//  NSLog(@"updateAnimationforParameter: %f", parametricValue);
  for (AnimatedCard* card in AnimatedCards)
  {
    card->Card.center     = [self CalculatePositionForCard:card];
    card->Card.transform  = [self CalculateTransformForCard:card];
  }
    
    if ((overlay != nil) && !overlay.hidden)
    {
        [overlay updateAnimation:self.parametricValue];
    }

  return [super updateAnimation]; // Stop animation when parameter value reaches 1.0.
}
//__________________________________________________________________________________________________

//! Called by the animation engine for every card at every animation step. Should be overloaded by derived classes.
//! This implementation moves all the cards to the center of the screen.
- (CGPoint)CalculatePositionForCard:(AnimatedCard*)card
{
  CGPoint cardCenter;
  cardCenter.x = card->EndCenter.x * self.parametricValue + card->StartCenter.x * (1 - self.parametricValue);
  cardCenter.y = card->EndCenter.y * self.parametricValue + card->StartCenter.y * (1 - self.parametricValue);
  return cardCenter;
}
//__________________________________________________________________________________________________

//! Called by the animation engine for every card at every animation step. Should be overloaded by derived classes.
//! This implementation does nothing.
- (CGAffineTransform)CalculateTransformForCard:(AnimatedCard*)card
{
  return CGAffineTransformIdentity;
}
//__________________________________________________________________________________________________
//__________________________________________________________________________________________________

//! Get the card with the specified index. Returns nil if not found.
- (AnimatedCard*)findCardWithIndex:(NSInteger)index
{
    if (index < AnimatedCards.count)
    {
        return [AnimatedCards objectAtIndex:index];
    }
    return nil;
}

//! Get the card with the specified rank and suit. Returns nil if not found.
- (AnimatedCard*)findCardWithRank:(NSInteger)rank andSuit:(NSInteger)suit
{
  for (AnimatedCard* card in AnimatedCards)
  {
    if ((card->Card.rank == rank) && (card->Card.suit == suit))
    {
      return card;
    }
  }
  return nil;
}
//__________________________________________________________________________________________________

//! Perform an action for each animated card.
- (void)forEachCard:(BlockCardAction)action
{
  for (AnimatedCard* card in AnimatedCards)
  {
    action(card);
  }
}
//__________________________________________________________________________________________________

@end
//__________________________________________________________________________________________________
