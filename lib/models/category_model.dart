class CategoryModel {
  int id;
  String categoryName;
  String categoryDesc;
  int parent;
  Images images;
  CategoryModel({
    this.id,
    this.categoryName,
    this.categoryDesc,
    this.parent,
    this.images,
  });
  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['name'];
    categoryDesc = json['description'];
    parent = json['parent'];
    images = json['image'] != null ? Images.fromJson(json['image']) : null;
  }
}

class Images {
  String url;

  Images.fromJson(Map<String, dynamic> json) {
    url = json['src'];
  }
}
