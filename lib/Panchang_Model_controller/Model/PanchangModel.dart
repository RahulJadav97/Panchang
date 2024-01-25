class PanchangModel {
  String? status;
  int? responseCode;
  String? responseMessage;
  Data? data;

  PanchangModel(
      {this.status, this.responseCode, this.responseMessage, this.data});

  PanchangModel.fromJson(Map<String, dynamic> json) {
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
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? tithi;
  String? nakshatra;
  String? yoga;
  String? karan;
  String? bhadra;
  String? rashi;
  String? rahuKaal;
  String? gandmool;
  String? panchak;
  String? fastival;
  int? vikramSamvat;
  int? shakaSamvat;
  String? ritu;
  String? dishaShool;
  String? mass;
  String? yamagamdam;
  String? gulikaKaal;
  String? durMuhurat;

  Data(
      {this.sunrise,
        this.sunset,
        this.moonrise,
        this.moonset,
        this.tithi,
        this.nakshatra,
        this.yoga,
        this.karan,
        this.bhadra,
        this.rashi,
        this.rahuKaal,
        this.gandmool,
        this.panchak,
        this.fastival,
        this.vikramSamvat,
        this.shakaSamvat,
        this.ritu,
        this.dishaShool,
        this.mass,
        this.yamagamdam,
        this.gulikaKaal,
        this.durMuhurat});

  Data.fromJson(Map<String, dynamic> json) {
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    tithi = json['tithi'];
    nakshatra = json['nakshatra'];
    yoga = json['yoga'];
    karan = json['karan'];
    bhadra = json['Bhadra'];
    rashi = json['rashi'];
    rahuKaal = json['rahu_kaal'];
    gandmool = json['gandmool'];
    panchak = json['panchak'];
    fastival = json['fastival'];
    vikramSamvat = json['Vikram Samvat'];
    shakaSamvat = json['Shaka Samvat'];
    ritu = json['ritu'];
    dishaShool = json['Disha Shool'];
    mass = json['Mass'];
    yamagamdam = json['Yamagamdam'];
    gulikaKaal = json['gulika_kaal'];
    durMuhurat = json['Dur_muhurat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['moonrise'] = this.moonrise;
    data['moonset'] = this.moonset;
    data['tithi'] = this.tithi;
    data['nakshatra'] = this.nakshatra;
    data['yoga'] = this.yoga;
    data['karan'] = this.karan;
    data['Bhadra'] = this.bhadra;
    data['rashi'] = this.rashi;
    data['rahu_kaal'] = this.rahuKaal;
    data['gandmool'] = this.gandmool;
    data['panchak'] = this.panchak;
    data['fastival'] = this.fastival;
    data['Vikram Samvat'] = this.vikramSamvat;
    data['Shaka Samvat'] = this.shakaSamvat;
    data['ritu'] = this.ritu;
    data['Disha Shool'] = this.dishaShool;
    data['Mass'] = this.mass;
    data['Yamagamdam'] = this.yamagamdam;
    data['gulika_kaal'] = this.gulikaKaal;
    data['Dur_muhurat'] = this.durMuhurat;
    return data;
  }
}
