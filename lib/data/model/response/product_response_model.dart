import 'package:meta/meta.dart';
import 'dart:convert';

class ProductResponseModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final String category;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductResponseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductResponseModel.fromJson(String str) => ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) => ProductResponseModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    category: json["category"],
    imageUrl: json["image_url"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "category": category,
    "image_url": imageUrl,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
