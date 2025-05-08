import 'package:angelinashop/core/styles/colors_app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({super.key, required this.url, this.height});

  final String url;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: height,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          SpinKitFadingCircle(color: ColorsApp.kThirdColor, size: 20),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
