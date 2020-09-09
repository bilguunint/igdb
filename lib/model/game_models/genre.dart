class GenreModel {
  final int id;
  final String name;

  GenreModel(this.id, this.name);

  GenreModel.fromJson(Map<String, dynamic> json)
   : id = json["id"],
     name = json["name"];
}