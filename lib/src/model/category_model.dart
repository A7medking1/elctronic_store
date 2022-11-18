import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;

  final String title;

  final String image;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      title: json["title"],
      image: json["image"],
    );
  }

//


  @override
  List<Object> get props => [id, title, image];

}
