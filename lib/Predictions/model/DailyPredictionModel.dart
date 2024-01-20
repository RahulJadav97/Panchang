class DailyPredictionModel {
  String? status;
  int? responseCode;
  String? responseMessage;
  List<Data>? data;

  DailyPredictionModel(
      {this.status, this.responseCode, this.responseMessage, this.data});

  DailyPredictionModel.fromJson(Map<String, dynamic> json) {
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
  String? horoscopeID;
  String? sunsignID;
  String? description;
  String? luckyColor;
  String? luckyNumber;
  String? horoscopeType;
  String? horoscopeDate;
  Null? createdDate;

  Data(
      {this.horoscopeID,
        this.sunsignID,
        this.description,
        this.luckyColor,
        this.luckyNumber,
        this.horoscopeType,
        this.horoscopeDate,
        this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    horoscopeID = json['HoroscopeID'];
    sunsignID = json['SunsignID'];
    description = json['Description'];
    luckyColor = json['LuckyColor'];
    luckyNumber = json['LuckyNumber'];
    horoscopeType = json['HoroscopeType'];
    horoscopeDate = json['HoroscopeDate'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HoroscopeID'] = this.horoscopeID;
    data['SunsignID'] = this.sunsignID;
    data['Description'] = this.description;
    data['LuckyColor'] = this.luckyColor;
    data['LuckyNumber'] = this.luckyNumber;
    data['HoroscopeType'] = this.horoscopeType;
    data['HoroscopeDate'] = this.horoscopeDate;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}
