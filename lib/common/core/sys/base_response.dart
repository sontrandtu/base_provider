class BaseResponse {
  String? version;
  dynamic data;
  String? errorMsg;
  int? error;

  BaseResponse({this.version, this.data, this.errorMsg, this.error});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    data = json['data'];
    if (json['error'] != 0 && json['error'] != null) {
      errorMsg = 'Error';
      errorMsg = json['error_msg'];
    }
    if (json['error'] == 0 || json['error'] == null) {
      errorMsg = 'Success';
      errorMsg = json['error_msg'];
    }

    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error_msg'] = this.errorMsg;
    data['error'] = this.error;
    return data;
  }
}
