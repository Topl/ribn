import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font10_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font13_text_widget.dart';

import '../../../../constants/strings.dart';

class RibnUploadFeedbackFileButton extends StatelessWidget {
  final void Function()? onTap;
  RibnUploadFeedbackFileButton({@required this.onTap});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: RibnFont13TextWidget(
                text: "Screenshot (Optional)",
                textAlign: TextAlign.justify,
                textColor: RibnColors.defaultText,
                fontWeight: FontWeight.w400),
          ),
          alignment: FractionalOffset.centerLeft,
        ),
        InkWell(
          child: Container(
            height: 40,
            width: 350,
            decoration: BoxDecoration(
                border: Border.all(
                  color: RibnColors.greyedOut.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Row(
              children: [
                Padding(
                  child: Container(
                    height: 30,
                    width: 325,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: RibnColors.lightGreyDivider.withOpacity(0.5)),
                    child: Center(
                      child: RibnFont10TextWidget(
                        text: Strings.uploadImage,
                        textAlign: TextAlign.center,
                        textColor: RibnColors.greyedOut,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                ),
              ],
            ),
          ),
          onTap: onTap,
        )
      ],
    );
  }
}
