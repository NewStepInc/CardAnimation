//__________________________________________________________________________________________________
//
// Copyright © 2015 Bernard Krummenacher                                              Silicon-Peace
//__________________________________________________________________________________________________
//
// PROJECT  CardAnimations
//__________________________________________________________________________________________________
//
//! \file   WordCardAnimation.m
//! \brief  A class that implement the word cards animation.
//!
//! \author Bernard Krummenacher
//__________________________________________________________________________________________________

#import "WordCardAnimation.h"

#import "AnimationEasing.h"
#import "CardClass.h"
#import "CardLetters.h"
#import "MasterInclude.h"
//__________________________________________________________________________________________________

//! Enumeration of the parts for this animation.
typedef enum
{
  E_AnimationPart_AnimateWords, //!< The composed words are animated through the screen.
  N_AnimationParts,             //!< Number of animation parts.
} T_AnimationParts;
//__________________________________________________________________________________________________

//! Struct that contains the parameters of an animation part.
typedef struct
{
  CGFloat Duration; //!< The nominal duration in seconds of the animation part.
} AnimationPart;
//__________________________________________________________________________________________________

//==================================================================================================

//! A class that implement the word cards animation.
@implementation WordCardAnimation
{
  AnimationPart   AnimationParts[N_AnimationParts]; //!< The table of animation parts.
  CardAlphabet*   Alphabet;
  NSMutableArray* AllCards;
  NSMutableArray* CardLettersOfLine1;
  NSMutableArray* CardLettersOfLine2;
  CGFloat         Line1BasePos;
  CGFloat         Line2BasePos;
  CGFloat         MaxLinesExtent;
  CGFloat         AnimatedScaleFactor;
  NSInteger       FrameCount;
}
//____________________

-(instancetype)init
{
  self = [super init];
  if (self != nil)
  {
    self.lettersSpacing = 0.2;
    self.lineSpacing    = 0.2;

    self.animationPartStart     = E_AnimationPart_AnimateWords;
    self.animationPartEnd       = N_AnimationParts;
    self.animationPartLoopStart = -1;
    self.animationPartLoopEnd   = -1;
    Alphabet = [CardAlphabet new];
  }
  return self;
}
//__________________________________________________________________________________________________

- (void)dealloc
{
}
//__________________________________________________________________________________________________

//! Launch the animation for the given set of cards. Completion block is called when animation has completed.
- (void)startAnimationWithCards:(NSArray*)cards completion:(BlockAction)completion
{
    NSInteger minLineLength;
    
    UIDeviceOrientation deviceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if(deviceOrientation == UIDeviceOrientationPortrait || deviceOrientation == UIDeviceOrientationPortraitUpsideDown)
        minLineLength = 5;
    else
        minLineLength = 10;
    
  NSInteger maxLineLength = MAX(MAX(self.line1.length, self.line2.length),minLineLength);
    
  self.cardsScaleFactor   = ((GAMETABLE).bounds.size.width * (1 - 2 * self.borderMargin)) / (Alphabet.lettersWidth * (maxLineLength + (maxLineLength - 1) * self.lettersSpacing));
    
    CGFloat verticalScaleFactor = (GAMETABLE).bounds.size.height/(Alphabet.lettersHeight*2 + self.lineSpacing);
    
    if(verticalScaleFactor < self.cardsScaleFactor)
        self.cardsScaleFactor = verticalScaleFactor;
    
  CGFloat letterHeight    = Alphabet.lettersHeight * self.cardsScaleFactor;
  CGFloat basePos;
    
    DebugLog(@"Card scale factor: %f  letterHeight: %f  Orig Letter Height: %f",self.cardsScaleFactor,letterHeight,Alphabet.lettersHeight);
    
  if (self.verticallyCentered)
  {
    basePos = (GAMETABLE).bounds.size.height / 2 + Alphabet.lettersHeight * (1 + self.lineSpacing / 2) * self.cardsScaleFactor;
  }
  else
  {
    basePos = (GAMETABLE).bounds.size.height * (1 - self.verticalPos);
  }
  Line2BasePos = basePos      - letterHeight / 2;
  Line1BasePos = Line2BasePos - letterHeight * (1 + self.lineSpacing);

  AllCards = [NSMutableArray arrayWithArray:cards];
  CardLettersOfLine1 = [NSMutableArray arrayWithCapacity:8];
  CardLettersOfLine2 = [NSMutableArray arrayWithCapacity:8];
  NSInteger totalNumCards = 0;

  for (NSInteger i = 0; i < self.line1.length; ++i)
  {
    NSString* character = [self.line1 substringWithRange:NSMakeRange(i, 1)];
      Letter *l = [Alphabet->Letters objectForKey:character];
      if(l == nil)
          l = [Alphabet->Letters objectForKey:@" "];
      
    CardLetter* letter = [[CardLetter alloc] initWithLetter:l];
    [CardLettersOfLine1 addObject:letter];
    totalNumCards += letter->NumCards;
  }

  for (NSInteger i = 0; i < self.line2.length; ++i)
  {
    NSString* character = [self.line2 substringWithRange:NSMakeRange(i, 1)];
      
      Letter *l = [Alphabet->Letters objectForKey:character];
      if(l == nil)
          l = [Alphabet->Letters objectForKey:@" "];

    CardLetter* letter = [[CardLetter alloc] initWithLetter:l];
    [CardLettersOfLine2 addObject:letter];
    totalNumCards += letter->NumCards;
  }

    if(cards.count > totalNumCards)
    {
        for (NSInteger i = totalNumCards; i < cards.count; ++i)
        {
            CardClass* originalCard = [cards objectAtIndex:i];
            
            [originalCard removeFromSuperview];

        }
    }
    else
    {
        NSInteger pref = [DATASTORAGE getPrefNamed:kCardDeckPref];

        for (NSInteger i = cards.count; i < totalNumCards; ++i)
        {
            CardClass* originalCard = [cards objectAtIndex:(i % cards.count)];
            CardClass* cloneCard    = [[CardClass alloc] initWithRank:originalCard.rank Suit:originalCard.suit cardDeckPref:pref];
            CGPoint center          = originalCard.center;
            center.x               += (GAMETABLE).bounds.size.width;
            cloneCard.center        = center;
            [AllCards addObject:cloneCard];
        }
    }

  MaxLinesExtent = MAX(CardLettersOfLine1.count, CardLettersOfLine2.count) * Alphabet.lettersWidth * (1 + self.lettersSpacing) * self.cardsScaleFactor;

  [super startAnimationWithCards:AllCards completion:^
  {
    for (NSInteger i = 0; i < cards.count; ++i)
    {
      CardClass* card = [AllCards objectAtIndex:i];
      [card flipToFace:1];
    }
    for (NSInteger i = cards.count; i < totalNumCards; ++i)
    {
      CardClass* card = AllCards.lastObject;
      //[card removeFromSuperview];
      [AllCards removeObject:card];
    }
    completion();
  }];
}
//__________________________________________________________________________________________________

//! Called by the animation engine before starting the animation. Should be overloaded by derived classes.
- (void)initializeAnimation
{
  AnimationParts[E_AnimationPart_AnimateWords].Duration = 1.0;  // Subject to change.

  FrameCount = 0;
  NSInteger cardIndex = 0;
  for (NSInteger i = 0; i < CardLettersOfLine1.count; ++i)
  {
    CardLetter* letter = [CardLettersOfLine1 objectAtIndex:i];
    for (NSInteger j = 0; j < letter->NumCards; ++j)
    {
      AnimatedCard* card  = [self findCardWithIndex:cardIndex++];
      [letter->Cards addObject:card];
      card->Id0           = letter;
      card->Index0        = j;
    }
  }
  for (NSInteger i = 0; i < CardLettersOfLine2.count; ++i)
  {
    CardLetter* letter = [CardLettersOfLine2 objectAtIndex:i];
    for (NSInteger j = 0; j < letter->NumCards; ++j)
    {
      AnimatedCard* card  = [self findCardWithIndex:cardIndex++];
      [letter->Cards addObject:card];
      card->Id0           = letter;
      card->Index0        = j;
    }
  }

  [super initializeAnimation];
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
  [self setDurationForCurrentAnimationPart:AnimationParts[self.currentAnimationPart].Duration];
  [super initializeAnimationPart:animationPart];
}
//__________________________________________________________________________________________________

//! Called by the animation engine for every card before starting the animation. Should be overloaded by derived classes.
- (void)initializeAnimationForCard:(AnimatedCard*)card
{
  card->Flag0 = NO; // FLag0 is used to tell if the card finished the initial animation into the letters.
}
//__________________________________________________________________________________________________

- (BOOL)updateLettersAnimation
{
  if (self.flipCards)
  {
    CardClass* card;
    for (int i = 0; i < 5; ++i)
    {
      if (FrameCount < AllCards.count)
      {
        card = [AllCards objectAtIndex:FrameCount++];
        [card flipToFace:2];
      }
    }
  }
  CGFloat lineOffset1;
  CGFloat lineOffset2;
  if (self.scrollAnimation)
  {
    lineOffset1 = nearbyint((GAMETABLE).bounds.size.width - (self.partParametricValue / self.totalAnimationDuration) * MaxLinesExtent);
    lineOffset2 = nearbyint((GAMETABLE).bounds.size.width - (self.partParametricValue / self.totalAnimationDuration) * MaxLinesExtent);
  }
  else
  {
    CGFloat letterWidth = self.cardsScaleFactor * Alphabet.lettersWidth;
    lineOffset1 = ((GAMETABLE).bounds.size.width - (CardLettersOfLine1.count * letterWidth + (CardLettersOfLine1.count - 1) * letterWidth * self.lettersSpacing) + letterWidth) / 2;
    lineOffset2 = ((GAMETABLE).bounds.size.width - (CardLettersOfLine2.count * letterWidth + (CardLettersOfLine2.count - 1) * letterWidth * self.lettersSpacing) + letterWidth) / 2;
  }
//  NSLog(@"updateLettersAnimation partParametricValue: %f, lineOffset: %f", self.partParametricValue, lineOffset);

  for (NSInteger i = CardLettersOfLine1.count - 1; i >= 0; --i)
  {
    CardLetter* letter  = [CardLettersOfLine1 objectAtIndex:i];
    letter->Center      = CGPointMake(lineOffset1 + i * Alphabet.lettersWidth * (1 + self.lettersSpacing) * self.cardsScaleFactor, Line1BasePos - Alphabet.lettersHeight / 2 * self.cardsScaleFactor);
  }

  for (NSInteger i = CardLettersOfLine2.count - 1; i >= 0; --i)
  {
    CardLetter* letter  = [CardLettersOfLine2 objectAtIndex:i];
    letter->Center      = CGPointMake(lineOffset2 + i * Alphabet.lettersWidth * (1 + self.lettersSpacing) * self.cardsScaleFactor, Line2BasePos - Alphabet.lettersHeight / 2 * self.cardsScaleFactor);
  }
  if (self.scrollAnimation)
  {
    return MaxLinesExtent + lineOffset1 < -Alphabet.lettersWidth * self.cardsScaleFactor;
  }
  else
  {
    return self.partParametricValue >= self.totalAnimationDuration;
  }
}
//__________________________________________________________________________________________________

//! Called by the animation engine for each animation step. Animation stops if YES is returned.
- (BOOL)updateAnimation
{
  // Process the animation step.
  // Start whith card letters.
  BOOL done = [self updateLettersAnimation];
  // Continue with the individual cards.
  [super updateAnimation];  // Ignore returned value.
  return done;
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
  CGPoint cardCenter;

  CardLetter* letter      = card->Id0;
  if (letter != nil)
  {
    CGFloat paramValue = EaseOut(MIN(self.partParametricValue / self.morphingDuration, 1.0), CubicEaseFunc);
//    AnimatedScaleFactor = Interpolate(1.0, self.cardsScaleFactor, MIN(self.partParametricValue / self.morphingDuration, 1.0));
    AnimatedScaleFactor = Interpolate(1.0, self.cardsScaleFactor, paramValue);
    NSInteger cardIndex       = card->Index0;
    CGPoint   cardPosInLetter = CGPointMake(letter->Center.x + ([letter cardPositionXForIndex:cardIndex] - Alphabet.lettersWidth / 2) * self.cardsScaleFactor,
                                            letter->Center.y -  [letter cardPositionYForIndex:cardIndex] * self.cardsScaleFactor);
    cardCenter.x = Interpolate(card->StartCenter.x, cardPosInLetter.x, paramValue);
    cardCenter.y = Interpolate(card->StartCenter.y, cardPosInLetter.y, paramValue);
  }
//  NSLog(@"cardCenter: %7.3f, %7.3f (%7.3f, %7.3f)", cardCenter.x, cardCenter.y, letter->CardCenters[cardIndex].x, letter->CardCenters[cardIndex].y);
  return cardCenter;
}
//__________________________________________________________________________________________________

//! Called by the animation engine for every card at every animation step.
- (CGAffineTransform)CalculateTransformForCard:(AnimatedCard*)card
{
  CardLetter* letter          = card->Id0;
  CGFloat paramValue          = EaseOut(MIN(self.partParametricValue / self.morphingDuration, 1.0), CubicEaseFunc);
  CGFloat rotation            = Interpolate(card->StartRotation, [letter cardRotationForIndex:card->Index0], paramValue);
  CGAffineTransform transform = CGAffineTransformMakeRotation(rotation);
  transform                   = CGAffineTransformConcat(transform, CGAffineTransformMakeScale(AnimatedScaleFactor, AnimatedScaleFactor));
  return transform;
}
//__________________________________________________________________________________________________

@end
//__________________________________________________________________________________________________
