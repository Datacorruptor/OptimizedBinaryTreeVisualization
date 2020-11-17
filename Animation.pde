//класс отвечающий за анимацию
class Animation {
  //анимационный счётчик, ограничитель
  int counter, transferred;
  boolean play = false;//идёт ли автоматическое проигрывание
  
  Animation()
  {
    counter=0;
    transferred=0;
    play = false;
  }
  //следующий кадр
  void nextFrame()
  {
    if (counter<TREE_SIZE) {
      OTree1.Root.AddChild(new Node(int(random(1,100))));
      OTree2.Root.AddChild(new Node(int(random(1,100))));
      OTree1.Optimize();
      OTree2.Optimize();
    }
    if (counter==0) println();
    counter+=1;
    if (counter==TREE_SIZE) play = false;
    if (counter==TREE_SIZE*3) play = false;

    if (Anim.counter>TREE_SIZE) {
      Symmetrical(OTree1.Root, TREE_SIZE);
      Symmetrical(OTree2.Root, TREE_SIZE);
    }
    if (counter==TREE_SIZE*2) println();
  }
  
  //нарисовать дерево
  void ShowTree(Node Root, int x, int y, int size, int Width) {
    fill(255);
    if (Root.empty) fill(51);
    circle(x, y, size);
    fill(0);
    if (Root.empty) fill(51);
    
    if(size/2<2)textSize(2);
    else textSize(size/2);
    
    text(Root.value, x, y);
    if (Root.Rebenok==null) return;
    else if (Root.Rebenok.Brat==null) {
      line(x, y+size/2, x-Width/2, y+size*2.6);
      ShowTree(Root.Rebenok, x-Width/2, int(y+size*2.6), int(size*0.8), Width/2);
    } else {
      line(x, y+size/2, x-Width/2, y+size*2.6);
      line(x-Width/2, y+size*2.6, x+Width/2, y+size*2.6);
      ShowTree(Root.Rebenok, x-Width/2, int(y+size*2.6), int(size*0.8), Width/2);
      ShowTree(Root.Rebenok.Brat, x+Width/2, int(y+size*2.6), int(size*0.8), Width/2);
    }
  }

  //симметричный кадровый перебор
  void Symmetrical(Node Root, int Animation_offset) {
    if (Root == null) return;
    Symmetrical(Root.Rebenok, Animation_offset);
    if (Anim.counter-Animation_offset>Anim.transferred && !Root.empty) {
      print(Root.value+" ");
      Root.empty=true;
      Anim.transferred+=1;

      OTree3.Root.AddChild(new Node(Root.value));
      OTree3.Optimize();
    }
    if (Root.Rebenok != null)
      Symmetrical(Root.Rebenok.Brat, Animation_offset);
  }
  
  //рисование экрана
  void drawScreen() {
    background(51);
    
    ShowTree(OTree1.Root, width/2-width/3, 50, 50, width/6);
    line(width/3, 0, width/3, height);
    ShowTree(OTree2.Root, width/2, 50, 50, width/6);
    line(width/3*2, 0, width/3*2, height);
    ShowTree(OTree3.Root, width/2+width/3, 50, 50, width/6);
    
    textSize(20);
    fill(255);
    text(counter,100,30);
  }
}
