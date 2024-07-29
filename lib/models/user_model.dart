class UserModel {
  String uid;
  String email;
  String name;
  String phone;
  String profilePicture;
  String designation;
  String company;
  bool isActive;
  bool isAdmin;

  UserModel({
    this.uid = "",
    this.email = "",
    this.name = "",
    this.phone = "",
    this.profilePicture = "",
    this.designation = "",
    this.company = "",
    this.isActive = false,
    this.isAdmin = false,
  });

  factory UserModel.fromJson(dynamic json) {
    if (json != null) {
      final uid = json['uid'] ?? "";
      final email = json['email'] ?? "";
      final name = json['name'] ?? "";
      final phone = json['phone'] ?? "";
      final profilePicture = json['profile'] ?? "";
      final designation = json['designation'] ?? "";
      final company = json['company'] ?? "";
      final isActive = json['isActive'] ?? false;
      final isAdmin = json['isAdmin'] ?? false;

      return UserModel(
        uid: uid,
        email: email,
        name: name,
        phone: phone,
        profilePicture: profilePicture,
        designation: designation,
        company: company,
        isActive: isActive,
        isAdmin: isAdmin,
      );
    }
    return UserModel();
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'profilePicture': profilePicture,
      'designation': designation,
      'company': company,
      'isActive': isActive,
      'isAdmin': isAdmin,
    };
  }
}
