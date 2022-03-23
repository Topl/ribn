import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';

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
            color: const Color(0xffB1E7E1),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Image.asset(RibnAssets.fileCopyIcon),
                const SizedBox(width: 8),
                Text(
                  uploadedFileName,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: RibnColors.primary,
                  ),
                ),
                const Spacer(),
                Image.asset(RibnAssets.checkCircleIcon),
              ],
            ),
          )
        : const SizedBox();
  }
}
