/// Represents all the information related to a user of the system
class User {
  int id;
  String username;
  String name;
  String email;


  User(
      {this.id,
      this.username,
      this.name,
      this.email,
      });


  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        name: json['name'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
