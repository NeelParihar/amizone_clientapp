/// Represents all the information related to a user of the system
class Schedule {
  String coursename;
  String profname;

  Schedule({
    this.coursename,
    this.profname,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      Schedule(coursename: json['CourseDetails'], profname: json['ProfDeatils']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coursename'] = this.coursename;
    data['profname'] = this.profname;
    return data;
  }
}
