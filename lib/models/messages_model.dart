class MessagesModel {
  String name;
  String email;
  String message;
  String status;

  MessagesModel({
    this.name = "",
    this.email = "",
    this.message = "",
    this.status = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'message': message,
      'status': status,
    };
  }

  factory MessagesModel.fromJson(dynamic json) {
    if (json != null) {
      final name = json['name'] ?? "";
      final email = json['email'] ?? "";
      final message = json['message'] ?? "";
      final status = json['status'] ?? "";

      return MessagesModel(
        name: name,
        email: email,
        message: message,
        status: status,
      );
    }
    return MessagesModel();
  }
}
