class AdminModel {
  String uid;
  String email;
  String name;
  String phone;
  String profilePicture;
  String designation;
  String company;
  bool isActive;
  bool isAdmin;

  AdminModel({
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

  factory AdminModel.fromJson(dynamic json) {
    if (json != null) {
      final uid = json['uid'] ?? "";
      final email = json['email'] ?? "";
      final name = json['name'] ?? "";
      final phone = json['phone'] ?? "";
      final profilePicture = json['profilePicture'] ?? "";
      final designation = json['designation'] ?? "";
      final company = json['company'] ?? "";
      final isActive = json['isActive'] ?? false;
      final isAdmin = json['isAdmin'] ?? false;

      return AdminModel(
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
    return AdminModel();
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

  // The copyWith method allows creating a new instance with some updated fields
  AdminModel copyWith({
    String? name,
    String? phone,
    String? designation,
    String? company,
    bool? status,
    String? profilePicture,
  }) {
    return AdminModel(
      uid: uid,
      email: email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      profilePicture: profilePicture ?? this.profilePicture,
      designation: designation ?? this.designation,
      company: company ?? this.company,
      isActive: status ?? isActive,
      isAdmin: isAdmin,
    );
  }
}
