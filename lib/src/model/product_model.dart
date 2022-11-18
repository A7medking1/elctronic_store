import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;

  final String title;
  final String image;
  final String description;
  final bool favorite;

  final bool discount ;

  final int category;
  final double oldPrice;
  final double newPrice;

  const ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.favorite,
    required this.discount,
    required this.category,
    required this.oldPrice,
    required this.newPrice,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      discount: json["discount"],
      description: json["description"],
      favorite: json["favorite"] ?? false,
      category: json["category"],
      oldPrice: json["old_price"],
      newPrice: json["new_price"],
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        image,
        description,
        favorite,
        category,
    discount,
    oldPrice,
        newPrice,
      ];

//

}
