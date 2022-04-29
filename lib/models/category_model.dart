

class CategoryModel {
  String? id;
  String? icon;
  String? title;
  String? color;

  CategoryModel({this.id, this.icon, this.title, this.color});

  CategoryModel.fromFireStore(Map<String, dynamic> doc) {
    id = doc['id'];
    icon = doc['icon'];
    title = doc['title'];
    color = doc['color'];
  }
}
