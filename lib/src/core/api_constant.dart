class ApiConstant {
  //static String baseUrl = "http://127.0.0.1:8000";

  //static  String baseUrl = "http://10.0.2.2:8000";
  static  String baseUrl = "http://192.168.1.15:8000";
  //static String baseUrl = "http://172.20.10.14:8000";

  static String login = "/api/login/";
  static String register = "/api/register/";
  static String category = "/api/category/";
  static String user = "/api/user/";

  static String imagePath(String path) => "$baseUrl/$path";

  //static String productPath(int page) => "$baseUrl/api/test/?page=$page";
  static String productPath(int page) => "$baseUrl/api/products/?page=$page";

  static String favoritePath() => "$baseUrl/api/favorite/";

  static String searchPath(String text) =>
      "$baseUrl/api/search_product/?search=$text";

  static String productByCategoryPath(int id) =>
      "$baseUrl/api/products_by_category/?category_id=$id";


  static String addToCartPath() => "$baseUrl/api/cart/add/";

  static String increaseProductInCart(int id) => '$baseUrl/api/cart/increase_quantity/$id/';
  static String reduceProductInCart(int id) => '$baseUrl/api/cart/reduce_quantity/$id/';


  static String deleteProductFromCart(int id) => '$baseUrl/api/cart/delete/$id/';

  static String cartPath() => "$baseUrl/api/cart/";


}
