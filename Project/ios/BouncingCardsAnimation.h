//__________________________________________________________________________________________________
//
// Copyright © 2015 Bernard Krummenacher                                              Silicon-Peace
//__________________________________________________________________________________________________
//
// PROJECT  CardAnimations
//__________________________________________________________________________________________________
//
//! \file   BouncingCardsAnimation.h
//! \brief  A class that implement the bouncing cards animation.
//!
//! \author Bernard Krummenacher
//__________________________________________________________________________________________________

#import "CardAnimationEngine.h"
//__________________________________________________________________________________________________

@interface BouncingCardsParameters : NSObject

@property NSArray*  cards;                        //!< The array of cards submitted to these parameters.
@property CGFloat   bounceAmplitude;              //!< The Start amplitude of the bounce normalized to the screen height in range [0..1].
@property CGFloat   bounceDuration;               //!< The duration, in seconds, of a single bounce.
@property CGFloat   bounceDamping;                //!< The damping factor from bounce to bounce in range [0..1].
@property CGFloat   lateralSpeed;                 //!< The horizontal speed in points/second.
@property CGFloat   initialBouncePhase;           //!< The initial phase position in the bounce cycle in range [0..1].
@property CGFloat   cardPhaseShift;               //!< The phase shift of successive cards.
@property CGFloat   suitPhaseShift;               //!< The phase shift between the suits.
@property CGFloat   initialLateralPos;            //!< The initial horizontal position of the bouncing cards, in points.
@property CGFloat   lateralSuitOffset;            //!< The horizontal distance, in points, between cards of different suit.
@property CGFloat   numBouncesBeforeDampingReset; //!< The damping factor is reset after that number of bounces.
//____________________

@end
//==================================================================================================

//! A class that implement the bouncing cards animation.
@interface BouncingCardsAnimation : CardAnimationEngine
{
}
//____________________

//! Call this method if you want to replace all the card sets, including the default one.
- (void)removeAllBouncingCardsSets;
//____________________

//! Add a set of cards with the related parameters.
- (void)addBouncingCardsSet:(BouncingCardsParameters*)cardsSet;
//____________________

//! Set the parameters for all the cards that are not part of any added cards set. The cards property is ignored.
- (void)setDefaultBouncingParameters:(BouncingCardsParameters*)parameters;
//____________________

@property CGFloat totalAnimationDuration; //!< The total duration of the animation.
//____________________

@end
//__________________________________________________________________________________________________
