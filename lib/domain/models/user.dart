class User {
  final String id;
  final String? email;
  final String? username;
  final String address;
  final String? picture;
  final bool isVerified;
  final String roles;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    this.email,
    this.username,
    required this.address,
    this.picture,
    required this.isVerified,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        address: json['address'],
        picture: json['picture'],
        isVerified: json['isVerified'],
        roles: json['roles'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );
}
