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

#import "AnimationEasing.h"
#import "CardLetters.h"
#import "CardClass.h"
#import "MasterInclude.h"
//__________________________________________________________________________________________________

typedef enum
{
  E_LeftBorder,
  E_LeftVertical,
  E_LeftHorizontal,
  E_LeftOblique,
  E_CenterLeftOblique,
  E_CenterLeftHorizontal,
  E_CenterX,
  E_CenterRightHorizontal,
  E_CenterRightOblique,
  E_RightOblique,
  E_RightHorizontal,
  E_RightVertical,
  E_RightBorder,
  E_ExceptionNh_0,
  E_ExceptionNh_1,
  E_ExceptionNh_2,
  E_ExceptionNh_3,
  E_ExceptionNh_4,
  E_ExceptionXh_0,
  E_ExceptionXh_1,
  E_ExceptionXh_2,
  E_ExceptionXh_3,
  E_ExceptionXh_4,
  E_ExceptionZh_0,
  E_ExceptionZh_1,
  E_ExceptionZh_2,
  E_ExceptionZh_3,
  E_ExceptionZh_4,
  E_Exception7h,
  NumHCards
} HorizontalPositionTypes;
//__________________________________________________________________________________________________

typedef enum
{
  E_TopBorder,
  E_TopHorizontal,
  E_TopOblique,
  E_TopTopVertical,
  E_TopVertical,
  E_CenterTopOblique,
  E_CenterY,
  E_CenterBotOblique,
  E_BotVertical,
  E_BotBotVertical,
  E_BotOblique,
  E_BotHorizontal,
  E_BottomBorder,
  E_ExceptionNv_0,
  E_ExceptionNv_1,
  E_ExceptionNv_2,
  E_ExceptionNv_3,
  E_ExceptionNv_4,
  E_ExceptionXv_0,
  E_ExceptionXv_1,
  E_ExceptionXv_2,
  E_ExceptionXv_3,
  E_ExceptionXv_4,
  E_ExceptionZv_0,
  E_ExceptionZv_1,
  E_ExceptionZv_2,
  E_ExceptionZv_3,
  E_ExceptionZv_4,
  NumVCards
} VerticalPositionTypes;
//__________________________________________________________________________________________________

typedef enum
{
  E_Rotation0,
  E_Rotation45,
  E_Rotation90,
  E_Rotation135,
  E_Rotation180,
  E_Rotation225,
  E_Rotation270,
  E_Rotation315,
  E_ExceptionNr,
  E_ExceptionXr1,
  E_ExceptionXr2,
  E_ExceptionZr,
  E_Exception0r,
} RotationTypes;
//__________________________________________________________________________________________________

static       CGFloat*   PositionsX;
static       CGFloat*   PositionsY;
static const CGFloat    Rotations[]   = {0, M_PI_4, M_PI_2, 3 * M_PI_4, M_PI, 5* M_PI_4, 3 * M_PI_2, 7 * M_PI_4, (150.0 / 180.0) * M_PI, (44 / 180.0) * M_PI, (136 / 180.0) * M_PI, (44.0 / 180.0) * M_PI, (39.0 / 180.0) * M_PI};
//__________________________________________________________________________________________________

static const NSInteger numCardsSpace        = 0;
static const NSInteger cardPosXSpace[]      = {0};
static const NSInteger cardPosYSpace[]      = {0};
static const NSInteger cardRotationsSpace[] = {0};
//____________________

static const NSInteger numCardsA            = 14;
static const NSInteger cardPosXA[]          = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightVertical, E_RightVertical, E_RightVertical , E_CenterRightHorizontal, E_CenterLeftHorizontal};
static const NSInteger cardPosYA[]          = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotBotVertical, E_CenterY             , E_CenterY              };
static const NSInteger cardRotationsA[]     = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation0     , E_Rotation90          , E_Rotation90           };
//____________________

static const NSInteger numCardsB             = 19;
static const NSInteger cardPosXB[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique , E_RightVertical, E_RightOblique    , E_RightOblique    , E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftHorizontal, E_CenterRightHorizontal, E_CenterLeftHorizontal};
static const NSInteger cardPosYB[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique   , E_TopVertical  , E_CenterTopOblique, E_CenterBotOblique, E_BotVertical  , E_BotOblique  , E_BotHorizontal       , E_BotHorizontal        , E_BotHorizontal , E_CenterY              , E_CenterY             };
static const NSInteger cardRotationsB[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation315  , E_Rotation0    , E_Rotation45      , E_Rotation315     , E_Rotation0    , E_Rotation45  , E_Rotation90          , E_Rotation90           , E_Rotation90    , E_Rotation90           , E_Rotation90          };
//____________________

static const NSInteger numCardsC             = 11;
static const NSInteger cardPosXC[]           = {E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique};
static const NSInteger cardPosYC[]           = {E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  };
static const NSInteger cardRotationsC[]      = {E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 };
//____________________

static const NSInteger numCardsD             = 15;
static const NSInteger cardPosXD[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightVertical, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftHorizontal};
static const NSInteger cardPosYD[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_BotHorizontal };
static const NSInteger cardRotationsD[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation90    };
//____________________

static const NSInteger numCardsE             = 15;
static const NSInteger cardPosXE[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal};
static const NSInteger cardPosYE[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopHorizontal  , E_CenterY             , E_CenterY              , E_BotHorizontal , E_BotHorizontal       , E_BotHorizontal        , E_BotHorizontal  };
static const NSInteger cardRotationsE[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     , E_Rotation90          , E_Rotation90           , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     };
//____________________

static const NSInteger numCardsF             = 11;
static const NSInteger cardPosXF[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal};
static const NSInteger cardPosYF[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopHorizontal  , E_CenterY             , E_CenterY              };
static const NSInteger cardRotationsF[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     , E_Rotation90          , E_Rotation90           };
//____________________

static const NSInteger numCardsG             = 13;
static const NSInteger cardPosXG[]           = {E_RightHorizontal, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique};
static const NSInteger cardPosYG[]           = {E_CenterY        , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  };
static const NSInteger cardRotationsG[]      = {E_Rotation90     , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 };
//____________________

static const NSInteger numCardsH             = 12;
static const NSInteger cardPosXH[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_RightVertical , E_RightVertical, E_RightVertical, E_RightVertical, E_RightVertical , E_CenterLeftHorizontal, E_CenterRightHorizontal};
static const NSInteger cardPosYH[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_BotBotVertical, E_BotVertical  , E_CenterY      , E_TopVertical  , E_TopTopVertical, E_CenterY             , E_CenterY              };
static const NSInteger cardRotationsH[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation0     , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation0     , E_Rotation90          , E_Rotation90           };
//____________________

static const NSInteger numCardsI             = 5;
static const NSInteger cardPosXI[]           = {E_CenterX       , E_CenterX    , E_CenterX  , E_CenterX    , E_CenterX       };
static const NSInteger cardPosYI[]           = {E_BotBotVertical, E_BotVertical, E_CenterY  , E_TopVertical, E_TopTopVertical};
static const NSInteger cardRotationsI[]      = {E_Rotation0     , E_Rotation0  , E_Rotation0, E_Rotation0  , E_Rotation0     };
//____________________

static const NSInteger numCardsJ             = 9;
static const NSInteger cardPosXJ[]           = {E_RightVertical , E_RightVertical, E_RightVertical, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique, E_LeftVertical};
static const NSInteger cardPosYJ[]           = {E_TopTopVertical, E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_BotOblique , E_BotVertical };
static const NSInteger cardRotationsJ[]      = {E_Rotation0     , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation315, E_Rotation0   };
//____________________

static const NSInteger numCardsK             = 12;
static const NSInteger cardPosXK[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_RightOblique, E_CenterRightOblique, E_CenterX         , E_CenterLeftHorizontal, E_CenterX         , E_CenterRightOblique, E_RightOblique};
static const NSInteger cardPosYK[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopOblique  , E_TopVertical       , E_CenterTopOblique, E_CenterY             , E_CenterBotOblique, E_BotVertical       , E_BotOblique  };
static const NSInteger cardRotationsK[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation45  , E_Rotation45        , E_Rotation45      , E_Rotation90          , E_Rotation315     , E_Rotation315       , E_Rotation315 };
//____________________

static const NSInteger numCardsL             = 9;
static const NSInteger cardPosXL[]           = {E_RightHorizontal, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftHorizontal, E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  };
static const NSInteger cardPosYL[]           = {E_BotHorizontal  , E_BotHorizontal        , E_BotHorizontal       , E_BotHorizontal , E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical};
static const NSInteger cardRotationsL[]      = {E_Rotation90     , E_Rotation90           , E_Rotation90          , E_Rotation90    , E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     };
//____________________

static const NSInteger numCardsM             = 14;
static const NSInteger cardPosXM[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftHorizontal, E_CenterLeftOblique, E_CenterRightOblique, E_RightHorizontal, E_RightVertical , E_RightVertical, E_RightVertical, E_RightVertical , E_CenterX    , E_CenterX  };
static const NSInteger cardPosYM[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopHorizontal , E_TopOblique       , E_TopOblique        , E_TopHorizontal  , E_TopVertical   , E_CenterY      , E_BotVertical  , E_BotBotVertical, E_TopVertical, E_CenterY  };
static const NSInteger cardRotationsM[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation90    , E_Rotation315      , E_Rotation45        , E_Rotation90     , E_Rotation0     , E_Rotation0    , E_Rotation0    , E_Rotation0     , E_Rotation0  , E_Rotation0};
//____________________

static const NSInteger numCardsN             = 15;
static const NSInteger cardPosXN[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftHorizontal, E_ExceptionNh_0, E_ExceptionNh_1, E_ExceptionNh_2, E_ExceptionNh_3, E_ExceptionNh_4, E_RightHorizontal, E_RightVertical, E_RightVertical, E_RightVertical, E_RightVertical };
static const NSInteger cardPosYN[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopHorizontal , E_ExceptionNv_0, E_ExceptionNv_1, E_ExceptionNv_2, E_ExceptionNv_3, E_ExceptionNv_4, E_BotHorizontal  , E_BotVertical  , E_CenterY      , E_TopVertical  , E_TopTopVertical};
static const NSInteger cardRotationsN[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation90    , E_ExceptionNr  , E_ExceptionNr  , E_ExceptionNr  , E_ExceptionNr  , E_ExceptionNr  , E_Rotation90     , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation0     };
//____________________

static const NSInteger numCardsO             = 14;
static const NSInteger cardPosXO[]           = {E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightVertical, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal};
static const NSInteger cardPosYO[]           = {E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       };
static const NSInteger cardRotationsO[]      = {E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          };
//____________________

static const NSInteger numCardsP             = 13;
static const NSInteger cardPosXP[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique , E_RightVertical, E_RightOblique    , E_CenterRightHorizontal, E_CenterLeftHorizontal};
static const NSInteger cardPosYP[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique   , E_TopVertical  , E_CenterTopOblique, E_CenterY              , E_CenterY             };
static const NSInteger cardRotationsP[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation315  , E_Rotation0    , E_Rotation45      , E_Rotation90           , E_Rotation90          };
//____________________

static const NSInteger numCardsQ             = 15;
static const NSInteger cardPosXQ[]           = {E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightVertical   , E_RightOblique    , E_CenterRightOblique, E_CenterX   , E_CenterLeftHorizontal, E_RightOblique};
static const NSInteger cardPosYQ[]           = {E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterTopOblique, E_CenterBotOblique, E_BotVertical       , E_BotOblique, E_BotHorizontal       , E_BotOblique  };
static const NSInteger cardRotationsQ[]      = {E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation0       , E_Rotation45      , E_Rotation45        , E_Rotation45, E_Rotation90          , E_Rotation315 };
//____________________

static const NSInteger numCardsR             = 16;
static const NSInteger cardPosXR[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique , E_RightVertical, E_RightOblique    , E_RightOblique    , E_RightVertical, E_RightVertical , E_CenterRightHorizontal, E_CenterLeftHorizontal};
static const NSInteger cardPosYR[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique   , E_TopVertical  , E_CenterTopOblique, E_CenterBotOblique, E_BotVertical  , E_BotBotVertical, E_CenterY              , E_CenterY             };
static const NSInteger cardRotationsR[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation315  , E_Rotation0    , E_Rotation45      , E_Rotation315     , E_Rotation0    , E_Rotation0     , E_Rotation90           , E_Rotation90          };
//____________________

static const NSInteger numCardsS             = 14;
static const NSInteger cardPosXS[]           = {E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightOblique    , E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique     , E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique};
static const NSInteger cardPosYS[]           = {E_BotOblique , E_BotHorizontal       , E_BotHorizontal        , E_BotOblique  , E_BotVertical  , E_CenterBotOblique, E_CenterY              , E_CenterY             , E_CenterTopOblique, E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  };
static const NSInteger cardRotationsS[]      = {E_Rotation315, E_Rotation90          , E_Rotation90           , E_Rotation45  , E_Rotation0    , E_Rotation315     , E_Rotation90           , E_Rotation90          , E_Rotation315     , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 };
//____________________

static const NSInteger numCardsT             = 8;
static const NSInteger cardPosXT[]           = {E_CenterX       , E_CenterX    , E_CenterX  , E_CenterX    , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal};
static const NSInteger cardPosYT[]           = {E_BotBotVertical, E_BotVertical, E_CenterY  , E_TopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopHorizontal  };
static const NSInteger cardRotationsT[]      = {E_Rotation0     , E_Rotation0  , E_Rotation0, E_Rotation0  , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     };
//____________________

static const NSInteger numCardsU             = 12;
static const NSInteger cardPosXU[]           = {E_RightVertical , E_RightVertical, E_RightVertical, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical };
static const NSInteger cardPosYU[]           = {E_TopTopVertical, E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical};
static const NSInteger cardRotationsU[]      = {E_Rotation0     , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     };
//____________________

static const NSInteger numCardsV             = 12;
static const NSInteger cardPosXV[]           = {E_RightVertical , E_RightVertical, E_RightVertical   , E_RightOblique    , E_CenterRightOblique, E_CenterX       , E_CenterX       , E_CenterLeftOblique, E_LeftOblique     , E_LeftVertical    , E_LeftVertical, E_LeftVertical  };
static const NSInteger cardPosYV[]           = {E_TopTopVertical, E_TopVertical  , E_CenterTopOblique, E_CenterBotOblique, E_BotVertical       , E_BotBotVertical, E_BotBotVertical, E_BotVertical      , E_CenterBotOblique, E_CenterTopOblique, E_TopVertical , E_TopTopVertical};
static const NSInteger cardRotationsV[]      = {E_Rotation0     , E_Rotation0    , E_Rotation0       , E_Rotation45      , E_Rotation45        , E_Rotation0     , E_Rotation0     , E_Rotation315      , E_Rotation315     , E_Rotation0       , E_Rotation0   , E_Rotation0     };
//____________________

static const NSInteger numCardsW             = 14;
static const NSInteger cardPosXW[]           = {E_RightVertical , E_RightVertical, E_RightVertical, E_RightVertical, E_RightHorizontal, E_CenterRightOblique, E_CenterX    , E_CenterX  , E_CenterLeftOblique, E_LeftHorizontal, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  };
static const NSInteger cardPosYW[]           = {E_TopTopVertical, E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotHorizontal  , E_BotOblique        , E_BotVertical, E_CenterY  , E_BotOblique       , E_BotHorizontal , E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical};
static const NSInteger cardRotationsW[]      = {E_Rotation0     , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation90     , E_Rotation315       , E_Rotation0  , E_Rotation0, E_Rotation45       , E_Rotation90    , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     };
//____________________

static const NSInteger numCardsX             = 10;
static const NSInteger cardPosXX[]           = {E_ExceptionXh_0, E_ExceptionXh_1, E_ExceptionXh_2, E_ExceptionXh_3, E_ExceptionXh_4, E_ExceptionXh_4, E_ExceptionXh_3, E_ExceptionXh_2, E_ExceptionXh_1, E_ExceptionXh_0};
static const NSInteger cardPosYX[]           = {E_ExceptionXv_0, E_ExceptionXv_1, E_ExceptionXv_2, E_ExceptionXv_3, E_ExceptionXv_4, E_ExceptionXv_0, E_ExceptionXv_1, E_ExceptionXv_2, E_ExceptionXv_3, E_ExceptionXv_4};
static const NSInteger cardRotationsX[]      = {E_ExceptionXr1 , E_ExceptionXr1 , E_ExceptionXr1 , E_ExceptionXr1 , E_ExceptionXr1 , E_ExceptionXr2 , E_ExceptionXr2 , E_ExceptionXr2 , E_ExceptionXr2 , E_ExceptionXr2 };
//____________________

static const NSInteger numCardsY             = 10;
static const NSInteger cardPosXY[]           = {E_CenterX       , E_CenterX    , E_LeftOblique     , E_LeftVertical, E_LeftVertical  , E_RightOblique    , E_RightVertical, E_RightVertical , E_CenterLeftHorizontal, E_CenterRightHorizontal};
static const NSInteger cardPosYY[]           = {E_BotBotVertical, E_BotVertical, E_CenterTopOblique, E_TopVertical , E_TopTopVertical, E_CenterTopOblique, E_TopVertical  , E_TopTopVertical, E_CenterY             , E_CenterY              };
static const NSInteger cardRotationsY[]      = {E_Rotation0     , E_Rotation0  , E_Rotation315     , E_Rotation0   , E_Rotation0     , E_Rotation45      , E_Rotation0    , E_Rotation0     , E_Rotation90          , E_Rotation90           };
//____________________

static const NSInteger numCardsZ             = 13;
static const NSInteger cardPosXZ[]           = {E_RightHorizontal, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftHorizontal, E_ExceptionZh_0, E_ExceptionZh_1, E_ExceptionZh_2, E_ExceptionZh_3, E_ExceptionZh_4, E_RightHorizontal, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftHorizontal};
static const NSInteger cardPosYZ[]           = {E_BotHorizontal  , E_BotHorizontal        , E_BotHorizontal       , E_BotHorizontal , E_ExceptionZv_0, E_ExceptionZv_1, E_ExceptionZv_2, E_ExceptionZv_3, E_ExceptionZv_4, E_TopHorizontal  , E_TopHorizontal        , E_TopHorizontal       , E_TopHorizontal };
static const NSInteger cardRotationsZ[]      = {E_Rotation90     , E_Rotation90           , E_Rotation90          , E_Rotation90    , E_ExceptionZr  , E_ExceptionZr  , E_ExceptionZr  , E_ExceptionZr  , E_ExceptionZr  , E_Rotation90     , E_Rotation90           , E_Rotation90          , E_Rotation90    };
//____________________

static const NSInteger numCardsExcla         = 4;
static const NSInteger cardPosXExcla[]       = {E_CenterX      , E_CenterX  , E_CenterX    , E_CenterX       };
static const NSInteger cardPosYExcla[]       = {E_BotHorizontal, E_CenterY  , E_TopVertical, E_TopTopVertical};
static const NSInteger cardRotationsExcla[]  = {E_Rotation90   , E_Rotation0, E_Rotation0  , E_Rotation0     };
//____________________

static const NSInteger numCardsQuest         = 8;
static const NSInteger cardPosXQuest[]       = {E_CenterX      , E_CenterRightHorizontal, E_RightOblique    , E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique};
static const NSInteger cardPosYQuest[]       = {E_BotHorizontal, E_CenterY              , E_CenterTopOblique, E_TopVertical  , E_TopOblique  , E_TopHorizontal        , E_TopHorizontal       , E_TopOblique};
static const NSInteger cardRotationsQuest[]  = {E_Rotation90   , E_Rotation90           , E_Rotation45      , E_Rotation0    , E_Rotation315 , E_Rotation90           , E_Rotation90          , E_Rotation45};
//____________________

static const NSInteger numCards0             = 17;
static const NSInteger cardPosX0[]           = {E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightVertical, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_CenterLeftOblique, E_CenterX    , E_CenterRightOblique};
static const NSInteger cardPosY0[]           = {E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_ExceptionNv_3    , E_CenterY    , E_ExceptionNv_1     };
static const NSInteger cardRotations0[]      = {E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Exception0r      , E_Exception0r, E_Exception0r       };
//____________________

static const NSInteger numCards1             = 8;
static const NSInteger cardPosX1[]           = {E_ExceptionNh_0, E_CenterX      , E_ExceptionNh_4, E_CenterX    , E_CenterX  , E_CenterX    , E_CenterX       , E_CenterLeftOblique};
static const NSInteger cardPosY1[]           = {E_BotHorizontal, E_BotHorizontal, E_BotHorizontal, E_BotVertical, E_CenterY  , E_TopVertical, E_TopTopVertical, E_TopOblique       };
static const NSInteger cardRotations1[]      = {E_Rotation90   , E_Rotation90   , E_Rotation90   , E_Rotation0  , E_Rotation0, E_Rotation0  , E_Rotation0     , E_Rotation45       };
//____________________

static const NSInteger numCards2             = 15;
static const NSInteger cardPosX2[]           = {E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightOblique    , E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique     , E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal};
static const NSInteger cardPosY2[]           = {E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterTopOblique, E_CenterY              , E_CenterY             , E_CenterBotOblique, E_BotVertical , E_BotBotVertical, E_BotHorizontal , E_BotHorizontal       , E_BotHorizontal        , E_BotHorizontal  };
static const NSInteger cardRotations2[]      = {E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation45      , E_Rotation90           , E_Rotation90          , E_Rotation45      , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     };
//____________________

static const NSInteger numCards3             = 13;
static const NSInteger cardPosX3[]           = {E_RightOblique, E_RightVertical, E_RightOblique    , E_RightOblique    , E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique, E_CenterRightHorizontal, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique};
static const NSInteger cardPosY3[]           = {E_BotOblique  , E_BotVertical  , E_CenterBotOblique, E_CenterTopOblique, E_TopVertical  , E_TopOblique  , E_TopHorizontal        , E_TopHorizontal       , E_TopOblique , E_CenterY              , E_BotHorizontal        , E_BotHorizontal       , E_BotOblique };
static const NSInteger cardRotations3[]      = {E_Rotation45  , E_Rotation0    , E_Rotation315     , E_Rotation45      , E_Rotation0    , E_Rotation315 , E_Rotation90           , E_Rotation90          , E_Rotation45 , E_Rotation90           , E_Rotation90           , E_Rotation90          , E_Rotation315};
//____________________

static const NSInteger numCards4             = 10;
static const NSInteger cardPosX4[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical    , E_LeftHorizontal  , E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal , E_CenterX       , E_CenterX    , E_CenterX  };
static const NSInteger cardPosY4[]           = {E_TopTopVertical, E_TopVertical , E_CenterTopOblique, E_CenterBotOblique, E_CenterBotOblique    , E_CenterBotOblique     , E_CenterBotOblique, E_BotBotVertical, E_BotVertical, E_CenterY  };
static const NSInteger cardRotations4[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0       , E_Rotation90      , E_Rotation90          , E_Rotation90           , E_Rotation90      , E_Rotation0     , E_Rotation0  , E_Rotation0};
//____________________

static const NSInteger numCards5             = 15;
static const NSInteger cardPosX5[]           = {E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightOblique    , E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique     , E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal};
static const NSInteger cardPosY5[]           = {E_BotOblique , E_BotHorizontal       , E_BotHorizontal        , E_BotOblique  , E_BotVertical  , E_CenterBotOblique, E_CenterY              , E_CenterY             , E_CenterTopOblique, E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopHorizontal  };
static const NSInteger cardRotations5[]      = {E_Rotation315, E_Rotation90          , E_Rotation90           , E_Rotation45  , E_Rotation0    , E_Rotation315     , E_Rotation90           , E_Rotation90          , E_Rotation315     , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     };
//____________________

static const NSInteger numCards6             = 15;
static const NSInteger cardPosX6[]           = {E_RightOblique, E_RightOblique    , E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_CenterRightHorizontal, E_CenterLeftHorizontal};
static const NSInteger cardPosY6[]           = {E_TopOblique  , E_CenterBotOblique, E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_CenterY              , E_CenterY             };
static const NSInteger cardRotations6[]      = {E_Rotation315 , E_Rotation315     , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation90           , E_Rotation90          };
//____________________

static const NSInteger numCards7             = 11;
static const NSInteger cardPosX7[]           = {E_Exception7h, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftHorizontal, E_RightOblique, E_CenterRightOblique, E_CenterX    , E_CenterLeftOblique, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal};
static const NSInteger cardPosY7[]           = {E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopHorizontal  , E_TopOblique  , E_ExceptionNv_1     , E_CenterY    , E_ExceptionNv_3    , E_BotOblique , E_CenterY             , E_CenterY              };
static const NSInteger cardRotations7[]      = {E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     , E_Exception0r , E_Exception0r       , E_Exception0r, E_Exception0r      , E_Exception0r, E_Rotation90          , E_Rotation90           };
//____________________

static const NSInteger numCards8             = 18;
static const NSInteger cardPosX8[]           = {E_LeftOblique, E_LeftVertical, E_LeftOblique     , E_LeftOblique     , E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightOblique    , E_RightOblique    , E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal};
static const NSInteger cardPosY8[]           = {E_BotOblique , E_BotVertical , E_CenterBotOblique, E_CenterTopOblique, E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterTopOblique, E_CenterBotOblique, E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_CenterY             , E_CenterY              };
static const NSInteger cardRotations8[]      = {E_Rotation315, E_Rotation0   , E_Rotation45      , E_Rotation315     , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation45      , E_Rotation315     , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation90          , E_Rotation90           };
//____________________

static const NSInteger numCards9             = 15;
static const NSInteger cardPosX9[]           = {E_LeftOblique, E_LeftOblique     , E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightVertical, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal};
static const NSInteger cardPosY9[]           = {E_BotOblique , E_CenterTopOblique, E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_CenterY             , E_CenterY              };
static const NSInteger cardRotations9[]      = {E_Rotation315, E_Rotation315     , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation90          , E_Rotation90           };
//____________________

//__________________________________________________________________________________________________

//! The base letter class.
@interface CardLetter()
{
}
@end
//__________________________________________________________________________________________________

@implementation Letter
{
@public
  const NSInteger*  CardRotations;  //!< A C array of rotation indexes of the cards composing this letter.
}
//____________________

- (instancetype)init;
{
  self = [super init];
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^
  {
    CGFloat lrhcx   = 0.5 * (_cardHeight * sin(M_PI_4) + _cardWidth * cos(M_PI_4)) - 1; // Long rotated "half card".
    CGFloat srhcx   = 0.5 * (_cardHeight * sin(M_PI_4) - _cardWidth * cos(M_PI_4)) + 3; // Short rotated "half card".
    CGFloat lrhcy   = 0.5 * (_cardHeight * sin(M_PI_4) + _cardWidth * cos(M_PI_4)) - 1; // Long rotated "half card".
    CGFloat srhcy   = 0.5 * (_cardHeight * sin(M_PI_4) - _cardWidth * cos(M_PI_4)) - 2; // Short rotated "half card".
    CGFloat hch     = 0.5 * (_cardHeight);                                              // Half card height.
    CGFloat hcw     = 0.5 * (_cardWidth );                                              // Half card width.

    CGFloat cosNr   = cos(M_PI - Rotations[E_ExceptionNr]);
    CGFloat sinNr   = sin(M_PI - Rotations[E_ExceptionNr]);
//    CGFloat lrhcxn  = 0.5 * (_cardHeight * sinNr + _cardWidth * cosNr);     // Long rotated "half card".
    CGFloat srhcxn  = 0.5 * (_cardHeight * sinNr - _cardWidth * cosNr) - 1; // Short rotated "half card".
    CGFloat lrhcyn  = 0.5 * (_cardHeight * sinNr + _cardWidth * cosNr) + 1; // Long rotated "half card".
//    CGFloat srhcyn  = 0.5 * (_cardHeight * sinNr - _cardWidth * cosNr);     // Short rotated "half card".

    CGFloat cosXr   = cos(Rotations[E_ExceptionXr1]);
    CGFloat sinXr   = sin(Rotations[E_ExceptionXr1]);
    CGFloat lrhcxx  = 0.5 * (_cardHeight * sinXr + _cardWidth * cosXr) - 1;     // Long rotated "half card".
//    CGFloat srhcxx  = 0.5 * (_cardHeight * sinXr - _cardWidth * cosXr) - 1;     // Short rotated "half card".
//    CGFloat lrhcyx  = 0.5 * (_cardHeight * sinXr + _cardWidth * cosXr) + 1;     // Long rotated "half card".
//    CGFloat srhcyx  = 0.5 * (_cardHeight * sinXr - _cardWidth * cosXr);// - 2;  // Short rotated "half card".

    CGFloat cosZr   = cos(Rotations[E_ExceptionZr]);
    CGFloat sinZr   = sin(Rotations[E_ExceptionZr]);
    CGFloat lrhcxz  = 0.5 * (_cardHeight * sinZr + _cardWidth * cosZr) - 1;     // Long rotated "half card".
//    CGFloat srhcxz  = 0.5 * (_cardHeight * sinZr - _cardWidth * cosZr) - 1;     // Short rotated "half card".
//    CGFloat lrhcyz  = 0.5 * (_cardHeight * sinZr + _cardWidth * cosZr) + 1;     // Long rotated "half card".
//    CGFloat srhcyz  = 0.5 * (_cardHeight * sinZr - _cardWidth * cosZr);// - 2;  // Short rotated "half card".

    PositionsX = malloc(sizeof(CGFloat) * NumHCards);
    PositionsX[E_LeftBorder           ] = 0;
    PositionsX[E_LeftVertical         ] = hcw;
    PositionsX[E_LeftHorizontal       ] = hch;
    PositionsX[E_LeftOblique          ] = lrhcx;
    PositionsX[E_CenterLeftOblique    ] = _cardHeight + srhcx;
    PositionsX[E_CenterLeftHorizontal ] = PositionsX[E_LeftOblique      ] + srhcx + hch;
    PositionsX[E_CenterX              ] = PositionsX[E_CenterLeftOblique] + srhcx + hcw;
    PositionsX[E_RightBorder          ] = PositionsX[E_CenterX          ] * 2;
    PositionsX[E_RightVertical        ] = PositionsX[E_RightBorder      ] - PositionsX[E_LeftVertical];
    PositionsX[E_RightHorizontal      ] = PositionsX[E_RightBorder      ] - PositionsX[E_LeftHorizontal];
    PositionsX[E_RightOblique         ] = PositionsX[E_RightBorder      ] - PositionsX[E_LeftOblique];
    PositionsX[E_CenterRightOblique   ] = PositionsX[E_RightBorder      ] - PositionsX[E_CenterLeftOblique];
    PositionsX[E_CenterRightHorizontal] = PositionsX[E_RightBorder      ] - PositionsX[E_CenterLeftHorizontal];
    PositionsX[E_ExceptionNh_0        ] = _cardHeight + srhcxn;
    PositionsX[E_ExceptionNh_4        ] = PositionsX[E_RightBorder      ] - PositionsX[E_ExceptionNh_0];
    PositionsX[E_ExceptionNh_1        ] = PositionsX[E_ExceptionNh_0    ] + (PositionsX[E_ExceptionNh_4] - PositionsX[E_ExceptionNh_0]) * 1 / 4;
    PositionsX[E_ExceptionNh_2        ] = PositionsX[E_ExceptionNh_0    ] + (PositionsX[E_ExceptionNh_4] - PositionsX[E_ExceptionNh_0]) * 2 / 4;
    PositionsX[E_ExceptionNh_3        ] = PositionsX[E_ExceptionNh_0    ] + (PositionsX[E_ExceptionNh_4] - PositionsX[E_ExceptionNh_0]) * 3 / 4;
    PositionsX[E_ExceptionXh_0        ] = lrhcxx;
    PositionsX[E_ExceptionXh_4        ] = PositionsX[E_RightBorder      ] - PositionsX[E_ExceptionXh_0];
    PositionsX[E_ExceptionXh_1        ] = PositionsX[E_ExceptionXh_0    ] + (PositionsX[E_ExceptionXh_4] - PositionsX[E_ExceptionXh_0]) * 1 / 4;
    PositionsX[E_ExceptionXh_2        ] = PositionsX[E_ExceptionXh_0    ] + (PositionsX[E_ExceptionXh_4] - PositionsX[E_ExceptionXh_0]) * 2 / 4;
    PositionsX[E_ExceptionXh_3        ] = PositionsX[E_ExceptionXh_0    ] + (PositionsX[E_ExceptionXh_4] - PositionsX[E_ExceptionXh_0]) * 3 / 4;
    PositionsX[E_ExceptionZh_0        ] = lrhcxz;
    PositionsX[E_ExceptionZh_4        ] = PositionsX[E_RightBorder      ] - PositionsX[E_ExceptionZh_0];
    PositionsX[E_ExceptionZh_1        ] = PositionsX[E_ExceptionZh_0    ] + (PositionsX[E_ExceptionZh_4] - PositionsX[E_ExceptionZh_0]) * 1 / 4;
    PositionsX[E_ExceptionZh_2        ] = PositionsX[E_ExceptionZh_0    ] + (PositionsX[E_ExceptionZh_4] - PositionsX[E_ExceptionZh_0]) * 2 / 4;
    PositionsX[E_ExceptionZh_3        ] = PositionsX[E_ExceptionZh_0    ] + (PositionsX[E_ExceptionZh_4] - PositionsX[E_ExceptionZh_0]) * 3 / 4;
    PositionsX[E_Exception7h          ] = PositionsX[E_RightBorder      ] - _cardHeight;

    PositionsY = malloc(sizeof(CGFloat) * NumVCards);

    PositionsY[E_TopBorder       ] = 0;
    PositionsY[E_TopHorizontal   ] = hcw;
    PositionsY[E_TopTopVertical  ] = hch;
    PositionsY[E_TopOblique      ] = lrhcy;
    PositionsY[E_TopVertical     ] = PositionsY[E_TopOblique      ] + srhcy + hch;
    PositionsY[E_CenterTopOblique] = PositionsY[E_TopVertical     ] + hch  + srhcy;
    PositionsY[E_CenterY         ] = PositionsY[E_CenterTopOblique] + lrhcy - hcw;
    PositionsY[E_BottomBorder    ] = PositionsY[E_CenterY         ] * 2;
    PositionsY[E_BotHorizontal   ] = PositionsY[E_BottomBorder    ] - PositionsY[E_TopHorizontal];
    PositionsY[E_BotBotVertical  ] = PositionsY[E_BottomBorder    ] - PositionsY[E_TopTopVertical];
    PositionsY[E_BotOblique      ] = PositionsY[E_BottomBorder    ] - PositionsY[E_TopOblique];
    PositionsY[E_BotVertical     ] = PositionsY[E_BottomBorder    ] - PositionsY[E_TopVertical];
    PositionsY[E_CenterBotOblique] = PositionsY[E_BottomBorder    ] - PositionsY[E_CenterTopOblique];
    PositionsY[E_ExceptionNv_0   ] = lrhcyn;
    PositionsY[E_ExceptionNv_4   ] = PositionsY[E_RightBorder     ] - PositionsY[E_ExceptionNv_0];
    PositionsY[E_ExceptionNv_1   ] = PositionsY[E_ExceptionNv_0   ] + (PositionsY[E_ExceptionNv_4  ] - PositionsY[E_ExceptionNv_0]) * 1 / 4;
    PositionsY[E_ExceptionNv_2   ] = PositionsY[E_ExceptionNv_0   ] + (PositionsY[E_ExceptionNv_4  ] - PositionsY[E_ExceptionNv_0]) * 2 / 4;
    PositionsY[E_ExceptionNv_3   ] = PositionsY[E_ExceptionNv_0   ] + (PositionsY[E_ExceptionNv_4  ] - PositionsY[E_ExceptionNv_0]) * 3 / 4;
    PositionsY[E_ExceptionXv_4   ] = _cardWidth + 2;
    PositionsY[E_ExceptionXv_0   ] = PositionsY[E_RightBorder     ] - PositionsY[E_ExceptionXv_4];
    PositionsY[E_ExceptionXv_1   ] = PositionsY[E_ExceptionXv_0   ] + (PositionsY[E_ExceptionXv_4] - PositionsY[E_ExceptionXv_0]) * 1 / 4;
    PositionsY[E_ExceptionXv_2   ] = PositionsY[E_ExceptionXv_0   ] + (PositionsY[E_ExceptionXv_4] - PositionsY[E_ExceptionXv_0]) * 2 / 4;
    PositionsY[E_ExceptionXv_3   ] = PositionsY[E_ExceptionXv_0   ] + (PositionsY[E_ExceptionXv_4] - PositionsY[E_ExceptionXv_0]) * 3 / 4;
    PositionsY[E_ExceptionZv_4   ] = _cardWidth + 2;
    PositionsY[E_ExceptionZv_0   ] = PositionsY[E_RightBorder     ] - PositionsY[E_ExceptionZv_4];
    PositionsY[E_ExceptionZv_1   ] = PositionsY[E_ExceptionZv_0   ] + (PositionsY[E_ExceptionZv_4] - PositionsY[E_ExceptionZv_0]) * 1 / 4;
    PositionsY[E_ExceptionZv_2   ] = PositionsY[E_ExceptionZv_0   ] + (PositionsY[E_ExceptionZv_4] - PositionsY[E_ExceptionZv_0]) * 2 / 4;
    PositionsY[E_ExceptionZv_3   ] = PositionsY[E_ExceptionZv_0   ] + (PositionsY[E_ExceptionZv_4] - PositionsY[E_ExceptionZv_0]) * 3 / 4;
  });
  return self;
}
//__________________________________________________________________________________________________

- (CGFloat)cardPositionXForIndex:(NSInteger)index
{
  if (index < NumCards)
  {
    return PositionsX[CardPosX[index]];
  }
  return 0;
}
//__________________________________________________________________________________________________

- (CGFloat)cardPositionYForIndex:(NSInteger)index
{
  if (index < NumCards)
  {
    return -PositionsY[CardPosY[index]];
  }
  return 0;
}
//__________________________________________________________________________________________________

- (CGFloat)cardRotationForIndex:(NSInteger)index
{
  if (index < NumCards)
  {
    return Rotations[CardRotations[index]];
  }
  return 0;
}
//__________________________________________________________________________________________________

@end
//==================================================================================================

//! The base letter class.
@interface CardLetter()
{
}
@end
//__________________________________________________________________________________________________

@implementation CardLetter
{
}
//____________________

- (instancetype)initWithLetter:(Letter*)letter;
{
  self = [super init];
  if (self != nil)
  {
      if(letter==nil)
          letter = [[Letter alloc] init];
      
    NumCards      = letter->NumCards;
    CardPosX      = letter->CardPosX;
    CardPosY      = letter->CardPosY;
    CardRotations = letter->CardRotations;
  }
  return self;
}
//__________________________________________________________________________________________________

@end
//==================================================================================================

//! A whole alphabet of letters.
@interface CardAlphabet()
{
}
@end
//__________________________________________________________________________________________________

@implementation CardAlphabet
{
  NSArray*  Cards;    //!< The array of cards composing this letter.
}
//____________________

- (instancetype)init;
{
  self = [super init];
  if (self != nil)
  {
    CardLetter* letter;
    Letters = [NSMutableDictionary dictionaryWithCapacity:38];
    // Creates Space charater.
    letter = [CardLetter new];
    letter->NumCards = numCardsSpace;
    letter->CardPosX = cardPosXSpace;
    letter->CardPosY = cardPosYSpace;
    letter->CardRotations = cardRotationsSpace;
    [Letters setObject:letter forKey:@" "];

    // Creates Letter A.
    letter = [CardLetter new];
    letter->NumCards = numCardsA;
    letter->CardPosX = cardPosXA;
    letter->CardPosY = cardPosYA;
    letter->CardRotations = cardRotationsA;
    [Letters setObject:letter forKey:@"A"];

    // Creates Letter B.
    letter = [CardLetter new];
    letter->NumCards = numCardsB;
    letter->CardPosX = cardPosXB;
    letter->CardPosY = cardPosYB;
    letter->CardRotations = cardRotationsB;
    [Letters setObject:letter forKey:@"B"];

    // Creates Letter C.
    letter = [CardLetter new];
    letter->NumCards = numCardsC;
    letter->CardPosX = cardPosXC;
    letter->CardPosY = cardPosYC;
    letter->CardRotations = cardRotationsC;
    [Letters setObject:letter forKey:@"C"];

    // Creates Letter D.
    letter = [CardLetter new];
    letter->NumCards = numCardsD;
    letter->CardPosX = cardPosXD;
    letter->CardPosY = cardPosYD;
    letter->CardRotations = cardRotationsD;
    [Letters setObject:letter forKey:@"D"];

    // Creates Letter E.
    letter = [CardLetter new];
    letter->NumCards = numCardsE;
    letter->CardPosX = cardPosXE;
    letter->CardPosY = cardPosYE;
    letter->CardRotations = cardRotationsE;
    [Letters setObject:letter forKey:@"E"];

    // Creates Letter F.
    letter = [CardLetter new];
    letter->NumCards = numCardsF;
    letter->CardPosX = cardPosXF;
    letter->CardPosY = cardPosYF;
    letter->CardRotations = cardRotationsF;
    [Letters setObject:letter forKey:@"F"];

    // Creates Letter G.
    letter = [CardLetter new];
    letter->NumCards = numCardsG;
    letter->CardPosX = cardPosXG;
    letter->CardPosY = cardPosYG;
    letter->CardRotations = cardRotationsG;
    [Letters setObject:letter forKey:@"G"];

    // Creates Letter H.
    letter = [CardLetter new];
    letter->NumCards = numCardsH;
    letter->CardPosX = cardPosXH;
    letter->CardPosY = cardPosYH;
    letter->CardRotations = cardRotationsH;
    [Letters setObject:letter forKey:@"H"];

    // Creates Letter I.
    letter = [CardLetter new];
    letter->NumCards = numCardsI;
    letter->CardPosX = cardPosXI;
    letter->CardPosY = cardPosYI;
    letter->CardRotations = cardRotationsI;
    [Letters setObject:letter forKey:@"I"];

    // Creates Letter J.
    letter = [CardLetter new];
    letter->NumCards = numCardsJ;
    letter->CardPosX = cardPosXJ;
    letter->CardPosY = cardPosYJ;
    letter->CardRotations = cardRotationsJ;
    [Letters setObject:letter forKey:@"J"];

    // Creates Letter K.
    letter = [CardLetter new];
    letter->NumCards = numCardsK;
    letter->CardPosX = cardPosXK;
    letter->CardPosY = cardPosYK;
    letter->CardRotations = cardRotationsK;
    [Letters setObject:letter forKey:@"K"];

    // Creates Letter L.
    letter = [CardLetter new];
    letter->NumCards = numCardsL;
    letter->CardPosX = cardPosXL;
    letter->CardPosY = cardPosYL;
    letter->CardRotations = cardRotationsL;
    [Letters setObject:letter forKey:@"L"];

    // Creates Letter M.
    letter = [CardLetter new];
    letter->NumCards = numCardsM;
    letter->CardPosX = cardPosXM;
    letter->CardPosY = cardPosYM;
    letter->CardRotations = cardRotationsM;
    [Letters setObject:letter forKey:@"M"];

    // Creates Letter N.
    letter = [CardLetter new];
    letter->NumCards = numCardsN;
    letter->CardPosX = cardPosXN;
    letter->CardPosY = cardPosYN;
    letter->CardRotations = cardRotationsN;
    [Letters setObject:letter forKey:@"N"];

    // Creates Letter O.
    letter = [CardLetter new];
    letter->NumCards = numCardsO;
    letter->CardPosX = cardPosXO;
    letter->CardPosY = cardPosYO;
    letter->CardRotations = cardRotationsO;
    [Letters setObject:letter forKey:@"O"];

    // Creates Letter P.
    letter = [CardLetter new];
    letter->NumCards = numCardsP;
    letter->CardPosX = cardPosXP;
    letter->CardPosY = cardPosYP;
    letter->CardRotations = cardRotationsP;
    [Letters setObject:letter forKey:@"P"];

    // Creates Letter Q.
    letter = [CardLetter new];
    letter->NumCards = numCardsQ;
    letter->CardPosX = cardPosXQ;
    letter->CardPosY = cardPosYQ;
    letter->CardRotations = cardRotationsQ;
    [Letters setObject:letter forKey:@"Q"];

    // Creates Letter R.
    letter = [CardLetter new];
    letter->NumCards = numCardsR;
    letter->CardPosX = cardPosXR;
    letter->CardPosY = cardPosYR;
    letter->CardRotations = cardRotationsR;
    [Letters setObject:letter forKey:@"R"];

    // Creates Letter S.
    letter = [CardLetter new];
    letter->NumCards = numCardsS;
    letter->CardPosX = cardPosXS;
    letter->CardPosY = cardPosYS;
    letter->CardRotations = cardRotationsS;
    [Letters setObject:letter forKey:@"S"];

    // Creates Letter T.
    letter = [CardLetter new];
    letter->NumCards = numCardsT;
    letter->CardPosX = cardPosXT;
    letter->CardPosY = cardPosYT;
    letter->CardRotations = cardRotationsT;
    [Letters setObject:letter forKey:@"T"];

    // Creates Letter U.
    letter = [CardLetter new];
    letter->NumCards = numCardsU;
    letter->CardPosX = cardPosXU;
    letter->CardPosY = cardPosYU;
    letter->CardRotations = cardRotationsU;
    [Letters setObject:letter forKey:@"U"];

    // Creates Letter V.
    letter = [CardLetter new];
    letter->NumCards = numCardsV;
    letter->CardPosX = cardPosXV;
    letter->CardPosY = cardPosYV;
    letter->CardRotations = cardRotationsV;
    [Letters setObject:letter forKey:@"V"];

    // Creates Letter W.
    letter = [CardLetter new];
    letter->NumCards = numCardsW;
    letter->CardPosX = cardPosXW;
    letter->CardPosY = cardPosYW;
    letter->CardRotations = cardRotationsW;
    [Letters setObject:letter forKey:@"W"];

    // Creates Letter X.
    letter = [CardLetter new];
    letter->NumCards = numCardsX;
    letter->CardPosX = cardPosXX;
    letter->CardPosY = cardPosYX;
    letter->CardRotations = cardRotationsX;
    [Letters setObject:letter forKey:@"X"];

    // Creates Letter Y.
    letter = [CardLetter new];
    letter->NumCards = numCardsY;
    letter->CardPosX = cardPosXY;
    letter->CardPosY = cardPosYY;
    letter->CardRotations = cardRotationsY;
    [Letters setObject:letter forKey:@"Y"];

    // Creates Letter Z.
    letter = [CardLetter new];
    letter->NumCards = numCardsZ;
    letter->CardPosX = cardPosXZ;
    letter->CardPosY = cardPosYZ;
    letter->CardRotations = cardRotationsZ;
    [Letters setObject:letter forKey:@"Z"];

    // Creates Letter !.
    letter = [CardLetter new];
    letter->NumCards = numCardsExcla;
    letter->CardPosX = cardPosXExcla;
    letter->CardPosY = cardPosYExcla;
    letter->CardRotations = cardRotationsExcla;
    [Letters setObject:letter forKey:@"!"];

    // Creates Letter ?.
    letter = [CardLetter new];
    letter->NumCards = numCardsQuest;
    letter->CardPosX = cardPosXQuest;
    letter->CardPosY = cardPosYQuest;
    letter->CardRotations = cardRotationsQuest;
    [Letters setObject:letter forKey:@"?"];

    // Creates Digit 0.
    letter = [CardLetter new];
    letter->NumCards = numCards0;
    letter->CardPosX = cardPosX0;
    letter->CardPosY = cardPosY0;
    letter->CardRotations = cardRotations0;
    [Letters setObject:letter forKey:@"0"];

    // Creates Digit 1.
    letter = [CardLetter new];
    letter->NumCards = numCards1;
    letter->CardPosX = cardPosX1;
    letter->CardPosY = cardPosY1;
    letter->CardRotations = cardRotations1;
    [Letters setObject:letter forKey:@"1"];

    // Creates Digit 2.
    letter = [CardLetter new];
    letter->NumCards = numCards2;
    letter->CardPosX = cardPosX2;
    letter->CardPosY = cardPosY2;
    letter->CardRotations = cardRotations2;
    [Letters setObject:letter forKey:@"2"];

    // Creates Digit 3.
    letter = [CardLetter new];
    letter->NumCards = numCards3;
    letter->CardPosX = cardPosX3;
    letter->CardPosY = cardPosY3;
    letter->CardRotations = cardRotations3;
    [Letters setObject:letter forKey:@"3"];

    // Creates Digit 4.
    letter = [CardLetter new];
    letter->NumCards = numCards4;
    letter->CardPosX = cardPosX4;
    letter->CardPosY = cardPosY4;
    letter->CardRotations = cardRotations4;
    [Letters setObject:letter forKey:@"4"];

    // Creates Digit 5.
    letter = [CardLetter new];
    letter->NumCards = numCards5;
    letter->CardPosX = cardPosX5;
    letter->CardPosY = cardPosY5;
    letter->CardRotations = cardRotations5;
    [Letters setObject:letter forKey:@"5"];

    // Creates Digit 6.
    letter = [CardLetter new];
    letter->NumCards = numCards6;
    letter->CardPosX = cardPosX6;
    letter->CardPosY = cardPosY6;
    letter->CardRotations = cardRotations6;
    [Letters setObject:letter forKey:@"6"];

    // Creates Digit 7.
    letter = [CardLetter new];
    letter->NumCards = numCards7;
    letter->CardPosX = cardPosX7;
    letter->CardPosY = cardPosY7;
    letter->CardRotations = cardRotations7;
    [Letters setObject:letter forKey:@"7"];

    // Creates Digit 8.
    letter = [CardLetter new];
    letter->NumCards = numCards8;
    letter->CardPosX = cardPosX8;
    letter->CardPosY = cardPosY8;
    letter->CardRotations = cardRotations8;
    [Letters setObject:letter forKey:@"8"];

    // Creates Digit 9.
    letter = [CardLetter new];
    letter->NumCards = numCards9;
    letter->CardPosX = cardPosX9;
    letter->CardPosY = cardPosY9;
    letter->CardRotations = cardRotations9;
    [Letters setObject:letter forKey:@"9"];

    _lettersWidth   = PositionsX[E_RightBorder];
    _lettersHeight  = PositionsY[E_BottomBorder];
  }
  return self;
}

@end
//==================================================================================================
