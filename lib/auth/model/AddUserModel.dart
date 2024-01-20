class AddUserModel {
  String? responseCode;
  String? message;
  String? status;
  UserData? userData;
  String? userToken;

  AddUserModel(
      {this.responseCode,
        this.message,
        this.status,
        this.userData,
        this.userToken});

  AddUserModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    userToken = json['user_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    data['user_token'] = this.userToken;
    return data;
  }
}

class UserData {
  String? id;
  String? fullName;
  String? mobileNo;
  String? email;
  String? country;
  String? state;
  String? district;
  String? city;
  String? birthDate;
  String? password;

  UserData(
      {this.id,
        this.fullName,
        this.mobileNo,
        this.email,
        this.country,
        this.state,
        this.district,
        this.city,
        this.birthDate,
        this.password});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['FullName'];
    mobileNo = json['MobileNo'];
    email = json['Email'];
    country = json['Country'];
    state = json['State'];
    district = json['District'];
    city = json['City'];
    birthDate = json['BirthDate'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['FullName'] = this.fullName;
    data['MobileNo'] = this.mobileNo;
    data['Email'] = this.email;
    data['Country'] = this.country;
    data['State'] = this.state;
    data['District'] = this.district;
    data['City'] = this.city;
    data['BirthDate'] = this.birthDate;
    data['Password'] = this.password;
    return data;
  }
}
