//__________________________________________________________________________________________________
//
// Copyright © 2014 Bernard Krummenacher                                              Silicon-Peace
//__________________________________________________________________________________________________
//
// PROJECT  CardAnimations
//__________________________________________________________________________________________________
//
//! \file   SmileyCardsAnimation.h
//! \brief  A class that implement the smiley cards animation.
//!
//! \author Bernard Krummenacher
//__________________________________________________________________________________________________

#import "CardAnimationEngine.h"
//__________________________________________________________________________________________________

//! A class that implement the smiley cards animation.
@interface SmileyCardsAnimation : CardAnimationEngine
{
}
//____________________

@property CGFloat   margin;                 //!< Minimal distance between any face card and any screen border.
//____________________

@property CGFloat   rotationAngle;          //!< Dancer tilt angle in degrees.
@property CGFloat   alignmentDuration;      //!< Duration of the alignment of the cards.
@property CGFloat   alignmentPauseDuration; //!< Duration of the pause after the alignment of the cards.
@property CGFloat   rotationDuration;       //!< Duration of the tilt rotation.
@property CGFloat   rotationPauseDuration;  //!< Duration of the pause when tilted.
//____________________

@end
//__________________________________________________________________________________________________
