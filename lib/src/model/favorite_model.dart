import 'package:ecommerce_app/src/model/product_model.dart';
import 'package:equatable/equatable.dart';

class FavoriteModel extends Equatable {
  final int id;
  final bool isFavorite;
  final ProductModel product;

  const FavoriteModel({
    required this.id,
    required this.isFavorite,
    required this.product,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json["id"],
      isFavorite: json["isFavorite"],
      product: ProductModel.fromJson(json["product"]),
    );
  }

//

  @override
  List<Object> get props => [];
}
