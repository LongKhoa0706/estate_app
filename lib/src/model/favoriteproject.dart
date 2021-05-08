import 'package:estate_app/src/model/project.dart';

class FavoriteProject {
  Project project;
  int total;

  FavoriteProject({this.project, this.total});

  FavoriteProject.fromJson(Map<String, dynamic> json) {
    project = json['id_news'] != null ? new Project.fromJson(json['id_news']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.project != null) {
      data['id_news'] = this.project.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}