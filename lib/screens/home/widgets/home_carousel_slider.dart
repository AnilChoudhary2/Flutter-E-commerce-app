import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controller/home_controller.dart';
import '../../../utils/common_colors.dart';
import '../../../widgets/network_image_widget.dart';

class HomeCarouselSlider extends StatelessWidget {
  HomeCarouselSlider({Key? key}) : super(key: key);

  /// find home controller.
  final HomeController _homeC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _homeC.homeBannersList.isNotEmpty
          ? CarouselSlider(
              items: _homeC.homeBannersList
                  .map(
                    (x) => Container(
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: NetworkImageWidget(
                          imageUrl: x.url,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 150,
                //enlargeCenterPage: true,
                viewportFraction: 0.99,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
            )
          : Shimmer.fromColors(
              baseColor: CommonColors.shimmerBaseColor,
              highlightColor: CommonColors.shimmerHighlightColor,
              child: Container(
                height: 150,
                margin: const EdgeInsets.only(right: 5, left: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.3),
                    borderRadius: BorderRadius.circular(8)),
              ),
            );
    });
  }
}
