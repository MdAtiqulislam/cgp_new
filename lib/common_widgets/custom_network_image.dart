import 'package:flutter/material.dart';
import '../constraints/app_strings.dart';

class CustomNetworkImage extends StatelessWidget {
  final String image;
  final String? localImage;
  final String? errorImage;
  final double? borderRadius;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const CustomNetworkImage(
      {this.height,
        this.width,
        required this.image,
        this.localImage,
        this.borderRadius,
        this.fit,
        this.errorImage,
        super.key});

  @override
  Widget build(BuildContext context) {
    return image.isNotEmpty
        ? Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius ?? 0),
        ),
      ),
      child: Image.network(
        image,
        fit: fit ?? BoxFit.cover,
        frameBuilder: (_, image, loadingBuilder, __) {
          if (loadingBuilder == null) {
            return Image.asset(
              localImage ?? AppImagePath.avatar,
              fit: fit ?? BoxFit.cover,
            );
          }
          return image;
        },
        loadingBuilder: (context, image, loading) {
          if (loading == null) {
            return image;
          } else {
            return Image.asset(localImage ?? AppImagePath.avatar,
                fit: fit ?? BoxFit.contain);
          }
        },
        // Add the errorBuilder here
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            errorImage ?? AppImagePath.errorImage,
            fit: BoxFit.contain,
          );
        },
      ),
    )
        : Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius ?? 0),
        ),
      ),
      child: Image.asset(
        localImage ?? AppImagePath.avatar,
        fit: fit,
      ),
    );
  }
}

