enum CategoryType { animales, politica }

class Category {
  CategoryType type;
  String name;
  String icon;

  Category({this.type, this.name, this.icon});
}

// implements categories class
extension Categories on List<Category> {
  load() {
    List<Category> temp;
    this.addAll(temp);
  }
}

/*
class Categories extends Function {
  
  List<Category> _categories;
  
  Categories() {
    //fill data from firestore
    //..
  }

  List<Category> call() {
    return _categories;
  }


  
}
*/
class Initiative {
  String title;
  String destinatary;
  Category category;

  Initiative({this.title, this.destinatary, this.category});
}
