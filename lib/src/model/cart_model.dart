import 'package:ecommerce_app/src/model/product_model.dart';
import 'package:equatable/equatable.dart';

class CartsModel extends Equatable {
  final double totalPrice;
  final double totalPriceOld;
  final List<Data> data;

  const CartsModel({
    required this.totalPrice,
    required this.totalPriceOld,
    required this.data,
  });

  factory CartsModel.fromJson(Map<String, dynamic> json) {
    return CartsModel(
        totalPrice: json['total_price'],
        totalPriceOld: json['total_price_old'],
        data: List.from(json['data']).map((e) => Data.fromJson(e)).toList()
    );
  }

  @override
  List<Object> get props => [totalPrice, totalPriceOld, data];
//

}

class Data extends Equatable {
  final int id;
  final int quantity;
  final ProductModel product;
  final double totalPrice;
  final double totalPriceOld;

  const Data({
    required this.id,
    required this.quantity,
    required this.product,
    required this.totalPrice,
    required this.totalPriceOld,
  });


  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      quantity: json["quantity"],
      product: ProductModel.fromJson(json["product"]),
      totalPrice: json["total_price"],
      totalPriceOld: json["total_price_old"],
    );
  }

  @override
  List<Object> get props => [id, quantity, product, totalPrice, totalPriceOld,];
}
