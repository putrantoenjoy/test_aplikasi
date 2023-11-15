class User {
  int? id;
  String? name, username, email;

  User({this.id, this.name, this.username, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id_student'],
      name: json['student_name'],
      username: json['gender'],
      email: json['birth_date'],
    );
  }
}
