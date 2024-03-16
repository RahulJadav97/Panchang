class TithiModel {
  String? responseCode;
  String? message;
  String? status;
  List<Data>? data;

  TithiModel({this.responseCode, this.message, this.status, this.data});

  TithiModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  String? dateColor;
  String? value;

  Data({this.date, this.dateColor, this.value});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateColor = json['date_color'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['date_color'] = this.dateColor;
    data['value'] = this.value;
    return data;
  }
}
