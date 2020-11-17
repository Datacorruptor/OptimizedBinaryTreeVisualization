//класс отвечающий за оптимизацию бинарного дерева поиска
class OptimalTree {

  Node Root;//корень дерева

  //при создании дерева просто делаем пустой корень
  public OptimalTree() {
    Root = new Node();
  }
  
  //оптимизация бинарного дерева поиска
  void Optimize()
  {
    IntList values = GetValuesSymmetrical(Root);//собираем значения дерева
    IntList indx = GenerateOptimalIndecies(Get2DOptimal(values), 0, values.size());//по значениям генерируем оптимальные индексы
    //по сгенерированным индексам производим заполнение дерева
    Root= new Node();
    for (int i =0; i<indx.size(); i++)
      Root.AddChild(new Node(values.get(indx.get(i))));
  }

  //получение значений дерева симметричным обходом
  IntList GetValuesSymmetrical(Node Root)
  {
    IntList res= new IntList();
    if (Root==null) return res;
    res.append(GetValuesSymmetrical(Root.Rebenok));//сначала дети слева
    if (!Root.empty) res.append(Root.value);//потом сам узел
    if (Root.Rebenok!=null) res.append(GetValuesSymmetrical(Root.Rebenok.Brat));//потом дети справа
    return res;
  }
  
  //получение массива стоимости для оптимальных поддеревьев
  PVector [][] Get2DOptimal(IntList values) {
    //Подготовка массива значений дерева
    values.sort();
    //Инициализация массива стоимости для оптимальных поддеревьев
    PVector [][] c = new PVector [values.size()+1][values.size()+1];
    for (int i=0; i<=values.size(); i++)
      for (int j=0; j<=values.size(); j++)
        c[i][j]=new PVector(0, -1);  
    //Заполнение массива стоимости для оптимальных поддеревьев
    for (int k=1; k<=values.size(); k++) {
      for (int i=0; i<=values.size()-k; i++) {
        int j=i+k;
        //Поиск веса по формуле суммы
        int w0=0;
        for (int n=i; n<j; n++)
          w0+=values.get(n)%10;
        //Нахождение оптимального(минимального) варианта для корня поддерева
        PVector min = new PVector(c[i][i].x+c[i+1][j].x, i);
        for (int n=i+1; n<j; n++)
          if (c[i][n].x+c[n+1][j].x<min.x) min = new PVector(c[i][n].x+c[n+1][j].x, n);
        min.x+=w0;
        c[i][j]=min;
      }
    }
    return c;
  }
  //построение Массива индексов для заполнения дерева по массиву стоимости для оптимальных поддеревьев
  IntList GenerateOptimalIndecies(PVector[][] c, int x, int y) {
    IntList res = new IntList();
    if (x==y) return res;
    res.append(int(c[x][y].y));//сначала добавляем себя
    res.append(GenerateOptimalIndecies(c, x, int(c[x][y].y)));//затем всех детей слева
    res.append(GenerateOptimalIndecies(c, int(c[x][y].y+1), y));//затем всех детей справа
    return res;
  }
}
