class UserDetailModel {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? token;
  String? avatar;
  String? birthday;
  String? address;
  String? gender;
  String? createdAt;
  String? updatedAt;

  String? password;
  String? confirmPassword;
  String? otp;
  String? message;
  List<String>? problemIds;

  void setAvatar(String? avatar) => this.avatar = avatar;

  UserDetailModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.token,
    this.avatar,
    this.birthday,
    this.address,
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.password,
    this.confirmPassword,
    this.otp,
    this.message,
    this.problemIds,
  });

  UserDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    token = json['token'];
    avatar = json['avatar'];
    birthday = json['birthday'];
    address = json['address'];
    gender = json['gender'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
    otp = json['otp'];
    message = json['message'];
    if (json['problem_ids'] != null) {
      problemIds = json['problem_ids'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['token'] = token;
    data['avatar'] = avatar;
    data['birthday'] = birthday;
    data['address'] = address;
    data['gender'] = gender;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    data['otp'] = otp;
    data['message'] = message;
    data['problem_ids'] = problemIds;
    return data;
  }
}
