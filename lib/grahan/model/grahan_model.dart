class GrahanModel {
  String? link;
  String? title;
  String? date;
  String? description;
  String? image;

  GrahanModel(
      {this.link, this.title, this.date, this.description, this.image});

  GrahanModel.fromJson(Map<String, dynamic> json) {
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
