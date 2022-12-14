import 'package:dio/dio.dart';
import 'package:ecommerce_app/src/core/api_constant.dart';
import 'package:ecommerce_app/src/view/pages/auth/controller/auth_controller.dart';

import '../ApiClient.dart';

class ProductsRepo {
  final ApiClient apiClient;

  ProductsRepo(this.apiClient);

  Future<Response> getCategories() async {
    return await apiClient.getData(url: ApiConstant.category, token: token);
  }

  Future<Response> getCurrentUser() async {
    return await apiClient.getData(url: ApiConstant.user, token: token);
  }

  Future<Response> getProducts(int page) async {
    return await apiClient.getData(
        url: ApiConstant.productPath(page), token: token);
  }

  Future<Response> searchProducts(String text) async {
    return await apiClient.getData(
      url: ApiConstant.searchPath(text),
      token: token,
    );
  }

  Future<Response> getFavorites() async {
    return await apiClient.getData(
      url: ApiConstant.favoritePath(),
      token: token,
    );
  }

  Future<Response> getProductByCategory(int id) async {
    return await apiClient.getData(
        url: ApiConstant.productByCategoryPath(id), token: token);
  }

  Future<Response> changeFavorite(Map<String, dynamic> data) async {
    return await Dio().post(ApiConstant.favoritePath(),
        data: data,
        options: Options(headers: {
          'Authorization': "token $token",
        }));
  }

  Future<Response> addProductToCart(Map<String, dynamic> data) async {
    return await Dio().post(ApiConstant.addToCartPath(),
      data: data,
        options: Options(headers: {
          'Authorization': "token $token",
        }));
  }

  Future<Response> getCarts() async {
    return await apiClient.getData(
      url: ApiConstant.cartPath(),
      token: token,
    );
  }

  Future<Response> increaseProductInCart(int id) async {
    return await apiClient.getData(
      url: ApiConstant.increaseProductInCart(id),
      token: token,
    );
  }

  Future<Response> reduceProductInCart(int id) async {
    return await apiClient.getData(
      url: ApiConstant.reduceProductInCart(id),
      token: token,
    );
  }
  Future<Response> deleteProductFromCart(int id) async {
    return await apiClient.getData(
      url: ApiConstant.deleteProductFromCart(id),
      token: token,
    );
  }


}
