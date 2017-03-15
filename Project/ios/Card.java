package com.solebon.solitaire.game;

import android.animation.Animator;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.content.ClipData;
import android.content.ClipDescription;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Point;
import android.graphics.PointF;
import android.graphics.drawable.Drawable;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.DragEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.animation.AccelerateDecelerateInterpolator;
import android.widget.ImageView;

import com.solebon.solitaire.Debugging;
import com.solebon.solitaire.R;
import com.solebon.solitaire.SolebonApp;
import com.solebon.solitaire.Utils;
import com.solebon.solitaire.data.GameCache;
import com.solebon.solitaire.data.Preferences;
import com.solebon.solitaire.data.RunnableManager;
import com.solebon.solitaire.helper.SimpleAnimatorListener;

import java.util.prefs.AbstractPreferences;

public class Card extends ImageView implements View.OnDragListener {

    private static final String TAG = "Card";

    public static final int CARDCLASS_FACE_UP = 1;
    public static final int CARDCLASS_FACE_DOWN = 2;
    public static final int CARDCLASS_FACE_EITHER = 3;

    public static final int CARDCLASS_SUIT_SPADE = 1;
    public static final int CARDCLASS_SUIT_CLUB = 2;
    public static final int CARDCLASS_SUIT_DIAMOND = 3;
    public static final int CARDCLASS_SUIT_HEART = 4;

    public int rank;
    public int suit;
    public int face = CARDCLASS_FACE_DOWN;
    public int stackID;
    public int stackOrder;
    public boolean selected;

    public Drawable frontView;
    public Drawable backView;
    public Drawable selectedView;
    public Stack stack;
    public Card nextCard;

    private boolean _inDrag;
    private boolean _didMove;
    private boolean _animating;

    //private int cardSpeed = 50; // slowest=500 fastest=50

    private String makeImageNameForRank(int newRank, int newSuit, int pref) {
        StringBuilder sb = new StringBuilder("card_");

        switch (newSuit) {
            case CARDCLASS_SUIT_CLUB:
                sb.append("0_");
                break;
            case CARDCLASS_SUIT_SPADE:
                sb.append("1_");
                break;
            case CARDCLASS_SUIT_HEART:
                sb.append("2_");
                break;
            case CARDCLASS_SUIT_DIAMOND:
                sb.append("3_");
                break;
            default:
                Log.e(TAG, "Invalid suit, "+newSuit);
                break;
        }

        sb.append(newRank);
        if (pref == 3 || rank == 1 || rank > 10)
            sb.append("_" + pref);
        else
            sb.append("_1");
        return sb.toString();
    }

    public Card(Context context, int rank, int suit, int pref) {
        super(context);

        this.suit = suit;
        this.rank = rank;

        if (pref != -1) {
            String filename = makeImageNameForRank(rank, suit, pref);

            int id = context.getResources().getIdentifier(filename, "drawable", context.getPackageName());
            if (id == 0) {
                Log.e("CARD", "Invalid card resource, filename=" + filename);

            } else {
                frontView = ContextCompat.getDrawable(context, id);
                backView = Preferences.getCardBackDrawable();
                selectedView = null;

                setOnClickListener(mOnClickListener);
                setOnTouchListener(mTouchListener);
                setOnDragListener(this);
                flipToFace(face);

                SolebonApp.getGameBoard().addCard(this);
            }
        }
    }

    private OnClickListener mOnClickListener = new OnClickListener() {
        @Override
        public void onClick(View v) {
            if (isAnimating())
                return;
            GameCache.getInstance().getActiveGame().hideHint();
            GameCache.getInstance().getActiveGame().touchOnStack(stack, Card.this);
        }
    };

    @Override
    public boolean equals(Object item) {

        if (item != null && item instanceof Card) {
            Card card = (Card)item;
            if (card.rank == rank && card.suit == suit && card.stackID == stackID)
                return true;
        }
        return false;
    }

    public String toXmlElement() {
        StringBuilder xml = new StringBuilder();
        xml.append("<card");
        xml.append(" rank=\""+ rank +"\"");
        xml.append(" suit=\"" + suit + "\"");
        xml.append(" face=\""+ face +"\"");
        xml.append(" stackID=\""+ stackID +"\"");
        xml.append("/>");
        return xml.toString();
    }

    public void facesChanged(Context context, int pref) {
        String filename = makeImageNameForRank(rank, suit, pref);

        int id = context.getResources().getIdentifier(filename, "drawable", context.getPackageName());
        if (id == 0) {
            Log.e("CARD", "Invalid card resource, filename="+filename);

        } else {
            frontView = ContextCompat.getDrawable(context, id);
            if (face == CARDCLASS_FACE_UP) {
                if (selected)
                    select();
                else
                    deselect();
            }
        }
    }

    public void cardbackChanged() {
        // called when the card back changed...
        backView = Preferences.getCardBackDrawable();
        if (face == CARDCLASS_FACE_DOWN) {
            setImageDrawable(backView);
        }
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("rank="+rank);
        sb.append(", suit=" + suit);
        return sb.toString();
    }

    public boolean didMove() {
        return _didMove;
    }
    public void setDidMove(boolean value) {
        _didMove = value;
    }

    public boolean isAnimating() {
        return _animating;
    }

    public boolean isAceHigherThan(Card card) {
        // Check if this card is ranked higher than passed card in an ace-high ranking.
        boolean isHigher = false;
        if (card != null) {
            if (rank == 1 && card.rank == 13) {
                isHigher = true;

            } else if (rank != 2 && rank == card.rank + 1) {
                isHigher = true;
            }
        }
        return isHigher;
    }

    public boolean isConsecutiveHigherThan(Card card) {
        // Check if this card is ranked higher than passed card in a consecutive ranking.
        boolean isHigher = false;
        if (card != null) {
            if (rank == 1 && card.rank == 13) {
                isHigher = true;

            } else if (rank == card.rank + 1) {
                isHigher = true;
            }
        }
        return isHigher;
    }

    public boolean isKingHigherThan(Card card) {
        // Check if this card is ranked higher than passed card in an king-high ranking.
        boolean isHigher = false;
        if (card != null) {
            if (rank == card.rank + 1) {
                isHigher = true;
            }
        }
        return isHigher;
    }

    public boolean isSameSuitAs(Card card) {
        if (card != null)
            return suit == card.suit;
        return false;
    }

    public boolean isSameRankAs(Card card) {
        if (card != null)
            return rank == card.rank;
        return false;
    }

    public boolean isSameColorAs(Card card) {
        if (card != null) {
            if (card.suit == suit)
                return true;

            if (suit == CARDCLASS_SUIT_CLUB && card.suit == CARDCLASS_SUIT_SPADE)
                return true;
            else if (suit == CARDCLASS_SUIT_SPADE && card.suit == CARDCLASS_SUIT_CLUB)
                return true;
            else if (suit == CARDCLASS_SUIT_DIAMOND && card.suit == CARDCLASS_SUIT_HEART)
                return true;
            else if (suit == CARDCLASS_SUIT_HEART && card.suit == CARDCLASS_SUIT_DIAMOND)
                return true;
        }
        return  false;
    }

    public int numCoveringCards() {
        int numCoveringCards = 0;
        Card card = this;

        while (card.nextCard != null) {
            numCoveringCards++;
            card = card.nextCard;
        }
        return numCoveringCards;
    }

    public void select() {
        // Set card to the selected state.

        setImageResource(R.drawable.card_selection);
        setBackgroundDrawable(frontView);
        selected = true;
    }

    public void deselect() {
        // Set card to the deselected state.

        setImageDrawable(frontView);
        setBackgroundColor(0);
        selected = false;
    }

    public void setStack(Stack newStack) {
        if (newStack != null) {
            stack = newStack;
            stackID = stack.stackID;
        }
    }

    public boolean isMoving() {
        return false;
    }

    public void rotateView(View view, boolean clockWise, int duration) {

    }

    public void setPostion(int x, int y) {

        if (getX() == 0) {
            setX(x);
            setY(y);

        } else {
            float cardSpeed = 450f * (100 - Preferences.getCardSpeed())/100f; //0 - 100
            int duration = 50 + (int)cardSpeed; //slowest=500 fastest=50

            //Log.d(TAG, "animate "+toString()+ " to x="+x+", y="+y);
            _animating = true;

            ObjectAnimator animX = ObjectAnimator.ofFloat(this, "x", x);
            ObjectAnimator animY = ObjectAnimator.ofFloat(this, "y", y);
            AnimatorSet animSetXY = new AnimatorSet();

            if (nextCard == null) {
                animSetXY.addListener(new SimpleAnimatorListener() {
                    @Override
                    public void onAnimationEnd(Animator animation) {
                        // the last card in the stack has finished its animation so now go reset the _animating flag to false
                        SolebonApp.postRunnable(mFinishAnimation, 250);
                    }
                });
            }
            animSetXY.setDuration(duration);
            animSetXY.playTogether(animX, animY);
            animSetXY.start();
        }
    }

    private Runnable mFinishAnimation = new Runnable() {
        @Override
        public void run() {
            Card card = stack.bottomCard;
            while (card != null) {
                card._animating = false;
                card = card.nextCard;
            }
        }
    };

    public void setPostion(Point point) {
        setPostion(point.x, point.y);
    }

    public void flipToFace(int newFace) {
        face = newFace;

        if (newFace == CARDCLASS_FACE_UP) {
            setBackgroundResource(0);
            setImageDrawable(frontView);

        } else {
            setBackgroundResource(R.drawable.cardback_blank);
            setImageDrawable(backView);
        }
    }

    public void flipAnimatedFromRightToFace(int newFace) {
        flipAnimatedFromRightToFace(newFace, 0);
    }

    public void flipAnimatedFromRightToFace(int newFace, int delay) {
        float cardSpeed = 450f * (100 - Preferences.getCardSpeed())/100f; //0 - 100
        int duration = 50 + (int)cardSpeed; //slowest=500 fastest=50
        _animating = true;

        ObjectAnimator animation = ObjectAnimator.ofFloat(this, "rotationY", 100f, 0f);
        animation.addListener(new SimpleAnimatorListener(){
            @Override
            public void onAnimationEnd(Animator animation) {
                _animating = false;
            }
        });
        animation.setDuration(duration);
        animation.setInterpolator(new AccelerateDecelerateInterpolator());
        animation.start();

        flipToFace(newFace);
    }

    public void flipAnimatedFromLeftToFace(int newFace) {
        flipAnimatedFromLeftToFace(newFace, 0);
    }

    public void flipAnimatedFromLeftToFace(int newFace, int delay) {
        float cardSpeed = 450f * (100 - Preferences.getCardSpeed())/100f; //0 - 100
        int duration = 50 + (int)cardSpeed; //slowest=500 fastest=50
        _animating = true;

        ObjectAnimator animation = ObjectAnimator.ofFloat(this, "rotationY", -100f, 0f);
        animation.addListener(new SimpleAnimatorListener(){
            @Override
            public void onAnimationEnd(Animator animation) {
                _animating = false;
            }
        });
        animation.setDuration(duration);
        animation.setInterpolator(new AccelerateDecelerateInterpolator());
        animation.start();

        flipToFace(newFace);
    }


    // KrazyKlondike
    public void startDropAnimation(int finalX, int finalY) {

    }
    public void stopDropAnimation() {

    }
    public void startHintAnimation() {

    }
    public void stopHintAnimation() {

    }

    public void drawDragShadow(Canvas canvas) {

        draw(canvas);

        if (nextCard != null) {
            canvas.translate(stack.faceUpDisplaceX, stack.faceUpDisplaceY);
            nextCard.drawDragShadow(canvas);
        }
    }

    private void initializeDrag() {
        if (nextCard != null && stack.isWasteStack)
            return;
        origLoc = new PointF(getX(), getY());
        _didMove = false;

        if (nextCard != null) {
            nextCard.initializeDrag();
        }
    }

    public static Card _cardInDrag;
    private boolean _startDrag() {

        if (nextCard != null && stack.isWasteStack)
            return false;
        if (isAnimating())
            return false;
        // Create a new ClipData.
        // This is done in two steps to provide clarity. The convenience method
        // ClipData.newPlainText() can create a plain text ClipData in one step.

        // Create a new ClipData.Item from the ImageView object's tag
        ClipData.Item item = new ClipData.Item(toString());

        // Create a new ClipData using the tag as a label, the plain text MIME type, and
        // the already-created item. This will create a new ClipDescription object within the
        // ClipData, and set its MIME type entry to "text/plain"
        String[] mimeType =  {ClipDescription.MIMETYPE_TEXT_PLAIN};
        ClipData dragData = new ClipData(toString(), mimeType, item);

        SolebonApp.getGameBoard().startDragChild(this, dragData, null, 0);
        _cardInDrag = this;
        _inDrag = true;
        return true;
    }

    public void startDrag() {
        if (nextCard != null && stack.isWasteStack)
            return;
        if (isAnimating())
            return;
        Debugging.d(TAG, "startDrag(),"+toString() );
        setVisibility(View.GONE);
        if (nextCard != null) {
            nextCard.startDrag();
        }
    }

    public void endDrag(final float xPos, final float yPos) {
        Debugging.d(TAG, "endDrag(),"+toString() );
        if (origLoc != null) {
            float diffX = Math.abs(xPos - origLoc.x);
            float diffY = Math.abs(yPos - origLoc.y);
            boolean bAnimate = (diffX > SLOP_X || diffY > SLOP_Y);
            _endDrag(xPos, yPos, bAnimate);

            if (!bAnimate) {
                mOnClickListener.onClick(this);
            }

        } else {
            Log.e(TAG, "endDrag(), origLoc == null");
            setVisibility(View.VISIBLE);
            bringToFront();

            GameCache.getInstance().getActiveGame().onEndDragCardError(this);
        }
    }

    private void _endDrag(float xPos, float yPos, boolean bAnimate) {

        Debugging.d(TAG, "_endDrag(),"+toString() );
        setVisibility(View.VISIBLE);
        bringToFront();

        if (bAnimate) {
            setX(xPos);
            setY(yPos);

            ObjectAnimator animX = ObjectAnimator.ofFloat(this, "x", origLoc.x);
            ObjectAnimator animY = ObjectAnimator.ofFloat(this, "y", origLoc.y);
            AnimatorSet animSetXY = new AnimatorSet();

            if (nextCard == null) {
                animSetXY.addListener(new SimpleAnimatorListener() {
                    @Override
                    public void onAnimationEnd(Animator animation) {
                        // the last card in the stack has finished its animation so now go reset the _animating flag to false
                        SolebonApp.postRunnable(mFinishAnimation, 250);
                    }
                });
            }
            animSetXY.playTogether(animX, animY);
            animSetXY.start();
            _animating = true;

        } else {
            setX(origLoc.x);
            setY(origLoc.y);
        }

        if (nextCard != null) {
            nextCard._endDrag(xPos + stack.faceUpDisplaceX, yPos + stack.faceUpDisplaceY, bAnimate);
        }
    }

    PointF DownPT = new PointF();   // Record Mouse Position When Pressed Down (relative to the Card)
    PointF origLoc;                 // Record Mouse Position When Pressed Down (relative to the Board)

    public PointF getDownPT() {
        return DownPT;
    }
    private float SLOP_X;
    private float SLOP_Y;

    private OnTouchListener mTouchListener = new OnTouchListener() {
        @Override
        public boolean onTouch(View v, MotionEvent event) {

            if (_inDrag || _animating) {
                Debugging.d(TAG, "onTouch(), _inDrag || _animating " + Card.this.toString());
                return false;
            }

            if (face == CARDCLASS_FACE_UP) {
                int eid = event.getAction();
                switch (eid) {
                    case MotionEvent.ACTION_DOWN:
                        Debugging.d(TAG, "onTouch(), ACTION_DOWN " + Card.this.toString());
                        initializeDrag();

                        SLOP_X = SLOP_Y = GameCache.getInstance().getActiveGame().getTapSensitivity();

                        DownPT.x = event.getX();
                        DownPT.y = event.getY();
                        return true;

                    case MotionEvent.ACTION_MOVE:
                        float diffX = Math.abs(event.getX() - DownPT.x);
                        float diffY = Math.abs(event.getY() - DownPT.y);
                        int slop = Utils.getDIP(4);

                        if (!_inDrag && (diffX > slop || diffY > slop)) {
                            if (_startDrag()) {
                                Debugging.d(TAG, "onTouch(), ACTION_MOVE - _startDrag() returned true "+ Card.this.toString());
                                return true;
                            }
                        }
                        break;

                    case MotionEvent.ACTION_UP:
                        Debugging.d(TAG, "onTouch(), ACTION_UP "+Card.this.toString());
                        mOnClickListener.onClick(Card.this);
                        _inDrag = false;
                        return true;
                }
            }
            return false;
        }
    };

    @Override
    public boolean onDrag(View v, DragEvent event) {
        // Defines a variable to store the action type for the incoming event
        final int action = event.getAction();

        // Handles each of the expected events
        switch(action) {
            case DragEvent.ACTION_DRAG_STARTED:
                // Appears to be called on EVERY object in the layout that registered support for the drag operation

                // Determines if this View can accept the dragged data
                if (face == CARDCLASS_FACE_DOWN || nextCard != null) {
                    // we can only drop a card on another face up Top card
                    return false;
                }
                //if (event.getClipDescription().hasMimeType(ClipDescription.MIMETYPE_TEXT_PLAIN)) {
                    // returns true to indicate that the View can accept the dragged data.
                //    return true;

                //}

                // Returns false. During the current drag and drop operation, this View will
                // not receive events again until ACTION_DRAG_ENDED is sent.
                //Log.e(TAG, "onDrag(), ACTION_DRAG_STARTED, "+toString());
                return true;

            case DragEvent.ACTION_DRAG_ENTERED:
                return true;

            case DragEvent.ACTION_DRAG_LOCATION:
                // Ignore the event
                return true;

            case DragEvent.ACTION_DRAG_EXITED:
                return true;

            case DragEvent.ACTION_DROP:
                Log.d(TAG, "DragEvent.ACTION_DROP");
                // Gets the item containing the dragged data
                ClipData.Item item = event.getClipData().getItemAt(0);

                // Gets the text data from the item.
                String dragData = item.getText().toString();
                _inDrag = false;

                if (_cardInDrag != null) {
                    Game game = GameCache.getInstance().getActiveGame();
                    if (game.canDropCard(_cardInDrag, this.stack)) {
                        game.dropCard(_cardInDrag, this.stack);

                    } else {
                        Log.d(TAG, "game.canDropCard() returned false");
                        _cardInDrag.setDidMove(false);
                    }

                } else {
                    Log.e(TAG, "_cardInDrag == null");
                }
                return true;

            case DragEvent.ACTION_DRAG_ENDED:
                // returns true; the value is ignored.
                _inDrag = false;
                return true;
        }

        return false;
    }
}
