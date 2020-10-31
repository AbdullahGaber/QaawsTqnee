import 'package:flutter/cupertino.dart';

class ProductModel {
  int id;
  String name;
  String description;
  String shortDescription;
  String sku;
  String price;
  String regularPrice;
  String salePrice;
  String stockStatus;
  int totalSales;
  List<Images> images;
  int ratingCount;
  String averageRating;
  int stockQuantity;
  List<Categories> categories;
  ProductModel({
    this.id,
    this.name,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.stockStatus,
    this.images,
    this.categories,
    this.ratingCount,
    this.averageRating,
    this.totalSales,
    this.stockQuantity,
  });
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    stockStatus = json['stock_status'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach(
        (c) => categories.add(
          Categories.fromJson(
            json['categories'][0],
          ),
        ),
      );
    }
    if (json['images'] != null) {
      images = [];
      json['images'].forEach(
        (c) => images.add(
          Images.fromJson(
            json['images'][0],
          ),
        ),
      );
    }
    ratingCount = json['rating_count'];
    averageRating = json['average_rating'];
    totalSales = json['total_sales'];
    stockQuantity = json['stock_quantity'] != null ? json['stock_quantity'] : 0;
  }
}

class Categories {
  int id;
  String name;
  Categories({this.id, this.name});
  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Images {
  String src;
  Images({this.src});
  Images.fromJson(Map<String, dynamic> json) {
    src = json['src'];
  }
}
