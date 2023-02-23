import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';

import '../../utils/utils.dart';

class RibnFeedbackFileCard extends StatelessWidget {
  final XFile file;
  final String fileSize;
  final void Function()? onPressed;
  RibnFeedbackFileCard(
      {required this.file, required this.fileSize, this.onPressed});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: kIsWeb
              ? Image.network(file.path, width: 50, height: 50)
              : Image.file(
                  File(file.path),
                  width: 50,
                  height: 50,
                ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 130),
          child: Column(
            children: [
              Padding(
                child: RibnFont12TextWidget(
                    text: formatFileName(file.name),
                    textAlign: TextAlign.justify,
                    textColor: RibnColors.defaultText,
                    fontWeight: FontWeight.normal),
                padding: EdgeInsets.only(left: 10),
              ),
              Padding(
                child: RibnFont12TextWidget(
                    text:
                        "${(int.parse(fileSize) / (1024 * 1024)).toStringAsFixed(4)} Mb",
                    textAlign: TextAlign.justify,
                    textColor: RibnColors.defaultText,
                    fontWeight: FontWeight.normal),
                padding: EdgeInsets.only(left: 10),
              )
            ],
          ),
        ),
        Align(
          child: Padding(
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 15,
              ),
              onPressed: onPressed,
            ),
            padding: EdgeInsets.only(left: 2),
          ),
          alignment: Alignment.center,
        )
      ],
    );
  }
}
