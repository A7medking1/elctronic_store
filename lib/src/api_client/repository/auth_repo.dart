import 'package:dio/dio.dart';

import '../../core/api_constant.dart';
import '../../model/login_model.dart';
import '../../model/register_model.dart';
import '../ApiClient.dart';

class AuthRepo {
  late final ApiClient apiClient;

  AuthRepo({
    required this.apiClient,
  });

  Future<Response> userRegister(RegisterModel registerModel) async {
    return await apiClient.postData(
        url: ApiConstant.register, data: registerModel.toJson());
  }

  Future<Response> userLogin(LoginModel loginModel) async {
    return await apiClient.postData(
        url: ApiConstant.login, data: loginModel.toJson());
  }
}
