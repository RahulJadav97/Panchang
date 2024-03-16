class ForgotPassModel {
  String? responseCode;
  String? message;
  int? newPass;
  bool? mail;
  String? status;

  ForgotPassModel(
      {this.responseCode, this.message, this.newPass, this.mail, this.status});

  ForgotPassModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    newPass = json['new_pass'];
    mail = json['mail'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['new_pass'] = this.newPass;
    data['mail'] = this.mail;
    data['status'] = this.status;
    return data;
  }
}
