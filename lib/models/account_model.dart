class Account {
  int? id;
  String? userName;
  String? image;
  Account({this.id, this.image, this.userName});

  factory Account.fromJson(Map<String, dynamic>? json) {
    return Account(
      id: json?["id"],
      userName: json?["user_name"],
      image: json?["image"],
    );
  }
}
