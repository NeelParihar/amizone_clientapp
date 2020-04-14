/// Represents all the information related to a user of the system
class Attendance {
  String coursename;
  String percentage;
  String ratio;

  Attendance({
    this.coursename,
    this.percentage,
    this.ratio
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        coursename: json['CourseName'],
        percentage: json['Percentage'],
        ratio: json['Ratio']
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coursename'] = this.coursename;
    data['percentage'] = this.percentage;
    data['ratio'] = this.ratio;
    return data;
  }
}
