class GetStateByCountryModel {
  String? responseCode;
  String? message;
  String? status;
  List<State>? state;

  GetStateByCountryModel(
      {this.responseCode, this.message, this.status, this.state});

  GetStateByCountryModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    if (json['State'] != null) {
      state = <State>[];
      json['State'].forEach((v) {
        state!.add(new State.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.state != null) {
      data['State'] = this.state!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class State {
  String? id;
  String? countryId;
  String? name;

  State({this.id, this.countryId, this.name});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['CountryId'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CountryId'] = this.countryId;
    data['Name'] = this.name;
    return data;
  }
}
