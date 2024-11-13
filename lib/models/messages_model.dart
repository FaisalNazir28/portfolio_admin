class MessagesModel {
  String uid;
  String name;
  String email;
  String message;
  String status;

  MessagesModel({
    this.uid = "",
    this.name = "",
    this.email = "",
    this.message = "",
    this.status = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'message': message,
      'status': status,
    };
  }

  factory MessagesModel.fromJson(dynamic json) {
    if (json != null) {
      final uid = json['uid'] ?? "";
      final name = json['name'] ?? "";
      final email = json['email'] ?? "";
      final message = json['message'] ?? "";
      final status = json['status'] ?? "";

      return MessagesModel(
        uid: uid,
        name: name,
        email: email,
        message: message,
        status: status,
      );
    }
    return MessagesModel();
  }
}
