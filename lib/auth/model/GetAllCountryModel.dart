class GetAllCountryModel {
  String? responseCode;
  String? message;
  String? status;
  List<Country>? country;

  GetAllCountryModel(
      {this.responseCode, this.message, this.status, this.country});

  GetAllCountryModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    if (json['Country'] != null) {
      country = <Country>[];
      json['Country'].forEach((v) {
        country!.add(new Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.country != null) {
      data['Country'] = this.country!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  String? id;
  String? name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    return data;
  }
}
