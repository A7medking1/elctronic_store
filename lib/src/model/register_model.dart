import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {

  final String userName;

  final String password;

  final String email;

  const RegisterModel({
    required this.userName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": userName,
      "password": password,
      "email": email,
    };
  }

  @override
  List<Object> get props => [userName, password, email];

}