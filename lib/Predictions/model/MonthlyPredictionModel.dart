class MonthlyPredictionModel {
  String? status;
  int? responseCode;
  String? responseMessage;
  List<Data>? data;

  MonthlyPredictionModel(
      {this.status, this.responseCode, this.responseMessage, this.data});

  MonthlyPredictionModel.fromJson(Map<String, dynamic> json) {
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
  String? sunsignName;
  String? description;
  String? luckyColor;
  String? luckyNumber;
  String? horoscopeDate;
  String? sunsignKey;
  String? startDate;
  String? endDate;

  Data(
      {this.sunsignName,
        this.description,
        this.luckyColor,
        this.luckyNumber,
        this.horoscopeDate,
        this.sunsignKey,
        this.startDate,
        this.endDate});

  Data.fromJson(Map<String, dynamic> json) {
    sunsignName = json['SunsignName'];
    description = json['Description'];
    luckyColor = json['LuckyColor'];
    luckyNumber = json['LuckyNumber'];
    horoscopeDate = json['HoroscopeDate'];
    sunsignKey = json['SunsignKey'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SunsignName'] = this.sunsignName;
    data['Description'] = this.description;
    data['LuckyColor'] = this.luckyColor;
    data['LuckyNumber'] = this.luckyNumber;
    data['HoroscopeDate'] = this.horoscopeDate;
    data['SunsignKey'] = this.sunsignKey;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    return data;
  }
}
