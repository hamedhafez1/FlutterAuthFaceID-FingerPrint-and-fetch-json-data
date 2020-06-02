class User {
  String firstName;
  String lastName;
  String gender;
  String email;
  String imageUrl;
  String phone;

  User(
      {this.firstName,
      this.lastName,
      this.gender,
      this.email,
      this.imageUrl,
      this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json['firstname'],
        lastName: json['lastname'],
        gender: json['gender'],
        email: json['email'],
        imageUrl: json['imageUrl'],
        phone: json['phone']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstName;
    data['lastname'] = this.lastName;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['imageUrl'] = this.imageUrl;
    data['phone'] = this.phone;
    return data;
  }
}
