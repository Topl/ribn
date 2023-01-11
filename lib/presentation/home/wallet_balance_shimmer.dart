// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/widgets/molecules/shimmer_loader.dart';

class WalletBalanceShimmer extends StatelessWidget {
  const WalletBalanceShimmer({Key? key}) : super(key: key);

  Widget returnShimmerRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 28, bottom: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerLoader(width: 28, height: 28, borderRadius: 100),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerLoader(width: 150, height: 15, borderRadius: 100),
                SizedBox(
                  height: 10,
                ),
                ShimmerLoader(width: 70, height: 15, borderRadius: 100),
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
        const ShimmerLoader(width: 160, height: 40, borderRadius: 50),
        const SizedBox(
          height: 17,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            ShimmerLoader(width: 135, height: 35, borderRadius: 50),
            SizedBox(
              width: 25,
            ),
            ShimmerLoader(width: 135, height: 35, borderRadius: 50),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: ShimmerLoader(width: 60, height: 15, borderRadius: 50),
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
