class BaseOptionDropdown {
  String? id;
  String? name;
  String? image;
  dynamic data;

  BaseOptionDropdown({this.id, this.name, this.image, this.data});

  BaseOptionDropdown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    data = json['data'];
  }
}