import 'dart:ui';

import 'package:flutter/material.dart';

class ProductModel {
  final int id;
final double price;

  final String image;
  final String name;
 final String description;
 late bool inFavorites;
  final List images;
  ProductModel({
    required this.id,
    required this.price,

   required this.image,
  required this.name,
    required this.description,
 required this.inFavorites,
required this.images
  });

  factory ProductModel.fromJson(jsonData) {
    try {
      return ProductModel(
        id: jsonData['id'],
        price: _parsePrice(jsonData['price']),

       image: jsonData['image'],
       name: jsonData['name'],
       description: jsonData['description'],
        images: jsonData['images'],
        inFavorites: false,

      );
    } catch (e) {
      print('Error parsing ProductModel: $e');
      throw e;
    }
  }
  static double _parsePrice(dynamic value) {
    if (value is int) {
      return value.toDouble(); // Convert int to double
    } else if (value is double) {
      return value;
    } else {
      throw Exception('Invalid price value: $value');
    }
  }
}
