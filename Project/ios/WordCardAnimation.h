//__________________________________________________________________________________________________
//
// Copyright © 2015 Bernard Krummenacher                                              Silicon-Peace
//__________________________________________________________________________________________________
//
// PROJECT  CardAnimations
//__________________________________________________________________________________________________
//
//! \file   WordCardAnimation.h
//! \brief  A class that implement the word cards animation.
//!
//! \author Bernard Krummenacher
//__________________________________________________________________________________________________

#import "CardAnimationEngine.h"
//__________________________________________________________________________________________________

//! A class that implement the word cards animation.
@interface WordCardAnimation : CardAnimationEngine
{
}
//____________________

@property NSString* line1;              //!< The top line of text.
@property NSString* line2;              //!< The bottom line of text.
@property CGFloat   cardsScaleFactor;   //!< The scale factor to apply to the cards when in the letters. Ignored when scrolling is disabled.
@property CGFloat   lettersSpacing;     //!< The distance between following letters in multiple of the letters width.
@property CGFloat   lineSpacing;        //!< Vertical space between lines in multiple of the letters height.
@property CGFloat   borderMargin;       //!< The lateral border margin of the largest text line, in multiple of the screen width.
@property BOOL      flipCards;          //!< When yes, the card faces are flip at the start of the animation.
@property CGFloat   morphingDuration;   //!< Duration of the morphing to letters process.
@property BOOL      scrollAnimation;    //!< When YES, the words will scroll through the screen.
@property BOOL      verticallyCentered; //!< When YES, the lines are vertically centered on the screen.

//____________________

@property CGFloat totalAnimationDuration; //!< The total duration of the animation.
//____________________

@end
//__________________________________________________________________________________________________
