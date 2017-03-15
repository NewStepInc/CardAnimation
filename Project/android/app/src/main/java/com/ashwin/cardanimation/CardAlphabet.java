package com.ashwin.cardanimation;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by nick on 3/4/16.
 */
public class CardAlphabet {
    public static Map<String, Letter> Letters = new HashMap<>();
    public static float lettersWidth;
    public static float lettersHeight;

    public static void init(float cardWidth, float cardHeight) {
        Letter.init(cardWidth, cardHeight);

        Letter letter;

        // Creates Space charater.
        letter = new Letter();
        letter.NumCards = Letter.numCardsSpace;
        letter.CardPosX = Letter.cardPosXSpace;
        letter.CardPosY = Letter.cardPosYSpace;
        letter.CardRotations = Letter.cardRotationsSpace;
        Letters.put(" ", letter);

        // Creates Letter A.
        letter = new Letter();
        letter.NumCards = Letter.numCardsA;
        letter.CardPosX = Letter.cardPosXA;
        letter.CardPosY = Letter.cardPosYA;
        letter.CardRotations = Letter.cardRotationsA;
        Letters.put("A", letter);

        // Creates Letter B.
        letter = new Letter();
        letter.NumCards = Letter.numCardsB;
        letter.CardPosX = Letter.cardPosXB;
        letter.CardPosY = Letter.cardPosYB;
        letter.CardRotations = Letter.cardRotationsB;
        Letters.put("B", letter);

        // Creates Letter C.
        letter = new Letter();
        letter.NumCards = Letter.numCardsC;
        letter.CardPosX = Letter.cardPosXC;
        letter.CardPosY = Letter.cardPosYC;
        letter.CardRotations = Letter.cardRotationsC;
        Letters.put("C", letter);

        // Creates Letter D.
        letter = new Letter();
        letter.NumCards = Letter.numCardsD;
        letter.CardPosX = Letter.cardPosXD;
        letter.CardPosY = Letter.cardPosYD;
        letter.CardRotations = Letter.cardRotationsD;
        Letters.put("D", letter);

        // Creates Letter E.
        letter = new Letter();
        letter.NumCards = Letter.numCardsE;
        letter.CardPosX = Letter.cardPosXE;
        letter.CardPosY = Letter.cardPosYE;
        letter.CardRotations = Letter.cardRotationsE;
        Letters.put("E", letter);

        // Creates Letter F.
        letter = new Letter();
        letter.NumCards = Letter.numCardsF;
        letter.CardPosX = Letter.cardPosXF;
        letter.CardPosY = Letter.cardPosYF;
        letter.CardRotations = Letter.cardRotationsF;
        Letters.put("F", letter);

        // Creates Letter G.
        letter = new Letter();
        letter.NumCards = Letter.numCardsG;
        letter.CardPosX = Letter.cardPosXG;
        letter.CardPosY = Letter.cardPosYG;
        letter.CardRotations = Letter.cardRotationsG;
        Letters.put("G", letter);

        // Creates Letter H.
        letter = new Letter();
        letter.NumCards = Letter.numCardsH;
        letter.CardPosX = Letter.cardPosXH;
        letter.CardPosY = Letter.cardPosYH;
        letter.CardRotations = Letter.cardRotationsH;
        Letters.put("H", letter);

        // Creates Letter I.
        letter = new Letter();
        letter.NumCards = Letter.numCardsI;
        letter.CardPosX = Letter.cardPosXI;
        letter.CardPosY = Letter.cardPosYI;
        letter.CardRotations = Letter.cardRotationsI;
        Letters.put("I", letter);

        // Creates Letter J.
        letter = new Letter();
        letter.NumCards = Letter.numCardsJ;
        letter.CardPosX = Letter.cardPosXJ;
        letter.CardPosY = Letter.cardPosYJ;
        letter.CardRotations = Letter.cardRotationsJ;
        Letters.put("J", letter);

        // Creates Letter K.
        letter = new Letter();
        letter.NumCards = Letter.numCardsK;
        letter.CardPosX = Letter.cardPosXK;
        letter.CardPosY = Letter.cardPosYK;
        letter.CardRotations = Letter.cardRotationsK;
        Letters.put("K", letter);

        // Creates Letter L.
        letter = new Letter();
        letter.NumCards = Letter.numCardsL;
        letter.CardPosX = Letter.cardPosXL;
        letter.CardPosY = Letter.cardPosYL;
        letter.CardRotations = Letter.cardRotationsL;
        Letters.put("L", letter);

        // Creates Letter M.
        letter = new Letter();
        letter.NumCards = Letter.numCardsM;
        letter.CardPosX = Letter.cardPosXM;
        letter.CardPosY = Letter.cardPosYM;
        letter.CardRotations = Letter.cardRotationsM;
        Letters.put("M", letter);

        // Creates Letter N.
        letter = new Letter();
        letter.NumCards = Letter.numCardsN;
        letter.CardPosX = Letter.cardPosXN;
        letter.CardPosY = Letter.cardPosYN;
        letter.CardRotations = Letter.cardRotationsN;
        Letters.put("N", letter);

        // Creates Letter O.
        letter = new Letter();
        letter.NumCards = Letter.numCardsO;
        letter.CardPosX = Letter.cardPosXO;
        letter.CardPosY = Letter.cardPosYO;
        letter.CardRotations = Letter.cardRotationsO;
        Letters.put("O", letter);

        // Creates Letter P.
        letter = new Letter();
        letter.NumCards = Letter.numCardsP;
        letter.CardPosX = Letter.cardPosXP;
        letter.CardPosY = Letter.cardPosYP;
        letter.CardRotations = Letter.cardRotationsP;
        Letters.put("P", letter);

        // Creates Letter Q.
        letter = new Letter();
        letter.NumCards = Letter.numCardsQ;
        letter.CardPosX = Letter.cardPosXQ;
        letter.CardPosY = Letter.cardPosYQ;
        letter.CardRotations = Letter.cardRotationsQ;
        Letters.put("Q", letter);

        // Creates Letter R.
        letter = new Letter();
        letter.NumCards = Letter.numCardsR;
        letter.CardPosX = Letter.cardPosXR;
        letter.CardPosY = Letter.cardPosYR;
        letter.CardRotations = Letter.cardRotationsR;
        Letters.put("R", letter);

        // Creates Letter S.
        letter = new Letter();
        letter.NumCards = Letter.numCardsS;
        letter.CardPosX = Letter.cardPosXS;
        letter.CardPosY = Letter.cardPosYS;
        letter.CardRotations = Letter.cardRotationsS;
        Letters.put("S", letter);

        // Creates Letter T.
        letter = new Letter();
        letter.NumCards = Letter.numCardsT;
        letter.CardPosX = Letter.cardPosXT;
        letter.CardPosY = Letter.cardPosYT;
        letter.CardRotations = Letter.cardRotationsT;
        Letters.put("T", letter);

        // Creates Letter U.
        letter = new Letter();
        letter.NumCards = Letter.numCardsU;
        letter.CardPosX = Letter.cardPosXU;
        letter.CardPosY = Letter.cardPosYU;
        letter.CardRotations = Letter.cardRotationsU;
        Letters.put("U", letter);

        // Creates Letter V.
        letter = new Letter();
        letter.NumCards = Letter.numCardsV;
        letter.CardPosX = Letter.cardPosXV;
        letter.CardPosY = Letter.cardPosYV;
        letter.CardRotations = Letter.cardRotationsV;
        Letters.put("V", letter);

        // Creates Letter W.
        letter = new Letter();
        letter.NumCards = Letter.numCardsW;
        letter.CardPosX = Letter.cardPosXW;
        letter.CardPosY = Letter.cardPosYW;
        letter.CardRotations = Letter.cardRotationsW;
        Letters.put("W", letter);

        // Creates Letter X.
        letter = new Letter();
        letter.NumCards = Letter.numCardsX;
        letter.CardPosX = Letter.cardPosXX;
        letter.CardPosY = Letter.cardPosYX;
        letter.CardRotations = Letter.cardRotationsX;
        Letters.put("X", letter);

        // Creates Letter Y.
        letter = new Letter();
        letter.NumCards = Letter.numCardsY;
        letter.CardPosX = Letter.cardPosXY;
        letter.CardPosY = Letter.cardPosYY;
        letter.CardRotations = Letter.cardRotationsY;
        Letters.put("Y", letter);

        // Creates Letter Z.
        letter = new Letter();
        letter.NumCards = Letter.numCardsZ;
        letter.CardPosX = Letter.cardPosXZ;
        letter.CardPosY = Letter.cardPosYZ;
        letter.CardRotations = Letter.cardRotationsZ;
        Letters.put("Z", letter);

        // Creates Letter !.
        letter = new Letter();
        letter.NumCards = Letter.numCardsExcla;
        letter.CardPosX = Letter.cardPosXExcla;
        letter.CardPosY = Letter.cardPosYExcla;
        letter.CardRotations = Letter.cardRotationsExcla;
        Letters.put("!", letter);

        // Creates Letter ?.
        letter = new Letter();
        letter.NumCards = Letter.numCardsQuest;
        letter.CardPosX = Letter.cardPosXQuest;
        letter.CardPosY = Letter.cardPosYQuest;
        letter.CardRotations = Letter.cardRotationsQuest;
        Letters.put("?", letter);

        // Creates Digit 0.
        letter = new Letter();
        letter.NumCards = Letter.numCards0;
        letter.CardPosX = Letter.cardPosX0;
        letter.CardPosY = Letter.cardPosY0;
        letter.CardRotations = Letter.cardRotations0;
        Letters.put("0", letter);

        // Creates Digit 1.
        letter = new Letter();
        letter.NumCards = Letter.numCards1;
        letter.CardPosX = Letter.cardPosX1;
        letter.CardPosY = Letter.cardPosY1;
        letter.CardRotations = Letter.cardRotations1;
        Letters.put("1", letter);

        // Creates Digit 2.
        letter = new Letter();
        letter.NumCards = Letter.numCards2;
        letter.CardPosX = Letter.cardPosX2;
        letter.CardPosY = Letter.cardPosY2;
        letter.CardRotations = Letter.cardRotations2;
        Letters.put("2", letter);

        // Creates Digit 3.
        letter = new Letter();
        letter.NumCards = Letter.numCards3;
        letter.CardPosX = Letter.cardPosX3;
        letter.CardPosY = Letter.cardPosY3;
        letter.CardRotations = Letter.cardRotations3;
        Letters.put("3", letter);

        // Creates Digit 4.
        letter = new Letter();
        letter.NumCards = Letter.numCards4;
        letter.CardPosX = Letter.cardPosX4;
        letter.CardPosY = Letter.cardPosY4;
        letter.CardRotations = Letter.cardRotations4;
        Letters.put("4", letter);

        // Creates Digit 5.
        letter = new Letter();
        letter.NumCards = Letter.numCards5;
        letter.CardPosX = Letter.cardPosX5;
        letter.CardPosY = Letter.cardPosY5;
        letter.CardRotations = Letter.cardRotations5;
        Letters.put("5", letter);

        // Creates Digit 6.
        letter = new Letter();
        letter.NumCards = Letter.numCards6;
        letter.CardPosX = Letter.cardPosX6;
        letter.CardPosY = Letter.cardPosY6;
        letter.CardRotations = Letter.cardRotations6;
        Letters.put("6", letter);

        // Creates Digit 7.
        letter = new Letter();
        letter.NumCards = Letter.numCards7;
        letter.CardPosX = Letter.cardPosX7;
        letter.CardPosY = Letter.cardPosY7;
        letter.CardRotations = Letter.cardRotations7;
        Letters.put("7", letter);

        // Creates Digit 8.
        letter = new Letter();
        letter.NumCards = Letter.numCards8;
        letter.CardPosX = Letter.cardPosX8;
        letter.CardPosY = Letter.cardPosY8;
        letter.CardRotations = Letter.cardRotations8;
        Letters.put("8", letter);

        // Creates Digit 9.
        letter = new Letter();
        letter.NumCards = Letter.numCards9;
        letter.CardPosX = Letter.cardPosX9;
        letter.CardPosY = Letter.cardPosY9;
        letter.CardRotations = Letter.cardRotations9;
        Letters.put("9", letter);

        lettersWidth = Letter.PositionsX[Letter.E_RightBorder];
        lettersHeight = Letter.PositionsY[Letter.E_BottomBorder];
    }

}
