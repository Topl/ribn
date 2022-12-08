import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font15_text_widget.dart';

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
            decoration: BoxDecoration(
              color: const Color(0xff979797).withOpacity(0.24),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Image.asset(RibnAssets.documentPng, width: 18),
                const SizedBox(width: 8),
              
              RibnFont15TextWidget(
                text:                   uploadedFileName,

                textColor: RibnColors.lightGreyTitle,
                textAlignment: TextAlign.center, fontWeight: FontWeight.w400,
                textHeight: 1.6,
              )
                ,
                const Spacer(),
                Image.asset(RibnAssets.checkCircleIcon, width: 20),
              ],
            ),
          )
        : const SizedBox();
  }
}
