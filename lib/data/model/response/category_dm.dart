
class CategoryDM {
  String? id;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? category;

  CategoryDM(
      {this.id,
        this.name,
        this.slug,
        this.image,
        this.createdAt,
        this.updatedAt});

  CategoryDM.fromJson(dynamic json) {
    id = json["_id"];
    name = json["name"];
    slug = json["slug"];
    image = json["image"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    category = json["category"];
  }
}
