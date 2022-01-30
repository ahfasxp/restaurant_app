class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String? telephone;
  final String? address;

  UserModel(
      {required this.uid,
      required this.fullName,
      required this.email,
      this.telephone,
      this.address});

  factory UserModel.fromJson(String uid, Map<String, dynamic> json) =>
      UserModel(
          uid: uid,
          fullName: json['full_name'],
          email: json['email'],
          telephone: json['telephone'],
          address: json['address']);
}
