class HoraModel {
  String? status;
  int? responseCode;
  String? responseMessage;
  Data? data;

  HoraModel({this.status, this.responseCode, this.responseMessage, this.data});

  HoraModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Day>? day;
  List<Night>? night;

  Data({this.day, this.night});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Day'] != null) {
      day = <Day>[];
      json['Day'].forEach((v) {
        day!.add(new Day.fromJson(v));
      });
    }
    if (json['Night'] != null) {
      night = <Night>[];
      json['Night'].forEach((v) {
        night!.add(new Night.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.day != null) {
      data['Day'] = this.day!.map((v) => v.toJson()).toList();
    }
    if (this.night != null) {
      data['Night'] = this.night!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Day {
  String? planet;
  String? startTime;
  String? endTime;

  Day({this.planet, this.startTime, this.endTime});

  Day.fromJson(Map<String, dynamic> json) {
    planet = json['Planet'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Planet'] = this.planet;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}

class Night {
  String? planet;
  String? startTime;
  String? endTime;

  Night({this.planet, this.startTime, this.endTime});

  Night.fromJson(Map<String, dynamic> json) {
    planet = json['Planet'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Planet'] = this.planet;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}

