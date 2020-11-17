//класс узла дерева со связями левый сын, правый брат
class Node{
  
  int value;//значение узла
  boolean empty;//флаг "болванка"
  Node Rebenok;//указатель на Ребёнка
  Node Brat;//указатель на Брата
  //конструктор по значению
  public Node(int value){
    this.value=value;
    empty=false;
    Rebenok=null;
    Brat=null;
  }
  //конструктор по умолчанию(создаёт "болванку")
  public Node(){
    this.value=-1;
    empty=true;
    Rebenok=null;
    Brat=null;
  }
  //добавление узла-сына к узлу-родителю
  void AddChild(Node child){
    if (empty){//если сам узел родитель болванка, то он становиться сыном и перестаёт быть болванкой
      value=child.value;
      empty=false;
    } else if (child.value>value){//если значение узла больше родителя, то передаём задачу добавления узла ребёнку справа, заполняя левого ребенка, если он пустой "болванкой" 
      if (Rebenok==null) Rebenok = new Node();
      if (Rebenok.Brat==null) Rebenok.Brat = child;
      else Rebenok.Brat.AddChild(child);
    } else{//если значение мелньше или равно, то передаём задачу добавления ребёнку слева
      if (Rebenok==null) Rebenok=child;
      else Rebenok.AddChild(child);
    }
  }
}
