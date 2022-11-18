import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String userName;

  final String password;

  const LoginModel({
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": userName,
      "password": password,
    };
  }


  @override
  List<Object> get props => [userName, password];
}
