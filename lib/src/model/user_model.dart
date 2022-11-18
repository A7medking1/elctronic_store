import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String email;

  final String userName;

  const UserModel({
    required this.email,
    required this.userName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      userName: json["username"],
    );
  }


  @override
  List<Object> get props => [userName,email];

}
