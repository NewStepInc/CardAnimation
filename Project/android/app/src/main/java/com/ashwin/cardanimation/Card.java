package com.ashwin.cardanimation;

import android.content.Context;
import android.graphics.Point;
import android.graphics.drawable.Drawable;
import android.support.v4.content.ContextCompat;
import android.util.AttributeSet;
import android.widget.ImageView;

/**
 * Created by nick on 2/29/16.
 */
public class Card extends ImageView {


    public static final int CARDCLASS_SUIT_SPADE = 1;
    public static final int CARDCLASS_SUIT_CLUB = 2;
    public static final int CARDCLASS_SUIT_DIAMOND = 3;
    public static final int CARDCLASS_SUIT_HEART = 4;


    public int rank, suit, pref;

    public Card(Context context) {
        super(context);
    }

    public Card(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public Card(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    public void setPosition(int xPos, int yPos) {
        setX(xPos);
        setY(yPos);
    }

    public void setPosition(Point pos) {
        setPosition(pos.x, pos.y);
    }


    public static String makeImageNameForRank(int rank, int suit, int pref) {
        StringBuilder sb = new StringBuilder("card_");

        switch (suit) {
            case Card.CARDCLASS_SUIT_CLUB:
                sb.append("0_");
                break;
            case Card.CARDCLASS_SUIT_SPADE:
                sb.append("1_");
                break;
            case Card.CARDCLASS_SUIT_HEART:
                sb.append("2_");
                break;
            case Card.CARDCLASS_SUIT_DIAMOND:
                sb.append("3_");
                break;
        }

        sb.append(rank);
        if (pref == 3 || rank == 1 || rank > 10)
            sb.append("_" + pref);
        else
            sb.append("_1");
        return sb.toString();
    }

    public static Card createCard(Context context, int rank, int suit, int pref) {
        String filename = makeImageNameForRank(rank, suit, pref);
        int id = context.getResources().getIdentifier(filename, "drawable", context.getPackageName());
        Drawable drawable = ContextCompat.getDrawable(context, id);

        Card card = new Card(context);
        card.rank = rank;
        card.suit = suit;
        card.pref = pref;
        card.setImageDrawable(drawable);
        card.setScaleType(ImageView.ScaleType.FIT_XY);

        return card;
    }
}
