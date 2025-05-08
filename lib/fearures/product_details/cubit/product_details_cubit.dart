// import 'package:bloc/bloc.dart';
// import 'package:angelinashop/fearures/product_details/cubit/product_details_state.dart';
// import 'package:angelinashop/fearures/product_details/model/data/product_details_data.dart';
// import '../../home/model/models/products_model.dart';
// import '../model/model/product_variation_model.dart';
//
// class ProductDetailsCubit extends Cubit<ProductDetailsState> {
//   ProductDetailsCubit(this.productDetailsData) : super(ProductDetailsInitial());
//
//   final ProductDetailsData productDetailsData;
//
//   List<ProductVariation> _allVariations = [];
//   List<String> _availableColors = [];
//   ProductVariation? _selectedVariation;
//
//   List<ProductVariation> get allVariations => _allVariations;
//
//   List<String> get availableColors => _availableColors;
//
//   ProductVariation? get selectedVariation => _selectedVariation;
//
//   List<ProductImage> getFilteredImages(
//       List<ProductImage> allImages, String? selectedColor) {
//     if (selectedColor == null) return allImages;
//
//     return allImages
//         .where((image) =>
//             image.src?.toLowerCase().contains(selectedColor.toLowerCase()) ??
//             false)
//         .toList();
//   }
//
//   List<String> _extractColors(List<ProductVariation> variations) {
//     final colorSet = <String>{};
//
//     for (var variation in variations) {
//       for (var attr in variation.attributes ?? []) {
//         for (var option in attr.options ?? []) {
//           colorSet.add(option.trim());
//         }
//       }
//     }
//     return colorSet.toList();
//   }
//
//   Future<void> getProductDetails(int productId) async {
//     try {
//       emit(ProductDetailsLoading());
//       _allVariations = await productDetailsData.getProductVariations(productId);
//       _availableColors = _extractColors(_allVariations);
//       emit(ProductDetailsSuccess(
//           variations: _allVariations, availableColors: _availableColors));
//     } catch (e) {
//       emit(ProductDetailsError(e.toString()));
//     }
//   }
//
//   void selectColor(String selectedColor) {
//     _selectedVariation = _allVariations.firstWhere(
//       (variation) =>
//           variation.attributes?.any((attr) =>
//               attr.options?.any((opt) => opt.trim().toLowerCase() == selectedColor.toLowerCase()) ??
//               false) ??
//           false,
//       orElse: () => _allVariations.first,
//     );
//
//     emit(ProductDetailsSuccess(
//         variations: _allVariations,
//         availableColors: _availableColors,
//         selectedVariation: _selectedVariation,
//         selectedColor: selectedColor));
//   }
// }
//

// import 'package:bloc/bloc.dart';
// import 'package:angelinashop/fearures/product_details/cubit/product_details_state.dart';
// import 'package:angelinashop/fearures/product_details/model/data/product_details_data.dart';
// import '../../home/model/models/products_model.dart';
// import '../model/model/product_variation_model.dart';

//
// import 'package:bloc/bloc.dart';
// import 'package:angelinashop/fearures/product_details/cubit/product_details_state.dart';
// import 'package:angelinashop/fearures/product_details/model/data/product_details_data.dart';
// import '../../home/model/models/products_model.dart';
//
// class ProductDetailsCubit extends Cubit<ProductDetailsState> {
//   ProductDetailsCubit(this.productDetailsData) : super(ProductDetailsInitial());
//
//   final ProductDetailsData productDetailsData;
//
//   List<ProductVariation> _allVariations = [];
//   List<String> _availableColors = [];
//   ProductVariation? _selectedVariation;
//   String?
//       _colorAttributeName; // Store the attribute name for colors (e.g., "لون" or "Color")
//   ProductsModel? _productModel;
//
//   List<ProductVariation> get allVariations => _allVariations;
//
//   List<String> get availableColors => _availableColors;
//
//   ProductVariation? get selectedVariation => _selectedVariation;
//
//   // Set the product model to access its attributes
//   void setProductModel(ProductsModel model) {
//     _productModel = model;
//   }
//
//   // Get filtered images based on selected color
//   List<ProductImage> getFilteredImages(
//       List<ProductImage> allImages, String? selectedColor) {
//     if (selectedColor == null) return allImages;
//
//     // First try to find images from the selected variation
//     if (_selectedVariation != null &&
//         _selectedVariation!.images != null &&
//         _selectedVariation!.images!.isNotEmpty) {
//       return _selectedVariation!.images!;
//     }
//
//     // If no variation images, try to find product images that match the color name
//     final filteredImages = allImages
//         .where((image) =>
//             image.src?.toLowerCase().contains(selectedColor.toLowerCase()) ??
//             false)
//         .toList();
//
//     // If no images match the selected color, return all images
//     return filteredImages.isEmpty ? allImages : filteredImages;
//   }
//
//   // Extract available colors from the product attributes
//   List<String> _extractColorsFromProduct() {
//     if (_productModel == null) {
//       return [];
//     }
//
//     final colorSet = <String>{};
//
//     // Find color attribute in product attributes
//     final colorAttribute = _productModel!.attributes?.firstWhere(
//       (attr) =>
//           attr.name == 'لون' ||
//           attr.name == 'Color',
//       orElse: () => ProductAttribute(options: []),
//     );
//
//     // Store the color attribute name for later use
//     if (colorAttribute?.name != null) {
//       _colorAttributeName = colorAttribute!.name;
//     }
//
//     // Add colors from product attributes
//     if (colorAttribute?.options != null &&
//         colorAttribute!.options!.isNotEmpty) {
//       colorSet.addAll(colorAttribute.options!);
//     }
//
//     return colorSet.toList();
//   }
//
//   // Extract colors from variations
//   List<String> _extractColorsFromVariations(List<ProductVariation> variations) {
//     final colorSet = <String>{};
//
//     for (var variation in variations) {
//       // Find color attribute in variation attributes
//       final colorAttr = variation.attributes?.firstWhere(
//         (attr) =>
//             attr.name == _colorAttributeName ||
//             attr.name == 'لون' ||
//             attr.name == 'Color',
//         orElse: () => ProductAttribute(),
//       );
//
//       if (colorAttr?.option != null) {
//         colorSet.add(colorAttr!.option!.trim());
//       }
//     }
//
//     return colorSet.toList();
//   }
//
//   Future<void> getProductDetails(int productId) async {
//     try {
//       emit(ProductDetailsLoading());
//
//       // Get product variations from API
//       _allVariations = await productDetailsData.getProductVariations(productId);
//
//       // Get colors from product model (this will set _colorAttributeName)
//       final productColors = _extractColorsFromProduct();
//
//       // If product has color attributes, use them
//       if (productColors.isNotEmpty) {
//         _availableColors = productColors;
//       } else {
//         // If no product colors, extract from variations
//         _availableColors = _extractColorsFromVariations(_allVariations);
//       }
//
//       // If colors are available, select the first one
//       if (_availableColors.isNotEmpty) {
//         selectColor(_availableColors.first);
//       } else {
//         emit(ProductDetailsSuccess(
//             variations: _allVariations, availableColors: _availableColors));
//       }
//     } catch (e) {
//       emit(ProductDetailsError(e.toString()));
//     }
//   }
//
//   void selectColor(String selectedColor) {
//     // Find variation matching the selected color
//     _selectedVariation = _allVariations.firstWhere(
//       (variation) =>
//           variation.attributes?.any((attr) {
//             // Check if this attribute is a color attribute and matches selected color
//             return (attr.name == _colorAttributeName ||
//                     attr.name == 'لون' ||
//                     attr.name == 'Color') &&
//                 (attr.option?.trim().toLowerCase() ==
//                     selectedColor.toLowerCase());
//           }) ??
//           false,
//         orElse: () => _allVariations.first
//     );
//
//     emit(ProductDetailsSuccess(
//         variations: _allVariations,
//         availableColors: _availableColors,
//         selectedVariation: _selectedVariation,
//         selectedColor: selectedColor));
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:angelinashop/fearures/product_details/cubit/product_details_state.dart';
import 'package:angelinashop/fearures/product_details/model/data/product_details_data.dart';
import '../../home/model/models/products_model.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.productDetailsData) : super(ProductDetailsInitial());

  final ProductDetailsData productDetailsData;
  final List<ProductVariation> _allVariations = [];
  final List<String> _availableColors = [];
  ProductsModel? _productModel;

  List<ProductVariation> get allVariations => _allVariations;

  List<String> get availableColors => _availableColors;

  // Set product model
  void setProductModel(ProductsModel model) {
    _productModel = model;
  }

  List<ProductImage> get allProductImages {
    return _productModel?.images ?? [];
  }

  List<String> _extractColorsFromProduct() {
    if (_productModel == null) return [];

    final colorSet = <String>{};

    final colorAttribute = _productModel!.attributes?.firstWhere(
          (attr) =>
      attr.name == 'لون' ||
          attr.name == 'اللون' ||
          attr.name?.toLowerCase() == 'color',
      orElse: () => ProductAttribute(options: []),
    );

    if (colorAttribute?.options != null &&
        colorAttribute!.options!.isNotEmpty) {
      colorSet.addAll(colorAttribute.options!);
    }

    return colorSet.toList();
  }

  Future<void> getProductDetails(int productId) async {
    try {
      emit(ProductDetailsLoading());

      // Fetch variations
      _allVariations.clear();
      _allVariations.addAll(await productDetailsData.getProductVariations(productId));

      // Extract colors
      _availableColors.clear();
      _availableColors.addAll(_extractColorsFromProduct());

      emit(ProductDetailsSuccess(
        variations: _allVariations,
        availableColors: _availableColors,
      ));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}

