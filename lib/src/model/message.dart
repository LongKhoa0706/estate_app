class Message {
  int id;
  int from;
  int to;
  String message;
  int isRead;
  String createdAt;
  String updatedAt;

  Message(
      {this.id,
        this.from,
        this.to,
        this.message,
        this.isRead,
        this.createdAt,
        this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    message = json['message'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from'] = this.from;
    data['to'] = this.to;
    data['message'] = this.message;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}