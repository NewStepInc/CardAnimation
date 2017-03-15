package com.ashwin.cardanimation;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void onWordAnimation(View view) {
        transitActivity(AnimationActivity.ANIMATION_WORD);
    }

    public void onWaterFallAnimation(View view) {
        transitActivity(AnimationActivity.ANIMATION_WATERFALL);
    }

    public void onWinningAnimation(View view) {
        transitActivity(AnimationActivity.ANIMATION_WINNING);
    }

    public void onBouncingAnimation(View view) {
        transitActivity(AnimationActivity.ANIMATION_BOUNCING);
    }

    private void transitActivity(int animationType) {
        Intent intent = new Intent(getApplicationContext(), AnimationActivity.class);
        intent.putExtra(AnimationActivity.ANIMATION_TYPE, animationType);
        startActivity(intent);
    }
}
