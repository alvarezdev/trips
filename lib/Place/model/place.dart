import '../../User/model/user_model.dart';

class Place {
  String? id;
  String name;
  String description;
  String? urlImage;
  int? likes;

  Place(
      {required this.name,
        required this.description,
        this.urlImage,
        this.id,
        this.likes});
}

