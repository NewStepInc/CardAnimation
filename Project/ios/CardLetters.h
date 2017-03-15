//__________________________________________________________________________________________________
//
// Copyright © 2015 Bernard Krummenacher                                              Silicon-Peace
//__________________________________________________________________________________________________
//
// PROJECT  CardAnimations
//__________________________________________________________________________________________________
//
//! \file   CardLetters.m
//! \brief  A pair of classes that make texts from cards.
//!
//! \author Bernard Krummenacher
//__________________________________________________________________________________________________

#import "CardClass.h"
#import "MasterInclude.h"
//__________________________________________________________________________________________________

//! The base letter class.
@interface Letter : NSObject
{
@public
        NSInteger   NumCards; //!< Number of cards in this letter.
  const NSInteger*  CardPosX; //!< A C array of center x positions (in 0..6 coordinates) of the cards composing this letter.
  const NSInteger*  CardPosY; //!< A C array of center y positions (in 0..12 coordinates) of the cards composing this letter.
}
//____________________

- (CGFloat)cardPositionXForIndex:(NSInteger)index;
- (CGFloat)cardPositionYForIndex:(NSInteger)index;
- (CGFloat)cardRotationForIndex:(NSInteger)index;
//____________________

@end
//__________________________________________________________________________________________________

//! A letter class with the associated cards and position.
@interface CardLetter : Letter
{
@public
  NSMutableArray* Cards;    //!< The cards making this letter.
  CGPoint         Center;   //!< The center position of this letter.
  CGPoint         Rotation; //!< The rotation of this letter.
  CGPoint         Offset;   //!< Offset from the center position of this letter.
  CGVector        Scale;    //!< Scale of this letter. The cards are also scaled.
}
//____________________

- (instancetype)initWithLetter:(Letter*)letter;
//____________________

@end
//__________________________________________________________________________________________________

//! A whole alphabet of letters.
@interface CardAlphabet : NSObject
{
@public
  NSMutableDictionary* Letters;  //!< The set of letters in this alphabet.
}
@property (readonly) CGFloat  lettersWidth;
@property (readonly) CGFloat  lettersHeight;

@end
//__________________________________________________________________________________________________
