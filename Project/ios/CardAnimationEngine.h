//__________________________________________________________________________________________________
//
// Copyright © 2014 Bernard Krummenacher                                              Silicon-Peace
//__________________________________________________________________________________________________
//
// PROJECT  CardAnimations
//__________________________________________________________________________________________________
//
//! \file   CardAnimationEngine.h
//! \brief  The base class implementing the card animation engine.
//!
//! \author Bernard Krummenacher
//__________________________________________________________________________________________________

#import "AnimationEngine.h"
#import "Overlay.h"
//__________________________________________________________________________________________________

#define LOWEST_RANKS  1
#define HIGHEST_RANKS 13
//__________________________________________________________________________________________________

@class CardClass;
//__________________________________________________________________________________________________

//! A simple class for remenbering the cards start center position.
@interface AnimatedCard : NSObject
{
@public
  CardClass*  Card;               //!< The card object.
  CGPoint     StartCenter;        //!< The card center position when starting the animation.
  CGPoint     EndCenter;          //!< The Card center position after the animation.
  CGFloat     StartRotation;      //!< The rotation angle when starting the animation.
  CGFloat     EndRotation;        //!< The rotation angle after the animation.
  NSInteger   CardIndex;          //!< Index of the card for animation ordering.
  NSInteger   AnimationPart;      //!< Index of the current animation part for this card. Animation parts definition is specific to each animation.
  CGFloat     Displacement;       //!< Displacement value. Usage is specific to each animation.
  CGFloat     DisplacementSpeed;  //!< Speed of change for the displacement value. Usage is specific to each animation.
  CGFloat     Param0;             //!< Usage is specific to each animation.
  CGFloat     Param1;             //!< Usage is specific to each animation.
  CGFloat     Index0;             //!< Usage is specific to each animation.
  CGFloat     Index1;             //!< Usage is specific to each animation.
  BOOL        Flag0;              //!< Usage is specific to each animation.
  BOOL        Flag1;              //!< Usage is specific to each animation.
  id          Id0;                //!< Usage is specific to each animation.
  id          Id1;                //!< Usage is specific to each animation.
}
@end
//__________________________________________________________________________________________________

typedef void (^BlockCardAction)(AnimatedCard* card);  //!< Definition of a block function type with a single AnimatedCard parameter.
//__________________________________________________________________________________________________

//! The base class implementing the card animation engine.
@interface CardAnimationEngine : AnimationEngine
{
}
//____________________

@property Overlay* overlay;

//____________________

@property CGFloat verticalPos;  //!< Vertical position of the animation in multiple of the screen height (0.0 .. 1.0).
//____________________

@property (readonly) NSInteger  numCards;         //!< The total number of cards in this animation.
@property (readonly) NSInteger  numSpadeCards;    //!< The number of spade cards in this animation.
@property (readonly) NSInteger  numClubCards;     //!< The number of club cards in this animation.
@property (readonly) NSInteger  numDiamondCards;  //!< The number of diamond cards in this animation.
@property (readonly) NSInteger  numHeartCards;    //!< The number of heart cards in this animation.
@property (readonly) CGSize     cardSize;         //!< The size of a card.
@property (readonly) CGSize     viewSize;         //!< The size of the view holding the animation.
//____________________

//! Launch the animation for the given set of cards. Completion block is called when animation has completed.
- (void)startAnimationWithCards:(NSArray*)cards completion:(BlockAction)completion;
//____________________

//! Called by the animation engine before starting the animation. Should be overloaded by derived classes.
- (void)initializeAnimation;
//____________________

//! Called by the animation engine before starting the animation. Should be overloaded by derived classes.
- (void)reorderCardsInZAxis;
//____________________

//! Called by the animation engine for every card before starting the animation. Should be overloaded by derived classes.
- (void)initializeAnimationForCard:(AnimatedCard*)card;
//____________________

//! Called by the animation engine for every card when switching to another animation part. Should be overloaded by derived classes.
- (void)initializeAnimationPart:(NSInteger)animationPart forCard:(AnimatedCard*)card;
//____________________

//! Called by the animation engine for every card at every animation step. Should be overloaded by derived classes.
- (CGPoint)CalculatePositionForCard:(AnimatedCard*)card;
//____________________

//! Called by the animation engine for every card at every animation step. Should be overloaded by derived classes.
- (CGAffineTransform)CalculateTransformForCard:(AnimatedCard*)card;
//____________________

//! Get the card with the specified index. Returns nil if not found.
- (AnimatedCard*)findCardWithIndex:(NSInteger)index;
//____________________

//! Get the card with the specified rank and suit. Returns nil if not found.
- (AnimatedCard*)findCardWithRank:(NSInteger)rank andSuit:(NSInteger)suit;
//____________________

//! Perform an action for each animated card.
- (void)forEachCard:(BlockCardAction)action;
//____________________

@end
//__________________________________________________________________________________________________
