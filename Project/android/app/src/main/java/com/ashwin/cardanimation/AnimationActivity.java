package com.ashwin.cardanimation;

import android.animation.Animator;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.animation.ValueAnimator;
import android.content.Context;
import android.content.Intent;
import android.graphics.Point;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Handler;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.View;
import android.view.WindowManager;
import android.view.animation.DecelerateInterpolator;
import android.view.animation.LinearInterpolator;
import android.widget.RelativeLayout;
import android.widget.Toast;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class AnimationActivity extends AppCompatActivity {
    public static final String ANIMATION_TYPE = "ANIMATION_TYPE";

    public static final int ANIMATION_NONE = 0;
    public static final int ANIMATION_WORD = 1;
    public static final int ANIMATION_WATERFALL = 2;
    public static final int ANIMATION_WINNING = 3;
    public static final int ANIMATION_BOUNCING = 4;



    public static final long PERIOD_CARDS_GATHERING = 200;
    public static final long PERIOD_CARDS_WAITING_GATHERED = 1000;
    public static final long PERIOD_CARDS_WAITING_ANIMATED = 3000;

    // Word Animation
    public static final long PERIOD_CARDS_FORM_WORD = 3000;
    // Waterfall Animation
    public static final long PERIOD_CARDS_WATERFALL_PREPARING = 2000;
    public static final long PERIOD_CARDS_WATERFALL = 3000;
    // Waterfall Animation
    public static final long PERIOD_CARDS_WINNING_PREPARING = 2000;
    public static final long PERIOD_CARDS_WINNING = 6000;
    public static final float ROTATION_CARDS_WINNING = (float) (Math.PI / 3);
    public static final long PERIOD_CARDS_WINNING_WINK = 150;
    // Bouncing Animation
    public static final long PERIOD_CARDS_BUNCING = 30000;

    // For test. Not necessary in production version.
    int mAnimationType = ANIMATION_NONE;

    RelativeLayout mGameLayout;
    int mScreenWidth, mScreenHeight;
    int mCardWidth, mCardHeight;
    List<Point> mCardGatheredPositions = new ArrayList<>();
    List<Card> mCardsList = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_animation);

        getSupportActionBar().hide();


        // TODO
        Intent intent = getIntent();
        mAnimationType = intent.getIntExtra(ANIMATION_TYPE, ANIMATION_NONE);

        mGameLayout = (RelativeLayout) findViewById(R.id.game_layout);
        initCards();
    }
    private void addCard(Card card, int xPos, int yPos) {
        mCardsList.add(card);
        mGameLayout.addView(card);

        card.setLayoutParams(new RelativeLayout.LayoutParams(mCardWidth, mCardHeight));
        card.setPosition(xPos, yPos);
    }

    private void initValues() {
        mCardsList.clear();
        Point screenSize = getDimentionalSize();
        mScreenWidth = screenSize.x;
        mScreenHeight = screenSize.y;
        mCardWidth = mScreenWidth / 8;
        mCardHeight = mCardWidth * 104 / 80;

        mCardGatheredPositions.clear();
        for (int i = 0; i < 4; i ++)
            mCardGatheredPositions.add(new Point(mCardWidth / 8 + i * mCardWidth * 9 / 8, mCardHeight / 5));
    }

    // For test alone
    private void initCards() {

        initValues();

        for (int i = 1; i <= 4; i++) {
            for (int j = 1; j <= 13; j++) {
                Card card = Card.createCard(getApplicationContext(), j, i, 2);
                addCard(card, i * mCardWidth * 9 / 8, mCardHeight * 2 + j * mCardHeight / 3);
            }
        }
    }

    public void startAnimation(final View view) {

        AnimatorSet animatorSet = (AnimatorSet) getAnimation(mAnimationType);

        animatorSet.addListener(new Animator.AnimatorListener() {
            @Override
            public void onAnimationStart(Animator animation) {
                view.setVisibility(View.GONE);
            }

            @Override
            public void onAnimationEnd(Animator animation) {
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        Toast.makeText(getApplicationContext(), "Animation has been played successfully!", Toast.LENGTH_SHORT).show();
                    }
                }, PERIOD_CARDS_WAITING_ANIMATED);
            }

            @Override
            public void onAnimationCancel(Animator animation) {

            }

            @Override
            public void onAnimationRepeat(Animator animation) {

            }
        });

        animatorSet.start();
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////
    // Animations Creation
    ////////////////////////////////////////////////////////////////////////////////////////////////

    private Card findCard(int suit, int rank) {
        for (int i = 0; i < mCardsList.size(); i++) {
            Card card = mCardsList.get(i);
            if (card.suit == suit && card.rank == rank)
                return card;
        }
        return null;
    }

    private Animator getAnimation(int animationType) {
        List<Animator> animatorSetList = new ArrayList<>();

        if (animationType == ANIMATION_WORD) {
            animatorSetList.add(getGatheringAnimation());
            animatorSetList.add(getWordAnimation());
        } else if (animationType == ANIMATION_WINNING) {
            animatorSetList.add(getGatheringAnimation());
            animatorSetList.add(getWinningPrepareAnimation());
            animatorSetList.add(getWinningAnimation());
        } else if (animationType == ANIMATION_WATERFALL) {
            animatorSetList.add(getGatheringAnimation());
            animatorSetList.add(getWaterFallPrepareAnimation());
            animatorSetList.add(getWaterFallAnimation());
        } else if (animationType == ANIMATION_BOUNCING) {
            animatorSetList.add(getGatheringAnimation());
            animatorSetList.add(getBouncingAnimation());
        }


        AnimatorSet animatorSet = new AnimatorSet();
        animatorSet.playSequentially(animatorSetList);
        return animatorSet;
    }

    private Animator getGatheringAnimation() {
        List<Animator> animatorList = new ArrayList<>();
        int posNums[] = {4, 2, 1, 3};
        for (int i = 0; i < mCardsList.size(); i++) {
            Card card = mCardsList.get(i);
            Point pointTo = mCardGatheredPositions.get(posNums[card.suit - 1] - 1);
            animatorList.add(ObjectAnimator
                    .ofFloat(card, "x", card.getX(), pointTo.x)
                    .setDuration(PERIOD_CARDS_GATHERING));
            animatorList.add(ObjectAnimator
                    .ofFloat(card, "y", card.getY(), pointTo.y)
                    .setDuration(PERIOD_CARDS_GATHERING));
        }

        AnimatorSet animatorSet = new AnimatorSet();
        animatorSet.playTogether(animatorList);

        return animatorSet;
    }

    private Animator getWordAnimation() {
        String strings[] = {"WINNING BIG IN", "THE NEW YEAR!"};

        float zoomIn = 11;
        float xScale = 0.7f;
        float lineSpace = mCardHeight / 10;
        float letterSpace = mCardWidth / 5;

        CardAlphabet.init(mCardWidth / zoomIn, mCardHeight / zoomIn);
        CardAlphabet.lettersWidth += letterSpace;
        CardAlphabet.lettersHeight += lineSpace;

        List<Animator> animatorList = new ArrayList<>();
        Random random = new Random();

        int curCardNum = 0;
        float y = mScreenHeight / 2 - (float) strings.length / 2 * CardAlphabet.lettersHeight - CardAlphabet.lettersHeight / 2;
        for (String string : strings) {
            float x = mScreenWidth / 2 - (float) string.length() / 2 * CardAlphabet.lettersWidth - (CardAlphabet.lettersWidth / 2 - letterSpace);
            for (char letter : string.toCharArray()) {
                if (letter == ' ') {
                    x += CardAlphabet.lettersWidth;
                    continue;
                }
                Letter letter1 = CardAlphabet.Letters.get(String.valueOf(letter));
                for (int i = 0; i < letter1.NumCards; i ++) {
                    Card card;
                    if (curCardNum == mCardsList.size()) {
                        card = Card.createCard(getApplicationContext(), random.nextInt(13) + 1, random.nextInt(4) + 1, 2);
                        addCard(card, mScreenWidth, 0);
                    } else
                        card = mCardsList.get(curCardNum);

                    float toX = x + letter1.cardPositionXForIndex(i) - mCardWidth / 2;
                    float toY = y + letter1.cardPositionYForIndex(i) - mCardHeight / 2;
                    float toAngleInDegree = (float) Math.toDegrees(letter1.cardPositionRotationForIndex(i));

                    animatorList.add(ObjectAnimator
                            .ofFloat(card, "x", mScreenWidth / 2 + (toX - mScreenWidth / 2) * xScale)
                            .setDuration(PERIOD_CARDS_FORM_WORD));

                    animatorList.add(ObjectAnimator
                            .ofFloat(card, "y", toY)
                            .setDuration(PERIOD_CARDS_FORM_WORD));

                    animatorList.add(ObjectAnimator
                            .ofFloat(card, "scaleX", 1 / zoomIn)
                            .setDuration(PERIOD_CARDS_FORM_WORD));

                    animatorList.add(ObjectAnimator
                            .ofFloat(card, "scaleY", 1 / zoomIn)
                            .setDuration(PERIOD_CARDS_FORM_WORD));

                    if (toAngleInDegree != 0)
                        animatorList.add(ObjectAnimator
                                .ofFloat(card, "rotation", toAngleInDegree)
                                .setDuration(PERIOD_CARDS_FORM_WORD));

                    curCardNum++;
                }
                x += CardAlphabet.lettersWidth;
            }

            y += CardAlphabet.lettersHeight;
        }

        AnimatorSet animatorSet = new AnimatorSet();
        animatorSet.playTogether(animatorList);
        animatorSet.setStartDelay(PERIOD_CARDS_WAITING_GATHERED);
        return animatorSet;
    }

    private Animator getWaterFallPrepareAnimation() {
        Random random = new Random();

        List<Animator> animatorList = new ArrayList<>();
        for (int i = 0; i < mCardsList.size(); i++) {
            final Card card = mCardsList.get(i);
            int x = random.nextInt(mScreenWidth - mCardWidth);

            animatorList.add(ObjectAnimator
                    .ofFloat(card, "x", x)
                    .setDuration(PERIOD_CARDS_WATERFALL_PREPARING));

            final int yDiff = random.nextInt(mCardHeight / 2);
            ValueAnimator valueAnimator = ValueAnimator.ofFloat((float) Math.PI * 5, 0).setDuration(PERIOD_CARDS_WATERFALL_PREPARING);
            valueAnimator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                @Override
                public void onAnimationUpdate(ValueAnimator animation) {
                    float radian = (float) animation.getAnimatedValue();
                    int diff = (int) (Math.abs(Math.sin(radian)) * yDiff * (1 - radian / (Math.PI * 5)));
                    card.setY(mCardGatheredPositions.get(0).y + diff);
                }
            });
            animatorList.add(valueAnimator);
        }

        AnimatorSet animatorSet = new AnimatorSet();
        animatorSet.playTogether(animatorList);
        animatorSet.setStartDelay(PERIOD_CARDS_WAITING_GATHERED);

        animatorSet.addListener(new Animator.AnimatorListener() {
            @Override
            public void onAnimationStart(Animator animation) {
                try {
                    Thread.sleep(PERIOD_CARDS_GATHERING + PERIOD_CARDS_WAITING_GATHERED);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }

                Random random = new Random();
                // shuffle cards = change orders of cards
                mGameLayout.removeAllViews();
                for (int i = mCardsList.size() - 1; i >= 1; i--) {
                    int j = random.nextInt(i);

                    // exchange Card(i) vs Card(j)
                    Card card = mCardsList.get(j);
                    mCardsList.set(j, mCardsList.get(i));
                    mCardsList.set(i, card);

                    mGameLayout.addView(card);
                }
            }

            @Override
            public void onAnimationEnd(Animator animation) {

            }

            @Override
            public void onAnimationCancel(Animator animation) {

            }

            @Override
            public void onAnimationRepeat(Animator animation) {

            }
        });

        return animatorSet;
    }

    private Animator getWaterFallAnimation() {
        final List<Float> anglesInRadianList = new ArrayList<>();
        Random random = new Random();
        // -pi/4 ~ pi/4
        for (int i = 0; i < mCardsList.size(); i++) {
            anglesInRadianList.add((float) ((1 - (float) random.nextInt(100) / 50) * Math.PI / 4));
        }
        final float speed = (float) mCardWidth / 25;

        List<Animator> animatorList = new ArrayList<>();
        for (int i = 0; i < mCardsList.size(); i++) {
            final Card card = mCardsList.get(i);
            long duration = (long) (PERIOD_CARDS_WATERFALL * (1 + (float) random.nextInt(50) / 100));

            animatorList.add(ObjectAnimator
                    .ofFloat(card, "y", mScreenHeight)
                    .setDuration(duration));

            ValueAnimator valueAnimator = ValueAnimator.ofFloat(0, mScreenHeight).setDuration(duration);
            final int finalI = i;
            valueAnimator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                @Override
                public void onAnimationUpdate(ValueAnimator animation) {
                    float x = (float) (card.getX() + speed * Math.sin(anglesInRadianList.get(finalI)));
                    card.setX(x);
                    if (x < 0 || x > mScreenWidth - mCardWidth) {
                        anglesInRadianList.set(finalI, -anglesInRadianList.get(finalI));
                    }
                }
            });
            animatorList.add(valueAnimator);
        }

        AnimatorSet animatorSet = new AnimatorSet();
        animatorSet.playTogether(animatorList);
        return animatorSet;
    }

    private Animator getWinningPrepareAnimation() {
        List<Animator> animatorList = new ArrayList<>();
        for (int i = 0; i < mCardsList.size(); i++) {
            Card card = mCardsList.get(i);
            Point point = getWinningCardPosition(card, 0);    // 0 radian: init state
            float cardRotationInDegree = getWinningCardRotationInDegree(card, 0);

            animatorList.add(ObjectAnimator
                    .ofFloat(card, "x", point.x)
                    .setDuration(PERIOD_CARDS_WINNING_PREPARING));
            animatorList.add(ObjectAnimator
                    .ofFloat(card, "y", point.y)
                    .setDuration(PERIOD_CARDS_WINNING_PREPARING));
            animatorList.add(ObjectAnimator
                    .ofFloat(card, "rotation", cardRotationInDegree)
                    .setDuration(PERIOD_CARDS_WINNING_PREPARING));
        }

        AnimatorSet animatorSet = new AnimatorSet();
        animatorSet.playTogether(animatorList);
        animatorSet.setStartDelay(PERIOD_CARDS_WAITING_GATHERED);

        animatorSet.addListener(new Animator.AnimatorListener() {
            @Override
            public void onAnimationStart(Animator animation) {
                try {
                    Thread.sleep(PERIOD_CARDS_GATHERING + PERIOD_CARDS_WAITING_GATHERED);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }

                Random random = new Random();
                // sort cards
                mGameLayout.removeAllViews();
                int suits[] = {Card.CARDCLASS_SUIT_SPADE, Card.CARDCLASS_SUIT_HEART, Card.CARDCLASS_SUIT_DIAMOND, Card.CARDCLASS_SUIT_CLUB};
                for (int i = 0; i < 4; i++) {
                    for (int j = 13; j > 0; j--) {
                        Card card = findCard(suits[i], j);
                        if (card == null)
                            continue;

                        mGameLayout.addView(card);
                    }
                }
            }

            @Override
            public void onAnimationEnd(Animator animation) {

            }

            @Override
            public void onAnimationCancel(Animator animation) {

            }

            @Override
            public void onAnimationRepeat(Animator animation) {

            }
        });

        return animatorSet;
    }

    private Animator getWinningAnimation() {
        ValueAnimator valueAnimator = ValueAnimator.ofFloat(0, 2 * (float) Math.PI * 3).setDuration(PERIOD_CARDS_WINNING);
        valueAnimator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
            @Override
            public void onAnimationUpdate(ValueAnimator animation) {
                float value = (float) animation.getAnimatedValue();
                float radian = (float) (Math.sin(value % (Math.PI * 2)) * ROTATION_CARDS_WINNING);
                for (int i = 0; i < mCardsList.size(); i++) {
                    Card card = mCardsList.get(i);
                    Point cardPosition = getWinningCardPosition(card, radian);
                    float cardRotation = getWinningCardRotationInDegree(card, radian);
                    card.setPosition(cardPosition);
                    card.setRotation(cardRotation);
                }
            }
        });
        valueAnimator.setInterpolator(new LinearInterpolator());
        valueAnimator.addListener(new Animator.AnimatorListener() {
            @Override
            public void onAnimationStart(Animator animation) {
            }

            @Override
            public void onAnimationEnd(Animator animation) {
                // wink card
                final Card winkCard = findCard(Card.CARDCLASS_SUIT_CLUB, 13);
                if (winkCard == null)
                    return;
                final Context context = getApplicationContext();
                int id = context.getResources().getIdentifier("cardback_pattern1", "drawable", context.getPackageName());
                Drawable drawable = ContextCompat.getDrawable(context, id);
                winkCard.setImageDrawable(drawable);
                winkCard.setColorFilter(0xff550000, PorterDuff.Mode.OVERLAY);

                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        // restore winked card
                        String filename = Card.makeImageNameForRank(13, Card.CARDCLASS_SUIT_CLUB, 2);
                        int id = context.getResources().getIdentifier(filename, "drawable", context.getPackageName());
                        Drawable drawable = ContextCompat.getDrawable(context, id);
                        winkCard.setColorFilter(null);
                        winkCard.setImageDrawable(drawable);
                    }
                }, PERIOD_CARDS_WINNING_WINK);
            }

            @Override
            public void onAnimationCancel(Animator animation) {

            }

            @Override
            public void onAnimationRepeat(Animator animation) {

            }
        });

        return valueAnimator;
    }

    private Point getWinningCardPosition(Card card, float radian) {
        int centerX = mScreenWidth / 2;
        int centerY = mScreenHeight / 2;
        float radius = (float) mCardWidth * 12 / 5;

        float distance;
        double angle;
        switch (card.suit) {
            case Card.CARDCLASS_SUIT_SPADE:
                if (card.rank == 13) {
                    distance = radius * 3 / 7;
                    angle = Math.PI / 2 - Math.PI / 4;
                } else {
                    distance = radius * 4 / 9;
                    centerX -= Math.sin(radian) * distance;
                    centerY -= Math.cos(radian) * distance;
                    angle = radian + -Math.PI / 3 - Math.PI / 3 / 11 * (card.rank - 1);
                    distance *= 2;
                    Point point = new Point();
                    point.x = (int) (centerX + Math.cos(angle) * distance) - mCardWidth / 2;
                    point.y = (int) (centerY - Math.sin(angle) * distance) - mCardHeight / 2;
                    return point;
                }
                break;
            case Card.CARDCLASS_SUIT_DIAMOND:
                distance = radius;
                angle = -Math.PI / 2 - Math.PI / 13 * (card.rank - 1);
                break;
            case Card.CARDCLASS_SUIT_HEART:
                distance = radius;
                angle = Math.PI / 2 - Math.PI / 13 * (card.rank - 1);
                break;
            case Card.CARDCLASS_SUIT_CLUB:
                if (card.rank == 13) {
                    distance = radius * 3 / 7;
                    angle = Math.PI / 2 + Math.PI / 4;
                } else {
                    distance = radius + mCardWidth / 2 + mCardHeight * 3 / 7;
                    angle = Math.PI * 3 / 4 - Math.PI / 2 / 11 * (card.rank - 1);
                }
                break;
            default:
                angle = distance = 0;
        }
        angle += radian;

        Point point = new Point();
        point.x = (int) (centerX + Math.cos(angle) * distance) - mCardWidth / 2;
        point.y = (int) (centerY - Math.sin(angle) * distance) - mCardHeight / 2;

        return point;
    }

    private float getWinningCardRotationInDegree(Card card, float radian) {
        double angle;
        switch (card.suit) {
            case Card.CARDCLASS_SUIT_SPADE:
                if (card.rank == 13)
                    angle = Math.PI / 15 - Math.PI;
                else
                    angle = Math.PI / 4 + Math.PI / 2 / 11 * (card.rank - 1) - Math.PI;
                break;
            case Card.CARDCLASS_SUIT_DIAMOND:
                angle = -Math.PI / 2 + Math.PI / 13 * (card.rank - 1);
                break;
            case Card.CARDCLASS_SUIT_HEART:
                angle = Math.PI / 2 + Math.PI / 13 * (card.rank - 1);
                break;
            case Card.CARDCLASS_SUIT_CLUB:
                if (card.rank == 13)
                    angle = Math.PI - Math.PI / 15;
                else
                    angle = Math.PI / 2 - (Math.PI * 3 / 4 - Math.PI / 2 / 11 * (card.rank - 1));
                break;
            default:
                angle = 0;
        }

        return (float) Math.toDegrees(angle - radian);
    }

    private Animator getBouncingAnimation() {
        final float bounceGroundY = mScreenHeight * 5 / 6 - mCardHeight;

        final float xCycleRegular = mScreenWidth * 3 / 4;
        final float xCycleK = mScreenWidth / 3;
        final float xCycleQ = mScreenWidth * 8 / 3;
        final long timeCycleRegular = PERIOD_CARDS_BUNCING * 2 / 15;
        final long timeCycleK = timeCycleRegular / 2;
        final long timeCycleQ = timeCycleRegular * 2;

        final List<Float> initialDestXRegular = new ArrayList<>();
        initialDestXRegular.add(0f);
        initialDestXRegular.add((float) (mScreenWidth / 4 + mCardHeight));
        initialDestXRegular.add((float) (mScreenWidth / 4 + mCardHeight * 2));
        initialDestXRegular.add((float) (mScreenWidth / 4));
        initialDestXRegular.add((float) (mScreenWidth / 4 + mCardHeight * 3));
        final float initialDestXK = mScreenWidth / 6;
        final float initialDestXQ = mScreenWidth * 3 / 4;

        final float amplitudeRegular[] = {bounceGroundY * 2 / 3, bounceGroundY / 2, bounceGroundY / 3};
        final float amplitudeK[] = {bounceGroundY * 6 / 7, bounceGroundY * 5 / 7, bounceGroundY * 4 / 7, bounceGroundY * 3 / 7};
        final float amplitudeQ[] = {bounceGroundY * 4 / 5, bounceGroundY * 3 / 5, bounceGroundY / 2, bounceGroundY * 2 / 5};

        final float startX[] = new float[mCardsList.size()];
        final float startAmplitude[] = new float[mCardsList.size()];
        int posNums[] = {4, 2, 1, 3};
        for (int i = 0; i < mCardsList.size(); i++) {
            Point point = mCardGatheredPositions.get(posNums[mCardsList.get(i).suit - 1] - 1);
            startX[i] = point.x;
            startAmplitude[i] = bounceGroundY - point.y;
        }

        ValueAnimator valueAnimator = ValueAnimator.ofFloat(0, PERIOD_CARDS_BUNCING).setDuration(PERIOD_CARDS_BUNCING);
        valueAnimator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
            @Override
            public void onAnimationUpdate(ValueAnimator animation) {
                long timeGeneral = (long) (float) animation.getAnimatedValue();

                long index[] = {1, 2, 0, 3};
                long delayK = 1000;
                long delayQ = 1100;
                long delayRegular = timeCycleRegular / 4 / 11;

                for (int i = 0; i < mCardsList.size(); i++) {
                    Card card = mCardsList.get(i);

                    long time = timeGeneral;
                    if (card.rank == 13)
                        time -= delayK + delayRegular * index[card.suit - 1];
                    else if (card.rank == 12)
                        time -= delayQ + delayRegular * index[card.suit - 1];
                    else
                        time -= delayRegular * 2 * index[card.suit - 1] + delayRegular * (card.rank - 1);
                    if (time <= 0)
                        continue;

                    double radian = -Math.PI / 2;
                    int bounceCount;
                    float amplitude = 0;
                    float cycleX;
                    float initialX;
                    if (card.rank == 13) {
                        radian += (double) time / timeCycleK * Math.PI * 2;
                        bounceCount = (int) Math.ceil(radian / Math.PI);
                        initialX = initialDestXK;
                        cycleX = (bounceCount == 0) ? (initialX - startX[i]) * 4 : xCycleK;
                        amplitude = (bounceCount == 0) ? startAmplitude[i] : amplitudeK[(bounceCount - 1) % amplitudeK.length];
                    } else if (card.rank == 12) {
                        radian += (double) time / timeCycleQ * Math.PI * 2;
                        bounceCount = (int) Math.ceil(radian / Math.PI);
                        initialX = initialDestXQ;
                        cycleX = (bounceCount == 0) ? (initialX - startX[i]) * 4 : xCycleQ;
                        amplitude = (bounceCount == 0) ? startAmplitude[i] : amplitudeQ[(bounceCount - 1) % amplitudeQ.length];
                    } else {
                        radian += (double) time / timeCycleRegular * Math.PI * 2;
                        bounceCount = (int) Math.ceil(radian / Math.PI);
                        initialX = initialDestXRegular.get(card.suit);
                        cycleX = (bounceCount == 0) ? (initialX - startX[i]) * 4 : xCycleRegular;
                        amplitude = (bounceCount == 0) ? startAmplitude[i] : amplitudeRegular[(bounceCount - 1) % amplitudeRegular.length];
                    }
                    float x, y;
                    x = (float) (initialX + radian / (Math.PI * 2) * cycleX);
                    x = x % ((mScreenWidth - mCardWidth) * 2);
                    if (x > mScreenWidth - mCardWidth)
                        x = (mScreenWidth - mCardWidth) * 2 - x;
                    y = (float) (bounceGroundY - Math.abs(Math.sin(radian) * amplitude));

                    card.setX(x);
                    card.setY(y);
                }
            }
        });

        valueAnimator.setInterpolator(new DecelerateInterpolator());
        valueAnimator.setStartDelay(PERIOD_CARDS_WAITING_GATHERED);

        valueAnimator.addListener(new Animator.AnimatorListener() {
            @Override
            public void onAnimationStart(Animator animation) {
                // sort cards
                mGameLayout.removeAllViews();
                int suits[] = {Card.CARDCLASS_SUIT_HEART, Card.CARDCLASS_SUIT_CLUB, Card.CARDCLASS_SUIT_SPADE, Card.CARDCLASS_SUIT_DIAMOND};
                for (int j = 13; j > 0; j--) {
                    for (int i = 0; i < 4; i++) {
                        Card card = findCard(suits[i], j);
                        if (card == null)
                            continue;

                        mGameLayout.addView(card);
                    }
                }
            }

            @Override
            public void onAnimationEnd(Animator animation) {

            }

            @Override
            public void onAnimationCancel(Animator animation) {

            }

            @Override
            public void onAnimationRepeat(Animator animation) {

            }
        });

        return valueAnimator;
    }

    private Point getDimentionalSize() {
        Context context = getApplicationContext();
        WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
        Display display = wm.getDefaultDisplay();
        int realWidth;
        int realHeight;

        if (Build.VERSION.SDK_INT >= 17){
            //new pleasant way to get real metrics
            DisplayMetrics realMetrics = new DisplayMetrics();
            display.getRealMetrics(realMetrics);
            realWidth = realMetrics.widthPixels;
            realHeight = realMetrics.heightPixels;

        } else if (Build.VERSION.SDK_INT >= 14) {
            //reflection for this weird in-between time
            try {
                Method mGetRawH = Display.class.getMethod("getRawHeight");
                Method mGetRawW = Display.class.getMethod("getRawWidth");
                realWidth = (Integer) mGetRawW.invoke(display);
                realHeight = (Integer) mGetRawH.invoke(display);
            } catch (Exception e) {
                //this may not be 100% accurate, but it's all we've got
                realWidth = display.getWidth();
                realHeight = display.getHeight();
                Log.e("Display Info", "Couldn't use reflection to get the real display metrics.");
            }

        } else {
            //This should be close, as lower API devices should not have window navigation bars
            realWidth = display.getWidth();
            realHeight = display.getHeight();
        }

        return new Point(realWidth, realHeight);
    }

}
