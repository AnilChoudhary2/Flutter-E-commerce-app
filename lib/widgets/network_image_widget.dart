import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yahmart/utils/common_colors.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  const NetworkImageWidget({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl.startsWith("http")
          ? imageUrl
          : "https://yahmartindia.in/api/v1/$imageUrl",
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.3),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: CommonColors.shimmerBaseColor,
        highlightColor: CommonColors.shimmerHighlightColor,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
