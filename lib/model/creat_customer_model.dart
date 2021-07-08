class ImageUpload{
  String? image_url;
  String? image_name;
  ImageUpload.fromJson(Map<String, dynamic>json){
    image_url = json['image_url'];
    image_name = json['image_name'];
  }
}