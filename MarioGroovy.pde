import processing.sound.*;
SoundFile song;
import gifAnimation.*;

Gif myAnimation; // Variável para a animação GIF
PImage backgroundImg;
PImage marioPoseLeft, marioPoseRight;
PImage[] marioStepLeft = new PImage[4];
PImage[] marioStepRight = new PImage[4];
PImage titleImg;

int x = 422;
int y = 333;
int speed = 2;
boolean movingLeft = false;
boolean stopLeft = false;
boolean movingRight = false;
boolean stopRight = false;
boolean dancing = false;

void setup() {
  size(876, 493);

  myAnimation = new Gif(this, "mario_dance.gif");
  myAnimation.play();
  
  song = new SoundFile(this, "song.mp3");
  song.play();

  backgroundImg = loadImage("background.png");
  marioPoseLeft = loadImage("mario_pose_left.png");
  marioPoseRight = loadImage("mario_pose_right.png");

  for (int i = 0; i < 4; i++) {
    marioStepLeft[i] = loadImage("mario_step_left_" + (i+1) + ".png");
    marioStepRight[i] = loadImage("mario_step_right_" + (i+1) + ".png");
  }

  titleImg = loadImage("title.png");
}

void draw() {
  background(255);
  if (dancing) {
    image(backgroundImg, 0, 0);
    image(titleImg, 223, 94);
    image(myAnimation, x, y);
  } else {
    image(backgroundImg, 0, 0);
    image(titleImg, 223, 94);

    if (movingLeft) {
      x = constrain(x - speed, 0, width - marioStepLeft[0].width);
      animateLeft();
    } else if (movingRight) {
      x = constrain(x + speed, 0, width - marioStepRight[0].width);
      animateRight();
    } else {
      if (stopLeft == false && stopRight == false) {
        if (x % 2 == 0) {
          image(marioPoseRight, x, y);
        } else {
          image(marioPoseLeft, x, y);
        }
      } else {
        if (stopLeft == true) {
          image(marioPoseLeft, x, y);
        } else {
          image(marioPoseRight, x, y);
        }
      }
    }
  }
}

void keyPressed() {
  if (keyCode == LEFT) {
    movingLeft = true;
    movingRight = false;
    stopLeft = true;
    stopRight = false;
  } else if (keyCode == RIGHT) {
    movingRight = true;
    movingLeft = false;
    stopLeft = false;
    stopRight = true;
  } else if (key == 'd' && !movingLeft && !movingRight) {
    dancing = !dancing;
  }
}

void keyReleased() {
  movingLeft = false;
  movingRight = false;

  if (x % 2 == 0) {
    image(marioPoseRight, x, y);
  } else {
    image(marioPoseLeft, x, y);
  }
}

void animateLeft() {
  movingLeft = true;
  movingRight = false;
  int index = frameCount % 20 / 5;
  image(marioStepLeft[index], x, y);
}

void animateRight() {
  movingLeft = false;
  movingRight = true;
  int index = frameCount % 20 / 5;
  image(marioStepRight[index], x, y);
}
