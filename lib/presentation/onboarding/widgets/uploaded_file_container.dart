import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// A container that displays the uploaded file name, when restoring wallet with Topl Main Key.
///
class UploadedFileContainer extends StatelessWidget {
  /// The name of the uploaded file.
  final String uploadedFileName;

  /// The width of the container.
  final double width;

  /// The height of the container.
  final double height;

  const UploadedFileContainer({
    required this.uploadedFileName,
    this.width = 309,
    this.height = 35,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return uploadedFileName.isNotEmpty
        ? Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: RibnColors.primaryOffColor,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Image.asset(RibnAssets.fileCopyIcon),
                const SizedBox(width: 8),
                Text(
                  uploadedFileName,
                  style: RibnToolkitTextStyles.onboardingH3.copyWith(fontSize: 15),
                ),
                const Spacer(),
                Image.asset(RibnAssets.checkCircleIcon),
              ],
            ),
          )
        : const SizedBox();
  }
}
