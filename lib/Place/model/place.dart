class Place {
  String? id;
  String name;
  String description;
  String? urlImage;
  int? likes;
  bool liked;
  List? usersLiked = [];

  Place(
      {required this.name,
        required this.description,
        this.urlImage,
        this.id,
        this.likes,
        this.liked = false,
        this.usersLiked
      });
}

