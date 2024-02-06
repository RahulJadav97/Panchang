class FestivalDateModel {
  String? status;
  int? responseCode;
  String? responseMessage;
  List<Data>? data;
  String? combineFasrival;

  FestivalDateModel(
      {this.status,
        this.responseCode,
        this.responseMessage,
        this.data,
        this.combineFasrival});

  FestivalDateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    combineFasrival = json['combine_fasrival'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['combine_fasrival'] = this.combineFasrival;
    return data;
  }
}

class Data {
  String? link;
  String? title;
  String? date;
  String? description;
  String? image;

  Data({this.link, this.title, this.date, this.description, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    title = json['title'];
    date = json['date'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['title'] = this.title;
    data['date'] = this.date;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
