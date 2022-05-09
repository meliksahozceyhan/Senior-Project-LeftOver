class User {
  String id,
      createdAt,
      updatedAt,
      email,
      fullName,
      password,
      dateOfBirth,
      city,
      address,
      profileImage;

  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.fullName,
    this.password,
    this.dateOfBirth,
    this.city,
    this.address,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      email: json['email'],
      fullName: json['fullName'],
      password: json['password'],
      dateOfBirth: json['dateOfBirth'],
      city: json['city'],
      address: json['address'],
      profileImage: json['profileImage']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "email": email,
      "fullName": fullName,
      "dateOfBirth": dateOfBirth,
      "city": city,
      "address": address,
      "profileImage":profileImage
    };
  }
}
