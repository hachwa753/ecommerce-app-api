import 'package:ecommerceappapi/features/products/domain/model/review.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double discountPercentage;
  final List<String> tags;
  final List<Review> reviews;
  final String thumbnail;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.discountPercentage,
    required this.tags,
    required this.reviews,
    required this.images,
    required this.thumbnail,
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    double? discountPercentage,
    List<String>? tags,
    List<Review>? reviews,
    String? thumbnail,
    List<String>? images,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      tags: tags ?? this.tags,
      reviews: reviews ?? this.reviews,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'discountPercentage': discountPercentage,
      'tags': tags,
      'reviews': reviews.map((x) => x.toMap()).toList(),
      'thumbnail': thumbnail,
      'images': images,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      discountPercentage: (map['discountPercentage'] as num).toDouble(),
      tags: map['tags'] != null ? List<String>.from(map['tags']) : [],
      reviews:
          map['reviews'] != null
              ? List<Review>.from(
                (map['reviews'] as List).map(
                  (x) => Review.fromMap(x as Map<String, dynamic>),
                ),
              )
              : [],
      thumbnail: map['thumbnail'] as String? ?? '',
      images: map['images'] != null ? List<String>.from(map['images']) : [],
    );
  }
}
