class ScreenshotModel {
  final int id;
  final String url;
  final String imageId;

  ScreenshotModel(this.id, this.url, this.imageId);

  ScreenshotModel.fromJson(Map<String, dynamic> json)
   : id = json["id"],
     url = json["url"],
     imageId = json["image_id"];
}