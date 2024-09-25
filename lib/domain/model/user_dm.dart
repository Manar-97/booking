class UserDM {
  static const collectionName = "users";
  static UserDM? currentUser;
  String? id;
  String? email;
  String? userName;
  String? password;

  UserDM({this.id, this.email, this.userName, this.password});

  UserDM.fromJson(dynamic json) {
    id = json?['id'];
    email = json?['email'];
    userName = json?['userName'];
    password = json?['password'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['userName'] = userName;
    map['password'] = password;
    return map;
  }
}
