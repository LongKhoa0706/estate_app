class New {
  int id;
  String username;
  String type;
  String phone;
  String location;
  int status;
  String createdAt;
  String updatedAt;

  New(
      {this.id,
        this.username,
        this.type,
        this.phone,
        this.location,
        this.status,
        this.createdAt,
        this.updatedAt});

  New.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['Username'];
    type = json['Type'];
    phone = json['Phone'];
    location = json['Location'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Username'] = this.username;
    data['Type'] = this.type;
    data['Phone'] = this.phone;
    data['Location'] = this.location;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
