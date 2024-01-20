class GetCityByDistrictModel {
  String? responseCode;
  String? message;
  String? status;
  List<City>? city;

  GetCityByDistrictModel(
      {this.responseCode, this.message, this.status, this.city});

  GetCityByDistrictModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    if (json['City'] != null) {
      city = <City>[];
      json['City'].forEach((v) {
        city!.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.city != null) {
      data['City'] = this.city!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  String? id;
  String? districtId;
  String? name;

  City({this.id, this.districtId, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['DistrictId'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['DistrictId'] = this.districtId;
    data['Name'] = this.name;
    return data;
  }
}
