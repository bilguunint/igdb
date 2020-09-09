class VideoModel {
  final int id;
  final String name;
  final String videoId;

  VideoModel(this.id, this.name, this.videoId);

  VideoModel.fromJson(Map<String, dynamic> json)
   : id = json["id"],
     name = json["name"],
     videoId = json["video_id"];
}