class Job {
  int id;
  String jobName;
  int status;
  String createdAt;
  String updatedAt;

  Job({this.id, this.jobName, this.status, this.createdAt, this.updatedAt});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobName = json['job_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_name'] = this.jobName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}