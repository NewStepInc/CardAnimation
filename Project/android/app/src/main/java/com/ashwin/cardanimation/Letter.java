package com.ashwin.cardanimation;

/**
 * Created by nick on 3/4/16.
 */
public class Letter {
    public int NumCards;
    public int[] CardPosX;
    public int[] CardPosY;
    public int[] CardRotations;

    public float cardPositionXForIndex(int index) {
        if (index < NumCards) {
            return PositionsX[CardPosX[index]];
        }
        return 0;
    }

    public float cardPositionYForIndex(int index) {
        if (index < NumCards) {
            return PositionsY[CardPosY[index]];
        }
        return 0;
    }

    public float cardPositionRotationForIndex(int index) {
        if (index < NumCards) {
            return Rotations[CardRotations[index]];
        }
        return 0;
    }


    public static void init(float cardWidth, float cardHeight) {
        float lrhcx   = 0.5f * (cardHeight * (float) Math.sin(M_PI_4) + cardWidth * (float) Math.cos(M_PI_4)) - 1; // Long rotated "half card".
        float srhcx   = 0.5f * (cardHeight * (float) Math.sin(M_PI_4) - cardWidth * (float) Math.cos(M_PI_4)) + 3; // Short rotated "half card".
        float lrhcy   = 0.5f * (cardHeight * (float) Math.sin(M_PI_4) + cardWidth * (float) Math.cos(M_PI_4)) - 1; // Long rotated "half card".
        float srhcy   = 0.5f * (cardHeight * (float) Math.sin(M_PI_4) - cardWidth * (float) Math.cos(M_PI_4)) - 2; // Short rotated "half card".
        float hch     = 0.5f * (cardHeight);                                              // Half card height.
        float hcw     = 0.5f * (cardWidth);                                              // Half card width.

        float cosNr   = (float) Math.cos(M_PI - Rotations[E_ExceptionNr]);
        float sinNr   = (float) Math.sin(M_PI - Rotations[E_ExceptionNr]);
//    float lrhcxn  = 0.5f * (cardHeight * sinNr + cardWidth * cosNr);     // Long rotated "half card".
        float srhcxn  = 0.5f * (cardHeight * sinNr - cardWidth * cosNr) - 1; // Short rotated "half card".
        float lrhcyn  = 0.5f * (cardHeight * sinNr + cardWidth * cosNr) + 1; // Long rotated "half card".
//    float srhcyn  = 0.5f * (cardHeight * sinNr - cardWidth * cosNr);     // Short rotated "half card".

        float cosXr   = (float) Math.cos(Rotations[E_ExceptionXr1]);
        float sinXr   = (float) Math.sin(Rotations[E_ExceptionXr1]);
        float lrhcxx  = 0.5f * (cardHeight * sinXr + cardWidth * cosXr) - 1;     // Long rotated "half card".
//    float srhcxx  = 0.5f * (cardHeight * sinXr - cardWidth * cosXr) - 1;     // Short rotated "half card".
//    float lrhcyx  = 0.5f * (cardHeight * sinXr + cardWidth * cosXr) + 1;     // Long rotated "half card".
//    float srhcyx  = 0.5f * (cardHeight * sinXr - cardWidth * cosXr);// - 2;  // Short rotated "half card".

        float cosZr   = (float) Math.cos(Rotations[E_ExceptionZr]);
        float sinZr   = (float) Math.sin(Rotations[E_ExceptionZr]);
        float lrhcxz  = 0.5f * (cardHeight * sinZr + cardWidth * cosZr) - 1;     // Long rotated "half card".
//    float srhcxz  = 0.5f * (cardHeight * sinZr - cardWidth * cosZr) - 1;     // Short rotated "half card".
//    float lrhcyz  = 0.5f * (cardHeight * sinZr + cardWidth * cosZr) + 1;     // Long rotated "half card".
//    float srhcyz  = 0.5f * (cardHeight * sinZr - cardWidth * cosZr);// - 2;  // Short rotated "half card".

        PositionsX = new float[NumHCards];
        PositionsX[E_LeftBorder           ] = 0;
        PositionsX[E_LeftVertical         ] = hcw;
        PositionsX[E_LeftHorizontal       ] = hch;
        PositionsX[E_LeftOblique          ] = lrhcx;
        PositionsX[E_CenterLeftOblique    ] = cardHeight + srhcx;
        PositionsX[E_CenterLeftHorizontal ] = PositionsX[E_LeftOblique      ] + srhcx + hch;
        PositionsX[E_CenterX              ] = PositionsX[E_CenterLeftOblique] + srhcx + hcw;
        PositionsX[E_RightBorder          ] = PositionsX[E_CenterX          ] * 2;
        PositionsX[E_RightVertical        ] = PositionsX[E_RightBorder      ] - PositionsX[E_LeftVertical];
        PositionsX[E_RightHorizontal      ] = PositionsX[E_RightBorder      ] - PositionsX[E_LeftHorizontal];
        PositionsX[E_RightOblique         ] = PositionsX[E_RightBorder      ] - PositionsX[E_LeftOblique];
        PositionsX[E_CenterRightOblique   ] = PositionsX[E_RightBorder      ] - PositionsX[E_CenterLeftOblique];
        PositionsX[E_CenterRightHorizontal] = PositionsX[E_RightBorder      ] - PositionsX[E_CenterLeftHorizontal];
        PositionsX[E_ExceptionNh_0        ] = cardHeight + srhcxn;
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
        PositionsX[E_Exception7h          ] = PositionsX[E_RightBorder      ] - cardHeight;

        PositionsY = new float[NumVCards];

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
        PositionsY[E_ExceptionXv_4   ] = cardWidth + 2;
        PositionsY[E_ExceptionXv_0   ] = PositionsY[E_RightBorder     ] - PositionsY[E_ExceptionXv_4];
        PositionsY[E_ExceptionXv_1   ] = PositionsY[E_ExceptionXv_0   ] + (PositionsY[E_ExceptionXv_4] - PositionsY[E_ExceptionXv_0]) * 1 / 4;
        PositionsY[E_ExceptionXv_2   ] = PositionsY[E_ExceptionXv_0   ] + (PositionsY[E_ExceptionXv_4] - PositionsY[E_ExceptionXv_0]) * 2 / 4;
        PositionsY[E_ExceptionXv_3   ] = PositionsY[E_ExceptionXv_0   ] + (PositionsY[E_ExceptionXv_4] - PositionsY[E_ExceptionXv_0]) * 3 / 4;
        PositionsY[E_ExceptionZv_4   ] = cardWidth + 2;
        PositionsY[E_ExceptionZv_0   ] = PositionsY[E_RightBorder     ] - PositionsY[E_ExceptionZv_4];
        PositionsY[E_ExceptionZv_1   ] = PositionsY[E_ExceptionZv_0   ] + (PositionsY[E_ExceptionZv_4] - PositionsY[E_ExceptionZv_0]) * 1 / 4;
        PositionsY[E_ExceptionZv_2   ] = PositionsY[E_ExceptionZv_0   ] + (PositionsY[E_ExceptionZv_4] - PositionsY[E_ExceptionZv_0]) * 2 / 4;
        PositionsY[E_ExceptionZv_3   ] = PositionsY[E_ExceptionZv_0   ] + (PositionsY[E_ExceptionZv_4] - PositionsY[E_ExceptionZv_0]) * 3 / 4;
    }

    public static final float M_PI = (float) Math.PI;
    public static final float M_PI_2 = M_PI / 2;
    public static final float M_PI_4 = M_PI / 4;
    //    public class HorizontalPositionTypes {
    public static final int E_LeftBorder = 0;
    public static final int E_LeftVertical = 1;
    public static final int E_LeftHorizontal = 2;
    public static final int E_LeftOblique = 3;
    public static final int E_CenterLeftOblique = 4;
    public static final int E_CenterLeftHorizontal = 5;
    public static final int E_CenterX = 6;
    public static final int E_CenterRightHorizontal = 7;
    public static final int E_CenterRightOblique = 8;
    public static final int E_RightOblique = 9;
    public static final int E_RightHorizontal = 10;
    public static final int E_RightVertical = 11;
    public static final int E_RightBorder = 12;
    public static final int E_ExceptionNh_0 = 13;
    public static final int E_ExceptionNh_1 = 14;
    public static final int E_ExceptionNh_2 = 15;
    public static final int E_ExceptionNh_3 = 16;
    public static final int E_ExceptionNh_4 = 17;
    public static final int E_ExceptionXh_0 = 18;
    public static final int E_ExceptionXh_1 = 19;
    public static final int E_ExceptionXh_2 = 20;
    public static final int E_ExceptionXh_3 = 21;
    public static final int E_ExceptionXh_4 = 22;
    public static final int E_ExceptionZh_0 = 23;
    public static final int E_ExceptionZh_1 = 24;
    public static final int E_ExceptionZh_2 = 25;
    public static final int E_ExceptionZh_3 = 26;
    public static final int E_ExceptionZh_4 = 27;
    public static final int E_Exception7h = 28;
    public static final int NumHCards = 29;
//    }

    //    public class VerticalPositionTypes {
    public static final int E_TopBorder = 0;
    public static final int E_TopHorizontal = 1;
    public static final int E_TopOblique = 2;
    public static final int E_TopTopVertical = 3;
    public static final int E_TopVertical = 4;
    public static final int E_CenterTopOblique = 5;
    public static final int E_CenterY = 6;
    public static final int E_CenterBotOblique = 7;
    public static final int E_BotVertical = 8;
    public static final int E_BotBotVertical = 9;
    public static final int E_BotOblique = 10;
    public static final int E_BotHorizontal = 11;
    public static final int E_BottomBorder = 12;
    public static final int E_ExceptionNv_0 = 13;
    public static final int E_ExceptionNv_1 = 14;
    public static final int E_ExceptionNv_2 = 15;
    public static final int E_ExceptionNv_3 = 16;
    public static final int E_ExceptionNv_4 = 17;
    public static final int E_ExceptionXv_0 = 18;
    public static final int E_ExceptionXv_1 = 19;
    public static final int E_ExceptionXv_2 = 20;
    public static final int E_ExceptionXv_3 = 21;
    public static final int E_ExceptionXv_4 = 22;
    public static final int E_ExceptionZv_0 = 23;
    public static final int E_ExceptionZv_1 = 24;
    public static final int E_ExceptionZv_2 = 25;
    public static final int E_ExceptionZv_3 = 26;
    public static final int E_ExceptionZv_4 = 27;
    public static final int NumVCards = 28;
//    }
//__________________________________________________________________________________________________

    //    public class RotationTypes {
    public static final int E_Rotation0 = 0;
    public static final int E_Rotation45 = 1;
    public static final int E_Rotation90 = 2;
    public static final int E_Rotation135 = 3;
    public static final int E_Rotation180 = 4;
    public static final int E_Rotation225 = 5;
    public static final int E_Rotation270 = 6;
    public static final int E_Rotation315 = 7;
    public static final int E_ExceptionNr = 8;
    public static final int E_ExceptionXr1 = 9;
    public static final int E_ExceptionXr2 = 10;
    public static final int E_ExceptionZr = 11;
    public static final int E_Exception0r = 12;
//    }

    public static       float   PositionsX[];
    public static       float   PositionsY[];
    public static final float    Rotations[]   = {0, M_PI_4, M_PI_2, 3 * M_PI_4, M_PI, 5* M_PI_4, 3 * M_PI_2, 7 * M_PI_4, (150.0f / 180.0f) * M_PI, (44f / 180.0f) * M_PI, (136f / 180.0f) * M_PI, (44.0f / 180.0f) * M_PI, (39.0f / 180.0f) * M_PI};
//__________________________________________________________________________________________________

    public static final int numCardsSpace        = 0;
    public static final int cardPosXSpace[]      = {0};
    public static final int cardPosYSpace[]      = {0};
    public static final int cardRotationsSpace[] = {0};
//____________________

    public static final int numCardsA            = 14;
    public static final int cardPosXA[]          = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightVertical, E_RightVertical, E_RightVertical , E_CenterRightHorizontal, E_CenterLeftHorizontal};
    public static final int cardPosYA[]          = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotBotVertical, E_CenterY             , E_CenterY              };
    public static final int cardRotationsA[]     = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation0     , E_Rotation90          , E_Rotation90           };
//____________________

    public static final int numCardsB             = 19;
    public static final int cardPosXB[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique , E_RightVertical, E_RightOblique    , E_RightOblique    , E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftHorizontal, E_CenterRightHorizontal, E_CenterLeftHorizontal};
    public static final int cardPosYB[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique   , E_TopVertical  , E_CenterTopOblique, E_CenterBotOblique, E_BotVertical  , E_BotOblique  , E_BotHorizontal       , E_BotHorizontal        , E_BotHorizontal , E_CenterY              , E_CenterY             };
    public static final int cardRotationsB[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation315  , E_Rotation0    , E_Rotation45      , E_Rotation315     , E_Rotation0    , E_Rotation45  , E_Rotation90          , E_Rotation90           , E_Rotation90    , E_Rotation90           , E_Rotation90          };
//____________________

    public static final int numCardsC             = 11;
    public static final int cardPosXC[]           = {E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique};
    public static final int cardPosYC[]           = {E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  };
    public static final int cardRotationsC[]      = {E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 };
//____________________

    public static final int numCardsD             = 15;
    public static final int cardPosXD[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightVertical, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftHorizontal};
    public static final int cardPosYD[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_BotHorizontal };
    public static final int cardRotationsD[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation90    };
//____________________

    public static final int numCardsE             = 15;
    public static final int cardPosXE[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal};
    public static final int cardPosYE[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopHorizontal  , E_CenterY             , E_CenterY              , E_BotHorizontal , E_BotHorizontal       , E_BotHorizontal        , E_BotHorizontal  };
    public static final int cardRotationsE[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     , E_Rotation90          , E_Rotation90           , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     };
//____________________

    public static final int numCardsF             = 11;
    public static final int cardPosXF[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal};
    public static final int cardPosYF[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopHorizontal  , E_CenterY             , E_CenterY              };
    public static final int cardRotationsF[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     , E_Rotation90          , E_Rotation90           };
//____________________

    public static final int numCardsG             = 13;
    public static final int cardPosXG[]           = {E_RightHorizontal, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique};
    public static final int cardPosYG[]           = {E_CenterY        , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  };
    public static final int cardRotationsG[]      = {E_Rotation90     , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 };
//____________________

    public static final int numCardsH             = 12;
    public static final int cardPosXH[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_RightVertical , E_RightVertical, E_RightVertical, E_RightVertical, E_RightVertical , E_CenterLeftHorizontal, E_CenterRightHorizontal};
    public static final int cardPosYH[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_BotBotVertical, E_BotVertical  , E_CenterY      , E_TopVertical  , E_TopTopVertical, E_CenterY             , E_CenterY              };
    public static final int cardRotationsH[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation0     , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation0     , E_Rotation90          , E_Rotation90           };
//____________________

    public static final int numCardsI             = 5;
    public static final int cardPosXI[]           = {E_CenterX       , E_CenterX    , E_CenterX  , E_CenterX    , E_CenterX       };
    public static final int cardPosYI[]           = {E_BotBotVertical, E_BotVertical, E_CenterY  , E_TopVertical, E_TopTopVertical};
    public static final int cardRotationsI[]      = {E_Rotation0     , E_Rotation0  , E_Rotation0, E_Rotation0  , E_Rotation0     };
//____________________

    public static final int numCardsJ             = 9;
    public static final int cardPosXJ[]           = {E_RightVertical , E_RightVertical, E_RightVertical, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique, E_LeftVertical};
    public static final int cardPosYJ[]           = {E_TopTopVertical, E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_BotOblique , E_BotVertical };
    public static final int cardRotationsJ[]      = {E_Rotation0     , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation315, E_Rotation0   };
//____________________

    public static final int numCardsK             = 12;
    public static final int cardPosXK[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_RightOblique, E_CenterRightOblique, E_CenterX         , E_CenterLeftHorizontal, E_CenterX         , E_CenterRightOblique, E_RightOblique};
    public static final int cardPosYK[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopOblique  , E_TopVertical       , E_CenterTopOblique, E_CenterY             , E_CenterBotOblique, E_BotVertical       , E_BotOblique  };
    public static final int cardRotationsK[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation45  , E_Rotation45        , E_Rotation45      , E_Rotation90          , E_Rotation315     , E_Rotation315       , E_Rotation315 };
//____________________

    public static final int numCardsL             = 9;
    public static final int cardPosXL[]           = {E_RightHorizontal, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftHorizontal, E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  };
    public static final int cardPosYL[]           = {E_BotHorizontal  , E_BotHorizontal        , E_BotHorizontal       , E_BotHorizontal , E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical};
    public static final int cardRotationsL[]      = {E_Rotation90     , E_Rotation90           , E_Rotation90          , E_Rotation90    , E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     };
//____________________

    public static final int numCardsM             = 14;
    public static final int cardPosXM[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftHorizontal, E_CenterLeftOblique, E_CenterRightOblique, E_RightHorizontal, E_RightVertical , E_RightVertical, E_RightVertical, E_RightVertical , E_CenterX    , E_CenterX  };
    public static final int cardPosYM[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopHorizontal , E_TopOblique       , E_TopOblique        , E_TopHorizontal  , E_TopVertical   , E_CenterY      , E_BotVertical  , E_BotBotVertical, E_TopVertical, E_CenterY  };
    public static final int cardRotationsM[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation90    , E_Rotation315      , E_Rotation45        , E_Rotation90     , E_Rotation0     , E_Rotation0    , E_Rotation0    , E_Rotation0     , E_Rotation0  , E_Rotation0};
//____________________

    public static final int numCardsN             = 15;
    public static final int cardPosXN[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftHorizontal, E_ExceptionNh_0, E_ExceptionNh_1, E_ExceptionNh_2, E_ExceptionNh_3, E_ExceptionNh_4, E_RightHorizontal, E_RightVertical, E_RightVertical, E_RightVertical, E_RightVertical };
    public static final int cardPosYN[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopHorizontal , E_ExceptionNv_0, E_ExceptionNv_1, E_ExceptionNv_2, E_ExceptionNv_3, E_ExceptionNv_4, E_BotHorizontal  , E_BotVertical  , E_CenterY      , E_TopVertical  , E_TopTopVertical};
    public static final int cardRotationsN[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation90    , E_ExceptionNr  , E_ExceptionNr  , E_ExceptionNr  , E_ExceptionNr  , E_ExceptionNr  , E_Rotation90     , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation0     };
//____________________

    public static final int numCardsO             = 14;
    public static final int cardPosXO[]           = {E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightVertical, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal};
    public static final int cardPosYO[]           = {E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       };
    public static final int cardRotationsO[]      = {E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          };
//____________________

    public static final int numCardsP             = 13;
    public static final int cardPosXP[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique , E_RightVertical, E_RightOblique    , E_CenterRightHorizontal, E_CenterLeftHorizontal};
    public static final int cardPosYP[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique   , E_TopVertical  , E_CenterTopOblique, E_CenterY              , E_CenterY             };
    public static final int cardRotationsP[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation315  , E_Rotation0    , E_Rotation45      , E_Rotation90           , E_Rotation90          };
//____________________

    public static final int numCardsQ             = 15;
    public static final int cardPosXQ[]           = {E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightVertical   , E_RightOblique    , E_CenterRightOblique, E_CenterX   , E_CenterLeftHorizontal, E_RightOblique};
    public static final int cardPosYQ[]           = {E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterTopOblique, E_CenterBotOblique, E_BotVertical       , E_BotOblique, E_BotHorizontal       , E_BotOblique  };
    public static final int cardRotationsQ[]      = {E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation0       , E_Rotation45      , E_Rotation45        , E_Rotation45, E_Rotation90          , E_Rotation315 };
//____________________

    public static final int numCardsR             = 16;
    public static final int cardPosXR[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique , E_RightVertical, E_RightOblique    , E_RightOblique    , E_RightVertical, E_RightVertical , E_CenterRightHorizontal, E_CenterLeftHorizontal};
    public static final int cardPosYR[]           = {E_BotBotVertical, E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique   , E_TopVertical  , E_CenterTopOblique, E_CenterBotOblique, E_BotVertical  , E_BotBotVertical, E_CenterY              , E_CenterY             };
    public static final int cardRotationsR[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation315  , E_Rotation0    , E_Rotation45      , E_Rotation315     , E_Rotation0    , E_Rotation0     , E_Rotation90           , E_Rotation90          };
//____________________

    public static final int numCardsS             = 14;
    public static final int cardPosXS[]           = {E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightOblique    , E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique     , E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique};
    public static final int cardPosYS[]           = {E_BotOblique , E_BotHorizontal       , E_BotHorizontal        , E_BotOblique  , E_BotVertical  , E_CenterBotOblique, E_CenterY              , E_CenterY             , E_CenterTopOblique, E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  };
    public static final int cardRotationsS[]      = {E_Rotation315, E_Rotation90          , E_Rotation90           , E_Rotation45  , E_Rotation0    , E_Rotation315     , E_Rotation90           , E_Rotation90          , E_Rotation315     , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 };
//____________________

    public static final int numCardsT             = 8;
    public static final int cardPosXT[]           = {E_CenterX       , E_CenterX    , E_CenterX  , E_CenterX    , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal};
    public static final int cardPosYT[]           = {E_BotBotVertical, E_BotVertical, E_CenterY  , E_TopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopHorizontal  };
    public static final int cardRotationsT[]      = {E_Rotation0     , E_Rotation0  , E_Rotation0, E_Rotation0  , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     };
//____________________

    public static final int numCardsU             = 12;
    public static final int cardPosXU[]           = {E_RightVertical , E_RightVertical, E_RightVertical, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical };
    public static final int cardPosYU[]           = {E_TopTopVertical, E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical};
    public static final int cardRotationsU[]      = {E_Rotation0     , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     };
//____________________

    public static final int numCardsV             = 12;
    public static final int cardPosXV[]           = {E_RightVertical , E_RightVertical, E_RightVertical   , E_RightOblique    , E_CenterRightOblique, E_CenterX       , E_CenterX       , E_CenterLeftOblique, E_LeftOblique     , E_LeftVertical    , E_LeftVertical, E_LeftVertical  };
    public static final int cardPosYV[]           = {E_TopTopVertical, E_TopVertical  , E_CenterTopOblique, E_CenterBotOblique, E_BotVertical       , E_BotBotVertical, E_BotBotVertical, E_BotVertical      , E_CenterBotOblique, E_CenterTopOblique, E_TopVertical , E_TopTopVertical};
    public static final int cardRotationsV[]      = {E_Rotation0     , E_Rotation0    , E_Rotation0       , E_Rotation45      , E_Rotation45        , E_Rotation0     , E_Rotation0     , E_Rotation315      , E_Rotation315     , E_Rotation0       , E_Rotation0   , E_Rotation0     };
//____________________

    public static final int numCardsW             = 14;
    public static final int cardPosXW[]           = {E_RightVertical , E_RightVertical, E_RightVertical, E_RightVertical, E_RightHorizontal, E_CenterRightOblique, E_CenterX    , E_CenterX  , E_CenterLeftOblique, E_LeftHorizontal, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftVertical  };
    public static final int cardPosYW[]           = {E_TopTopVertical, E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotHorizontal  , E_BotOblique        , E_BotVertical, E_CenterY  , E_BotOblique       , E_BotHorizontal , E_BotVertical , E_CenterY     , E_TopVertical , E_TopTopVertical};
    public static final int cardRotationsW[]      = {E_Rotation0     , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation90     , E_Rotation315       , E_Rotation0  , E_Rotation0, E_Rotation45       , E_Rotation90    , E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation0     };
//____________________

    public static final int numCardsX             = 10;
    public static final int cardPosXX[]           = {E_ExceptionXh_0, E_ExceptionXh_1, E_ExceptionXh_2, E_ExceptionXh_3, E_ExceptionXh_4, E_ExceptionXh_4, E_ExceptionXh_3, E_ExceptionXh_2, E_ExceptionXh_1, E_ExceptionXh_0};
    public static final int cardPosYX[]           = {E_ExceptionXv_0, E_ExceptionXv_1, E_ExceptionXv_2, E_ExceptionXv_3, E_ExceptionXv_4, E_ExceptionXv_0, E_ExceptionXv_1, E_ExceptionXv_2, E_ExceptionXv_3, E_ExceptionXv_4};
    public static final int cardRotationsX[]      = {E_ExceptionXr1 , E_ExceptionXr1 , E_ExceptionXr1 , E_ExceptionXr1 , E_ExceptionXr1 , E_ExceptionXr2 , E_ExceptionXr2 , E_ExceptionXr2 , E_ExceptionXr2 , E_ExceptionXr2 };
//____________________

    public static final int numCardsY             = 10;
    public static final int cardPosXY[]           = {E_CenterX       , E_CenterX    , E_LeftOblique     , E_LeftVertical, E_LeftVertical  , E_RightOblique    , E_RightVertical, E_RightVertical , E_CenterLeftHorizontal, E_CenterRightHorizontal};
    public static final int cardPosYY[]           = {E_BotBotVertical, E_BotVertical, E_CenterTopOblique, E_TopVertical , E_TopTopVertical, E_CenterTopOblique, E_TopVertical  , E_TopTopVertical, E_CenterY             , E_CenterY              };
    public static final int cardRotationsY[]      = {E_Rotation0     , E_Rotation0  , E_Rotation315     , E_Rotation0   , E_Rotation0     , E_Rotation45      , E_Rotation0    , E_Rotation0     , E_Rotation90          , E_Rotation90           };
//____________________

    public static final int numCardsZ             = 13;
    public static final int cardPosXZ[]           = {E_RightHorizontal, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftHorizontal, E_ExceptionZh_0, E_ExceptionZh_1, E_ExceptionZh_2, E_ExceptionZh_3, E_ExceptionZh_4, E_RightHorizontal, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftHorizontal};
    public static final int cardPosYZ[]           = {E_BotHorizontal  , E_BotHorizontal        , E_BotHorizontal       , E_BotHorizontal , E_ExceptionZv_0, E_ExceptionZv_1, E_ExceptionZv_2, E_ExceptionZv_3, E_ExceptionZv_4, E_TopHorizontal  , E_TopHorizontal        , E_TopHorizontal       , E_TopHorizontal };
    public static final int cardRotationsZ[]      = {E_Rotation90     , E_Rotation90           , E_Rotation90          , E_Rotation90    , E_ExceptionZr  , E_ExceptionZr  , E_ExceptionZr  , E_ExceptionZr  , E_ExceptionZr  , E_Rotation90     , E_Rotation90           , E_Rotation90          , E_Rotation90    };
//____________________

    public static final int numCardsExcla         = 4;
    public static final int cardPosXExcla[]       = {E_CenterX      , E_CenterX  , E_CenterX    , E_CenterX       };
    public static final int cardPosYExcla[]       = {E_BotHorizontal, E_CenterY  , E_TopVertical, E_TopTopVertical};
    public static final int cardRotationsExcla[]  = {E_Rotation90   , E_Rotation0, E_Rotation0  , E_Rotation0     };
//____________________

    public static final int numCardsQuest         = 8;
    public static final int cardPosXQuest[]       = {E_CenterX      , E_CenterRightHorizontal, E_RightOblique    , E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique};
    public static final int cardPosYQuest[]       = {E_BotHorizontal, E_CenterY              , E_CenterTopOblique, E_TopVertical  , E_TopOblique  , E_TopHorizontal        , E_TopHorizontal       , E_TopOblique};
    public static final int cardRotationsQuest[]  = {E_Rotation90   , E_Rotation90           , E_Rotation45      , E_Rotation0    , E_Rotation315 , E_Rotation90           , E_Rotation90          , E_Rotation45};
//____________________

    public static final int numCards0             = 17;
    public static final int cardPosX0[]           = {E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightVertical, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_CenterLeftOblique, E_CenterX    , E_CenterRightOblique};
    public static final int cardPosY0[]           = {E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_ExceptionNv_3    , E_CenterY    , E_ExceptionNv_1     };
    public static final int cardRotations0[]      = {E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Exception0r      , E_Exception0r, E_Exception0r       };
//____________________

    public static final int numCards1             = 8;
    public static final int cardPosX1[]           = {E_ExceptionNh_0, E_CenterX      , E_ExceptionNh_4, E_CenterX    , E_CenterX  , E_CenterX    , E_CenterX       , E_CenterLeftOblique};
    public static final int cardPosY1[]           = {E_BotHorizontal, E_BotHorizontal, E_BotHorizontal, E_BotVertical, E_CenterY  , E_TopVertical, E_TopTopVertical, E_TopOblique       };
    public static final int cardRotations1[]      = {E_Rotation90   , E_Rotation90   , E_Rotation90   , E_Rotation0  , E_Rotation0, E_Rotation0  , E_Rotation0     , E_Rotation45       };
//____________________

    public static final int numCards2             = 15;
    public static final int cardPosX2[]           = {E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightOblique    , E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique     , E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal};
    public static final int cardPosY2[]           = {E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterTopOblique, E_CenterY              , E_CenterY             , E_CenterBotOblique, E_BotVertical , E_BotBotVertical, E_BotHorizontal , E_BotHorizontal       , E_BotHorizontal        , E_BotHorizontal  };
    public static final int cardRotations2[]      = {E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation45      , E_Rotation90           , E_Rotation90          , E_Rotation45      , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     };
//____________________

    public static final int numCards3             = 13;
    public static final int cardPosX3[]           = {E_RightOblique, E_RightVertical, E_RightOblique    , E_RightOblique    , E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique, E_CenterRightHorizontal, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique};
    public static final int cardPosY3[]           = {E_BotOblique  , E_BotVertical  , E_CenterBotOblique, E_CenterTopOblique, E_TopVertical  , E_TopOblique  , E_TopHorizontal        , E_TopHorizontal       , E_TopOblique , E_CenterY              , E_BotHorizontal        , E_BotHorizontal       , E_BotOblique };
    public static final int cardRotations3[]      = {E_Rotation45  , E_Rotation0    , E_Rotation315     , E_Rotation45      , E_Rotation0    , E_Rotation315 , E_Rotation90           , E_Rotation90          , E_Rotation45 , E_Rotation90           , E_Rotation90           , E_Rotation90          , E_Rotation315};
//____________________

    public static final int numCards4             = 10;
    public static final int cardPosX4[]           = {E_LeftVertical  , E_LeftVertical, E_LeftVertical    , E_LeftHorizontal  , E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal , E_CenterX       , E_CenterX    , E_CenterX  };
    public static final int cardPosY4[]           = {E_TopTopVertical, E_TopVertical , E_CenterTopOblique, E_CenterBotOblique, E_CenterBotOblique    , E_CenterBotOblique     , E_CenterBotOblique, E_BotBotVertical, E_BotVertical, E_CenterY  };
    public static final int cardRotations4[]      = {E_Rotation0     , E_Rotation0   , E_Rotation0       , E_Rotation90      , E_Rotation90          , E_Rotation90           , E_Rotation90      , E_Rotation0     , E_Rotation0  , E_Rotation0};
//____________________

    public static final int numCards5             = 15;
    public static final int cardPosX5[]           = {E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightOblique    , E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique     , E_LeftVertical, E_LeftVertical  , E_LeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightHorizontal};
    public static final int cardPosY5[]           = {E_BotOblique , E_BotHorizontal       , E_BotHorizontal        , E_BotOblique  , E_BotVertical  , E_CenterBotOblique, E_CenterY              , E_CenterY             , E_CenterTopOblique, E_TopVertical , E_TopTopVertical, E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopHorizontal  };
    public static final int cardRotations5[]      = {E_Rotation315, E_Rotation90          , E_Rotation90           , E_Rotation45  , E_Rotation0    , E_Rotation315     , E_Rotation90           , E_Rotation90          , E_Rotation315     , E_Rotation0   , E_Rotation0     , E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     };
//____________________

    public static final int numCards6             = 15;
    public static final int cardPosX6[]           = {E_RightOblique, E_RightOblique    , E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftOblique, E_LeftVertical, E_LeftVertical, E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_CenterRightHorizontal, E_CenterLeftHorizontal};
    public static final int cardPosY6[]           = {E_TopOblique  , E_CenterBotOblique, E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_BotOblique , E_BotVertical , E_CenterY     , E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_CenterY              , E_CenterY             };
    public static final int cardRotations6[]      = {E_Rotation315 , E_Rotation315     , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation315, E_Rotation0   , E_Rotation0   , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation90           , E_Rotation90          };
//____________________

    public static final int numCards7             = 11;
    public static final int cardPosX7[]           = {E_Exception7h, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_LeftHorizontal, E_RightOblique, E_CenterRightOblique, E_CenterX    , E_CenterLeftOblique, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal};
    public static final int cardPosY7[]           = {E_TopHorizontal , E_TopHorizontal       , E_TopHorizontal        , E_TopHorizontal  , E_TopOblique  , E_ExceptionNv_1     , E_CenterY    , E_ExceptionNv_3    , E_BotOblique , E_CenterY             , E_CenterY              };
    public static final int cardRotations7[]      = {E_Rotation90    , E_Rotation90          , E_Rotation90           , E_Rotation90     , E_Exception0r , E_Exception0r       , E_Exception0r, E_Exception0r      , E_Exception0r, E_Rotation90          , E_Rotation90           };
//____________________

    public static final int numCards8             = 18;
    public static final int cardPosX8[]           = {E_LeftOblique, E_LeftVertical, E_LeftOblique     , E_LeftOblique     , E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightOblique    , E_RightOblique    , E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal};
    public static final int cardPosY8[]           = {E_BotOblique , E_BotVertical , E_CenterBotOblique, E_CenterTopOblique, E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterTopOblique, E_CenterBotOblique, E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_CenterY             , E_CenterY              };
    public static final int cardRotations8[]      = {E_Rotation315, E_Rotation0   , E_Rotation45      , E_Rotation315     , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation45      , E_Rotation315     , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation90          , E_Rotation90           };
//____________________

    public static final int numCards9             = 15;
    public static final int cardPosX9[]           = {E_LeftOblique, E_LeftOblique     , E_LeftVertical, E_LeftOblique, E_CenterLeftHorizontal, E_CenterRightHorizontal, E_RightOblique, E_RightVertical, E_RightVertical, E_RightVertical, E_RightOblique, E_CenterRightHorizontal, E_CenterLeftHorizontal, E_CenterLeftHorizontal, E_CenterRightHorizontal};
    public static final int cardPosY9[]           = {E_BotOblique , E_CenterTopOblique, E_TopVertical , E_TopOblique , E_TopHorizontal       , E_TopHorizontal        , E_TopOblique  , E_TopVertical  , E_CenterY      , E_BotVertical  , E_BotOblique  , E_BotHorizontal        , E_BotHorizontal       , E_CenterY             , E_CenterY              };
    public static final int cardRotations9[]      = {E_Rotation315, E_Rotation315     , E_Rotation0   , E_Rotation45 , E_Rotation90          , E_Rotation90           , E_Rotation315 , E_Rotation0    , E_Rotation0    , E_Rotation0    , E_Rotation45  , E_Rotation90           , E_Rotation90          , E_Rotation90          , E_Rotation90           };
//____________________
}