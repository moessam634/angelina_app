import 'package:equatable/equatable.dart';

class ProductsModel extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? shortDescription;
  final String? price;
  final String? regularPrice;
  final String? salePrice;
  final bool? onSale;
  final bool? featured;
  final String? averageRating;
  final int? ratingCount;
  final List<ProductImage>? images;
  final List<ProductCategory>? categories;
  final List<ProductAttribute>? attributes;
  final List<int>? variations;
  final int? stockQuantity;
  final String? stockStatus;

  const ProductsModel({
    this.id,
    this.name,
    this.description,
    this.shortDescription,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.featured,
    this.averageRating,
    this.ratingCount,
    this.images,
    this.categories,
    this.attributes,
    this.variations,
    this.stockQuantity,
    this.stockStatus,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        shortDescription: json["short_description"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        onSale: json["on_sale"],
        featured: json["featured"],
        averageRating: json["average_rating"],
        ratingCount: json["rating_count"],
        stockQuantity: json["stock_quantity"],
        stockStatus: json["stock_status"],
        images: json["images"] == null
            ? []
            : List<ProductImage>.from(
                json["images"].map((x) => ProductImage.fromJson(x))),
        categories: json["categories"] == null
            ? []
            : List<ProductCategory>.from(
                json["categories"].map((x) => ProductCategory.fromJson(x))),
        attributes: json["attributes"] == null
            ? []
            : List<ProductAttribute>.from(
                json["attributes"].map((x) => ProductAttribute.fromJson(x))),
        variations: json["variations"] == null
            ? []
            : List<int>.from(json["variations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "short_description": shortDescription,
      "price": price,
      "regular_price": regularPrice,
      "sale_price": salePrice,
      "on_sale": onSale,
      "featured": featured,
      "average_rating": averageRating,
      "rating_count": ratingCount,
      "stock_quantity": stockQuantity,
      "stock_status": stockStatus,
      "images": images?.map((x) => x.toMap()).toList(),
      "categories": categories?.map((x) => x.toMap()).toList(),
      "attributes": attributes?.map((x) => x.toMap()).toList(),
      "variations": variations,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "short_description": shortDescription,
      "price": price,
      "regular_price": regularPrice,
      "sale_price": salePrice,
      "on_sale": onSale,
      "featured": featured,
      "average_rating": averageRating,
      "rating_count": ratingCount,
      "stock_quantity": stockQuantity,
      "stock_status": stockStatus,
      "images": images?.map((x) => x.toMap()).toList(),
      "categories": categories?.map((x) => x.toMap()).toList(),
      "attributes": attributes?.map((x) => x.toMap()).toList(),
      "variations": variations,
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      shortDescription: map["short_description"],
      price: map["price"],
      regularPrice: map["regular_price"],
      salePrice: map["sale_price"],
      onSale: map["on_sale"],
      featured: map["featured"],
      averageRating: map["average_rating"],
      ratingCount: map["rating_count"],
      stockQuantity: map["stock_quantity"],
      stockStatus: map["stock_status"],
      images: map["images"] == null
          ? []
          : List<ProductImage>.from(
              map["images"].map((x) => ProductImage.fromMap(x))),
      categories: map["categories"] == null
          ? []
          : List<ProductCategory>.from(
              map["categories"].map((x) => ProductCategory.fromMap(x))),
      attributes: map["attributes"] == null
          ? []
          : List<ProductAttribute>.from(
              map["attributes"].map((x) => ProductAttribute.fromMap(x))),
      variations:
          map["variations"] == null ? [] : List<int>.from(map["variations"]),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        salePrice,
        regularPrice,
        onSale,
        featured,
        images,
        categories,
        attributes,
        variations,
        stockQuantity,
        stockStatus,
      ];
}


class ProductCategory {
  final String? name;

  ProductCategory({this.name});

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(name: json["name"]);

  Map<String, dynamic> toMap() => {
        "name": name,
      };

  factory ProductCategory.fromMap(Map<String, dynamic> map) =>
      ProductCategory(name: map["name"]);
}

class ProductVariation {
  final int? id;
  final String? description;
  final String? price;
  final String? regularPrice;
  final String? salePrice;
  final bool? onSale;
  final bool? inStock;
  final List<ProductAttribute>? attributes;
  final List<ProductImage>? images;

  ProductVariation({
    this.id,
    this.description,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.inStock,
    this.attributes,
    this.images,
  });

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    List<ProductAttribute>? attributes;
    if (json['attributes'] != null) {
      attributes = <ProductAttribute>[];
      json['attributes'].forEach((v) {
        attributes!.add(ProductAttribute.fromJson(v));
      });
    }

    List<ProductImage>? images;
    if (json['image'] != null) {
      images = <ProductImage>[];
      if (json['image'] is List) {
        json['image'].forEach((v) {
          images!.add(ProductImage.fromJson(v));
        });
      } else if (json['image'] is Map) {
        images.add(ProductImage.fromJson(json['image']));
      }
    }

    return ProductVariation(
      id: json['id'],
      description: json['description'],
      price: json['price']?.toString(),
      regularPrice: json['regular_price']?.toString(),
      salePrice: json['sale_price']?.toString(),
      onSale: json['on_sale'],
      inStock: json['in_stock'],
      attributes: attributes,
      images: images,
    );
  }
}

class ProductAttribute {
  final int? id;
  final String? name;
  final String? option;
  final List<String>? options;

  ProductAttribute({
    this.id,
    this.name,
    this.option,
    this.options,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    List<String>? options;
    if (json['options'] != null) {
      options = List<String>.from(json['options']);
    }

    return ProductAttribute(
      id: json['id'],
      name: json['name'],
      option: json['option'],
      options: options,
    );
  }
  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "options": options,
    "option": option,
  };

  factory ProductAttribute.fromMap(Map<String, dynamic> map) =>
      ProductAttribute(
        name: map["name"],
        options: List<String>.from(map["options"] ?? []),
      );
}


class ProductImage extends Equatable {
  final String? src;

  const ProductImage({this.src});

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      ProductImage(src: json["src"]);

  Map<String, dynamic> toMap() => {
    "src": src,
  };

  factory ProductImage.fromMap(Map<String, dynamic> map) =>
      ProductImage(src: map["src"]);

  @override
  List<Object?> get props => [src];
}

// class ProductAttribute {
//   final int? id;
//   final String? name;
//   final String? option;
//   final List<String>? options;
//   final bool? variation;
//   ProductAttribute( {this.name, this.options,this.variation,this.id, this.option,});
//
//   factory ProductAttribute.fromJson(Map<String, dynamic> json) =>
//       ProductAttribute(
//         name: json["name"],
//         options: List<String>.from(json["options"] ?? []),
//         variation: json["variation"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "name": name,
//         "options": options,
//     "variation": variation,
//       };
//
//   factory ProductAttribute.fromMap(Map<String, dynamic> map) =>
//       ProductAttribute(
//         name: map["name"],
//         options: List<String>.from(map["options"] ?? []),
//         variation: map["variation"],
//       );
// }
//
// class ProductAttribute {
//   final int? id;
//   final String? name;
//   final String? option;
//   final List<String>? options;
//
//   ProductAttribute({
//     this.id,
//     this.name,
//     this.option,
//     this.options,
//   });
//
//   factory ProductAttribute.fromJson(Map<String, dynamic> json) {
//     List<String>? options;
//     if (json['options'] != null) {
//       options = List<String>.from(json['options']);
//     }
//     return ProductAttribute(
//       id: json['id'],
//       name: json['name'],
//       option: json['option'],
//       options: options,
//     );
//   }
//   Map<String, dynamic> toMap() => {
//     "name": name,
//     "options": options,
//     "variation": variation,
//   };
// }
