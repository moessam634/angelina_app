import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../home/model/models/products_model.dart';
import '../../cubit/product_details_cubit.dart';
import '../../model/data/product_details_data.dart';
import '../widget/product_details_body.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductsModel model;

  const ProductDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => ProductDetailsCubit(sl<ProductDetailsData>()),
        child: ProductDetailsBody(model: model),
      ),
    );
  }
}
