import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerLoader extends StatelessWidget {
  Shimmer applyShimmer({required double borderRadius, required double height, required double width}) {
    return Shimmer(
      duration: const Duration(seconds: 1),
      interval: const Duration(seconds: 1),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: const Color(0xffc7c7c7),
        ),
      ),
    );
  }

  Widget returnShimmerRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 28, bottom: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          applyShimmer(width: 28, height: 28, borderRadius: 100),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                applyShimmer(width: 150, height: 15, borderRadius: 100),
                const SizedBox(
                  height: 10,
                ),
                applyShimmer(width: 70, height: 15, borderRadius: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        applyShimmer(width: 160, height: 40, borderRadius: 50),
        const SizedBox(
          height: 17,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            applyShimmer(width: 60, height: 20, borderRadius: 5),
            const SizedBox(
              width: 25,
            ),
            applyShimmer(width: 60, height: 20, borderRadius: 5),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: applyShimmer(width: 60, height: 15, borderRadius: 50),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        returnShimmerRow(),
        returnShimmerRow(),
        returnShimmerRow(),
        returnShimmerRow(),
      ],
    );
  }
}
