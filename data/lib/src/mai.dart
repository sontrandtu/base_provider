import 'dart:convert';

main(){
print(jsonDecode(jsonEncode(Bar(value: 'Tai',value1: 1,value2: false))).runtimeType);
}

class Bar{
  String? value;
  int? value1;
  bool? value2;

  Bar({this.value, this.value1, this.value2});

  Bar.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    value1 = json['value1'];
    value2 = json['value2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['value1'] = this.value1;
    data['value2'] = this.value2;
    return data;
  }
}