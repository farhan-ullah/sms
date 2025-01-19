import 'package:flutter/material.dart';

// Category Model
class Category {
  String id;
  String name;

  Category({required this.id, required this.name});
}

// Product Model
class Product {
  String id;
  String name;
  Category category;
  double purchasePrice;
  double salePrice;
  int stockQuantity;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.purchasePrice,
    required this.salePrice,
    required this.stockQuantity,
  });

  double calculateProfit() {
    return salePrice - purchasePrice;
  }
}


// Flutter app that displays products

