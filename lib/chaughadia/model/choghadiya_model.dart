class ChoghadiyaModel {
  String? status;
  int? responseCode;
  String? responseMessage;
  Data? data;

  ChoghadiyaModel(
      {this.status, this.responseCode, this.responseMessage, this.data});

  ChoghadiyaModel.fromJson(Map<String, dynamic> json) {
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
    if (json['day'] != null) {
      day = <Day>[];
      json['day'].forEach((v) {
        day!.add(new Day.fromJson(v));
      });
    }
    if (json['night'] != null) {
      night = <Night>[];
      json['night'].forEach((v) {
        night!.add(new Night.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.day != null) {
      data['day'] = this.day!.map((v) => v.toJson()).toList();
    }
    if (this.night != null) {
      data['night'] = this.night!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Day {
  String? choghadiya;
  String? start;
  String? end;

  Day({this.choghadiya, this.start, this.end});

  Day.fromJson(Map<String, dynamic> json) {
    choghadiya = json['choghadiya'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['choghadiya'] = this.choghadiya;
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}
class Night {
  String? choghadiya;
  String? start;
  String? end;

  Night({this.choghadiya, this.start, this.end});

  Night.fromJson(Map<String, dynamic> json) {
    choghadiya = json['choghadiya'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['choghadiya'] = this.choghadiya;
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}
