class GetDistrictByStateModel {
  String? responseCode;
  String? message;
  String? status;
  List<District>? district;

  GetDistrictByStateModel(
      {this.responseCode, this.message, this.status, this.district});

  GetDistrictByStateModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    if (json['District'] != null) {
      district = <District>[];
      json['District'].forEach((v) {
        district!.add(new District.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.district != null) {
      data['District'] = this.district!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class District {
  String? id;
  String? stateId;
  String? name;

  District({this.id, this.stateId, this.name});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateId = json['StateId'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['StateId'] = this.stateId;
    data['Name'] = this.name;
    return data;
  }
}
