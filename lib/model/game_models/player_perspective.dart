class PlayerPerspectiveModel {
  final int id;
  final String name;

  PlayerPerspectiveModel(this.id, this.name);

  PlayerPerspectiveModel.fromJson(Map<String, dynamic> json)
   : id = json["id"],
     name = json["name"];
}