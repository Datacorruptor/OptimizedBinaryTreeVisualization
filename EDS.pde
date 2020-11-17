OptimalTree OTree1, OTree2, OTree3;
int TREE_SIZE=10;
PVector RANDOM_RANGE = new PVector(1, 100);
int anim_speed=1;
Animation Anim;
void setup() {

  Anim = new Animation();
  OTree1 = new OptimalTree();
  OTree2 = new OptimalTree();
  OTree3 = new OptimalTree();
  size(1800, 600);
  textAlign(CENTER, CENTER);
  Anim.transferred=0;
}

void draw() {
  Anim.drawScreen(); 
  if (Anim.play && frameCount%3==0)
    for (int i=0; i<anim_speed; i++)
      Anim.nextFrame();
}

void mouseClicked() {
  Anim.nextFrame();
}

void keyReleased() {
  if (key==ENTER)
    Anim.play=!Anim.play;
  if(Anim.counter>=TREE_SIZE*3)
    setup();
}
