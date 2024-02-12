class WeeklyPredictionModel {
  String? status;
  int? responseCode;
  String? responseMessage;
  List<Data>? data;

  WeeklyPredictionModel(
      {this.status, this.responseCode, this.responseMessage, this.data});

  WeeklyPredictionModel.fromJson(Map<String, dynamic> json) {
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
  String? sunsignID;
  String? sunsignKey;
  String? sunsignName;
  String? luckyNumber;
  String? luckyColor;
  String? luckyMonths;
  String? luckyDays;
  String? description;

  Data(
      {this.sunsignID,
        this.sunsignKey,
        this.sunsignName,
        this.luckyNumber,
        this.luckyColor,
        this.luckyMonths,
        this.luckyDays,
        this.description});

  Data.fromJson(Map<String, dynamic> json) {
    sunsignID = json['SunsignID'];
    sunsignKey = json['SunsignKey'];
    sunsignName = json['SunsignName'];
    luckyNumber = json['LuckyNumber'];
    luckyColor = json['LuckyColor'];
    luckyMonths = json['LuckyMonths'];
    luckyDays = json['LuckyDays'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SunsignID'] = this.sunsignID;
    data['SunsignKey'] = this.sunsignKey;
    data['SunsignName'] = this.sunsignName;
    data['LuckyNumber'] = this.luckyNumber;
    data['LuckyColor'] = this.luckyColor;
    data['LuckyMonths'] = this.luckyMonths;
    data['LuckyDays'] = this.luckyDays;
    data['Description'] = this.description;
    return data;
  }
}
