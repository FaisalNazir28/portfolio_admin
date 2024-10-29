class MessagesModel {
  String name;
  String email;
  String message;

  MessagesModel({
    this.name = "",
    this.email = "",
    this.message = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'message': message,
    };
  }

  factory MessagesModel.fromJson(dynamic json) {
    if (json != null) {
      final name = json['name'] ?? "";
      final email = json['email'] ?? "";
      final message = json['message'] ?? "";

      return MessagesModel(
        name: name,
        email: email,
        message: message,
      );
    }
    return MessagesModel();
  }
}
