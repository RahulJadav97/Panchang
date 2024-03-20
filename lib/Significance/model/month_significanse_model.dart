class MonthSignificanceModel {
  String? status;
  int? responseCode;
  String? responseMessage;
  List<Data>? data;

  MonthSignificanceModel(
      {this.status, this.responseCode, this.responseMessage, this.data});

  MonthSignificanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  String? title;

  Data({this.date, this.title});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    title = json['Title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['Title'] = this.title;
    return data;
  }
}
