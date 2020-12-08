class Favourite {
  var name = "";
  var duration = "";
  var image = "";
}

class Slider {
  var title = "";
  var subTitle = "";
  var image = "";
}

class DrawerItem {
  var title = "";
  var image;

  var isSelected = false;
}

class ListModel {
  ListModel({this.name, this.duration, this.type, this.description, this.icon});

  var name = "";
  var duration = "";
  var type = "";
  var description = "";
  var icon = "";
}
