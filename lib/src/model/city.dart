class Address {
  int iD;
  String title;

  Address({this.iD, this.title});

  Address.fromJson(Map<String, dynamic> json) {
    iD = json['id'];
    title = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.iD;
    data['name'] = this.title;
    return data;
  }
}