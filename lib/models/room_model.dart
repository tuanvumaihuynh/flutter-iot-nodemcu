class RoomModel {
  String? name;
  int? count;

  RoomModel({this.name, this.count});

  RoomModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json.length;
  }
}
