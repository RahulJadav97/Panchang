class CityDataModel {
  String? status;
  int? responseCode;
  String? responseMessage;
  List<Data>? data;

  CityDataModel(
      {this.status, this.responseCode, this.responseMessage, this.data});

  CityDataModel.fromJson(Map<String, dynamic> json) {
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
  String? rowid;
  String? place;
  String? latdeg;
  String? latmin;
  String? latns;
  String? longdeg;
  String? longmin;
  String? longew;
  String? countrycode;
  String? statecountrycode;
  String? timecorrectioncode;
  int? zHour;
  int? zMin;
  int? dST;
  int? wAR;
  int? direction;

  Data(
      {this.rowid,
        this.place,
        this.latdeg,
        this.latmin,
        this.latns,
        this.longdeg,
        this.longmin,
        this.longew,
        this.countrycode,
        this.statecountrycode,
        this.timecorrectioncode,
        this.zHour,
        this.zMin,
        this.dST,
        this.wAR,
        this.direction});

  Data.fromJson(Map<String, dynamic> json) {
    rowid = json['rowid'];
    place = json['place'];
    latdeg = json['latdeg'];
    latmin = json['latmin'];
    latns = json['latns'];
    longdeg = json['longdeg'];
    longmin = json['longmin'];
    longew = json['longew'];
    countrycode = json['countrycode'];
    statecountrycode = json['statecountrycode'];
    timecorrectioncode = json['timecorrectioncode'];
    zHour = json['ZHour'];
    zMin = json['ZMin'];
    dST = json['DST'];
    wAR = json['WAR'];
    direction = json['Direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rowid'] = this.rowid;
    data['place'] = this.place;
    data['latdeg'] = this.latdeg;
    data['latmin'] = this.latmin;
    data['latns'] = this.latns;
    data['longdeg'] = this.longdeg;
    data['longmin'] = this.longmin;
    data['longew'] = this.longew;
    data['countrycode'] = this.countrycode;
    data['statecountrycode'] = this.statecountrycode;
    data['timecorrectioncode'] = this.timecorrectioncode;
    data['ZHour'] = this.zHour;
    data['ZMin'] = this.zMin;
    data['DST'] = this.dST;
    data['WAR'] = this.wAR;
    data['Direction'] = this.direction;
    return data;
  }
}
